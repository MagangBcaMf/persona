import 'package:flutter/material.dart';
import 'package:persona/screens/add_event_screen.dart';

class EventListWidget extends StatelessWidget {
  final List<Event> events;

  const EventListWidget({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: events.map((event) {
        return EventWidget(event: event);
      }).toList(),
    );
  }
}

class EventWidget extends StatelessWidget {
  final Event event;

  const EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          event.title.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time: ${event.time}'),
            Text('Location: ${event.location}'),
            Text('Reminder: ${event.reminder}'),
            Text('Notes: ${event.notes}'),
          ],
        ),
      ),
    );
  }
}
