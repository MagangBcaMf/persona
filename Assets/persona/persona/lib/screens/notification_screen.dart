import 'package:flutter/material.dart';
import 'package:persona/repository/repository.dart';
import 'package:persona/screens/eventList.dart';
import 'package:persona/screens/util.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Event> selectedEvents = [];

  // Future<void> initializeSelectedEvents() async {
  //   try {
  //     Map<DateTime, List<Event>> events = await Repository.fetchEvents();
  //     setState(() {
  //       selectedEvents = events;
  //     });
  //   } catch (e) {
  //     print('Error initializing selectedEvents: $e');
  //   }
  // }

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


  @override
  void initState() {
    DateTime today = DateTime.now();
    super.initState();
    selectedEvents = _getEventsForDay(today);
    print('testes:${selectedEvents}');
    // initializeSelectedEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("personA"),
        backgroundColor: const Color(0xff7da0ca),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10), // Left, Top, Right, Bottom
            ),
            NotificationWidget(selectedEvents: selectedEvents),
            // print(selectedEvents);
          ],
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final List<Event> selectedEvents;

  const NotificationWidget({Key? key, required this.selectedEvents})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now().toLocal();
    final dateNowOnlyDate = DateTime(dateNow.year, dateNow.month, dateNow.day);

    return Column(
      
    );
  
  }
}
//       children: selectedEvents.li{
//         final date = entry.key;
//         final events = entry.value;

//         final dateOnly = DateTime(date.year, date.month, date.day);


//         if (dateOnly == dateNowOnlyDate) {
//           final now = DateTime.now();
//           events.sort((a, b) => a.time.compareTo(b.time)); // Sort events by time
//           final filteredEvents = events.where((event) {
//             final eventDateTime = DateTime(
//               date.year,
//               date.month,
//               date.day,
//               int.parse(event.time.split(':')[0]),
//               int.parse(event.time.split(':')[1]),
//             );
//             return eventDateTime.isAfter(now);
//           }).toList();

//           return EventListWidget(events: filteredEvents);
//         } else {
//           return SizedBox();
//         }
//       }).toList(),
//     );
//   }
// }
