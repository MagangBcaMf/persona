import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persona/screens/add_event_screen.dart';
import 'package:persona/repository/repository.dart';

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

  timeSignature(String babi){
     DateTime objekWaktu = DateFormat('HH:mm:ss').parse(babi);

    // Format objek waktu sesuai dengan format yang diinginkan
    String stringHasil = DateFormat('HH:mm').format(objekWaktu);
    return stringHasil;
  }

  bool isWithin30Minutes() {
    DateTime eventDateTime = DateTime(
      event.date.year,
      event.date.month,
      event.date.day,
      int.parse(event.time.split(':')[0]),
      int.parse(event.time.split(':')[1]),
    );
    DateTime nowPlus30Minutes = DateTime.now().add(Duration(minutes: 30));

    return eventDateTime.isBefore(nowPlus30Minutes);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
        color: isWithin30Minutes() ? Color.fromARGB(255, 238, 18, 2) : null,
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
            Text(
              'Time: ${timeSignature(event.time)}',
              style: TextStyle(
                fontWeight: isWithin30Minutes() ? FontWeight.bold : null,
                fontSize: isWithin30Minutes() ? 17 : null,
              ),
            ),
            Text('Location: ${event.location}'),
            Text('Reminder: ${event.reminder}'),
            Text('Notes: ${event.notes}'),
          ],
        ),
      ),
    );
  }
}
