import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:persona/repository/repository.dart';
import 'package:persona/screens/eventList.dart';
import 'package:persona/controller/util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final LinkedHashMap<DateTime, List<Event>> babi = kEvents;
  List<Event> selectedEvents = [];
  List<dynamic> temp = [];

  List<Event> _getEventsForDay(DateTime day) {

    List<Event> events = kEvents[day] ?? [];
    events.sort((a, b) => a.time.compareTo(b.time)); // Sort by time

    final now = DateTime.now();
    events.sort((a, b) {
      final parta = a.time.split(':');
      final partb = b.time.split(':');
      DateTime x = DateTime(a.date.year, a.date.month, a.date.day,
          int.parse(parta[0]), int.parse(parta[1]));
      DateTime y = DateTime(b.date.year, b.date.month, b.date.day,
          int.parse(partb[0]), int.parse(partb[1]));

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

 Future _simpan(String event_id, String user_id) async {
    final success = await _simpanEvent(event_id, user_id);
    if (success) {
      setState(() {
        // Refresh the UI by fetching the updated data
        _get(id_user);
      });
    }
  }

  Future<bool> _simpanEvent(String event_id, String user_id) async {
    final response = await http.post(
      Uri.parse('http://10.10.6.70/api_pesona/create.php'),
      body: {
        "event_ids": event_id,
        "user_ids": user_id,
      },
    );

    if (response.statusCode == 200) {
      print("berhasil");
      return true;
    } else {
      print("salah");
      return false;
    }
  }

Future<List<dynamic>> _get(user_id) async {
  final response = await http.post(
    Uri.parse('http://10.10.6.70/api_pesona/read.php'),
    body: {
      "user_id": user_id,
    },
  );

  if (response.statusCode == 200) {
    temp = [];
    final data = json.decode(response.body);
    for (var item in data) {
      temp.add(item['event_id']);
    }
    
    return temp;
  } else {
    print("Error occurred: ${response.statusCode}");
    return [];
  }
}

Color getColor(String eventId, List<dynamic> temp) {
  return temp.contains(eventId) ? Colors.white : Colors.blue;
}
  @override
  void initState() {
    DateTime today = DateTime.now();
    super.initState();
    selectedEvents = _getEventsForDay(today);
    _get(id_user);
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
            FutureBuilder<List<dynamic>>(
              future: _get('$id_user'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error occurred: ${snapshot.error}"),
                  );
                } else {
                  temp = snapshot.data ?? [];
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: babi.length,
                    itemBuilder: (context, index) {
                      final date = babi.keys.elementAt(index);
                      final events = babi[date]!;
                      final nowtemp = DateTime.now();
                      DateTime now = DateTime(nowtemp.year, nowtemp.month, nowtemp.day);

                      return Column(
                        children: events.map((event) {
                          return GestureDetector(
                            onTap: () {
                              _simpan('${event.id}', '$id_user');
                              print("clicked");
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: getColor(event.id, temp),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${event.title}',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                    Text('Time: ${event.time}'),
                                    Text('Location: ${event.location}'),
                                    Text('Notes: ${event.notes}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                }
              },
            ),
            NotificationWidget(selectedEvents: selectedEvents),
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

    return Column();
  }
}

