import 'package:flutter/material.dart';
import 'package:persona/repository/repository.dart';
import 'package:persona/screens/eventList.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Map<DateTime, List<Event>> selectedEvents = {};

  Future<void> initializeSelectedEvents() async {
    try {
      Map<DateTime, List<Event>> events = await Repository.fetchEvents();
      setState(() {
        selectedEvents = events;
      });
    } catch (e) {
      print('Error initializing selectedEvents: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    initializeSelectedEvents();
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
            NotificationWidget(selectedEvents: selectedEvents),
          ],
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final Map<DateTime, List<Event>> selectedEvents;

  const NotificationWidget({Key? key, required this.selectedEvents})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now().toLocal();
    final dateNowOnlyDate = DateTime(dateNow.year, dateNow.month, dateNow.day);

    return Column(
      children: selectedEvents.entries.map((entry) {
        final date = entry.key;
        final events = entry.value;

        final dateOnly = DateTime(date.year, date.month, date.day);

        if (dateOnly == dateNowOnlyDate) {
          return EventListWidget(events: events);
        } else {
          return SizedBox();
        }
      }).toList(),
    );
  }
}
