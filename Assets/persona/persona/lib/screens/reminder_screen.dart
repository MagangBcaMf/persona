import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:persona/screens/add_event_screen.dart';
import 'package:persona/screens/eventList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:persona/repository/repository.dart';
import 'package:persona/screens/util.dart';
import 'dart:collection';
import 'package:intl/intl.dart';


class CalendarScreen extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<CalendarScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }


  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }


  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    List<Event> events = kEvents[day] ?? [];
    events.sort((a, b) => a.time.compareTo(b.time)); // Sort by time

    // Move events with past times to the bottom
    final now = DateTime.now();
    events.sort((a, b) {
      final parta = a.time.split(':');
      final partb = b.time.split(':');
      DateTime x = DateTime(a.date.year, a.date.month, a.date.day, int.parse(parta[0]), int.parse(parta[1]));
      DateTime y = DateTime(b.date.year, b.date.month, b.date.day, int.parse(partb[0]), int.parse(partb[1]));

      if (x.isBefore(now) && y.isBefore(now)) {
        return a.time.compareTo(b.time);
      } else if (x.isBefore(now)) {
        return 1; // Move a to the bottom
      } else if (y.isBefore(now)) {
        return -1; // Move b to the bottom
      } else {
        return a.time.compareTo(b.time);
      }
    });

    return events;
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);
    List<Event> events = [];

    for (final d in days) {
      events.addAll(_getEventsForDay(d));
    }

    events.sort((a, b) => a.time.compareTo(b.time)); // Sort by time



    // Move events with past times to the bottom
    final now = DateTime.now(); 
    events.sort((a, b) {
      DateTime x = DateTime.parse(a.time);
      DateTime y = DateTime.parse(b.time);
      if (x.isBefore(now) && y.isBefore(now)) {
        return a.time.compareTo(b.time);
      } else if (x.isBefore(now)) {
        return 1; // Move a to the bottom
      } else if (y.isBefore(now)) {
        return -1; // Move b to the bottom
      } else {
        return a.time.compareTo(b.time);
      }
    });

    return events;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          Navigator.pushNamed(context, '/reminder');
          break;
        case 2:
          Navigator.pushNamed(context, '/learning');
          break;
        case 3:
          Navigator.pushNamed(context, '/profile');
          break;
      }
    }
  }

  Widget BottomNavBar() {
    return CustomLineIndicatorBottomNavbar(
      selectedColor: Color(0xff7da0ca),
      unSelectedColor: Colors.black54,
      backgroundColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      enableLineIndicator: true,
      lineIndicatorWidth: 3,
      indicatorType: IndicatorType.Top,
      customBottomBarItems: [
        CustomBottomBarItems(
          label: 'Home',
          icon: Icons.home,
        ),
        CustomBottomBarItems(
          label: 'Reminder',
          icon: CupertinoIcons.bell_fill,
        ),
        CustomBottomBarItems(
          label: 'Learning',
          icon: CupertinoIcons.book_solid,
        ),
        CustomBottomBarItems(
          label: 'Profile',
          icon: Icons.person_rounded,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('personA'),
        centerTitle: true,
        backgroundColor: Color(0xff7da0ca),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index].title}'),
                        title: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: '${value[index].title}\n',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              TextSpan(
                                text: 'Time: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '${value[index].time}\n',
                                // Tambahkan gaya teks lainnya jika diperlukan
                              ),
                              TextSpan(
                                text: 'Location: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '${value[index].location}\n',
                                // Tambahkan gaya teks lainnya jika diperlukan
                              ),
                              TextSpan(
                                text: 'Notes: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '${value[index].notes}',
                                // Tambahkan gaya teks lainnya jika diperlukan
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff7da0ca),
        onPressed: () async {
          Event? newEvent = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEventScreen(selectedDay: _focusedDay)),
          );
          if(newEvent != null){
            DateTime eventDate = DateTime(
              newEvent.date.year,
              newEvent.date.month,
              newEvent.date.day,
            );

            setState(() {
              DateTime eventDate = DateTime(
                newEvent.date.year,
                newEvent.date.month,
                newEvent.date.day,
              );

              if (kEvents.containsKey(eventDate)) {
                bool eventExists = kEvents[eventDate]!.any((event) =>
                    event.time == newEvent.time &&
                    event.title == newEvent.title &&
                    event.location == newEvent.location &&
                    event.reminder == newEvent.reminder &&
                    event.notes == newEvent.notes);

                if (!eventExists) {
                  kEvents[eventDate]!.add(newEvent);
                }
              } else {
                kEvents[eventDate] = [newEvent];
              }
            });
          }
        },
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          SizedBox(
            width: 120.0,
            child: Text(
              headerText,
              style: TextStyle(fontSize: 26.0),
            ),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, size: 20.0),
            visualDensity: VisualDensity.compact,
            onPressed: onTodayButtonTap,
          ),
          if (clearButtonVisible)
            IconButton(
              icon: Icon(Icons.clear, size: 20.0),
              visualDensity: VisualDensity.compact,
              onPressed: onClearButtonTap,
            ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}

  

  


