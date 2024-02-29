import 'package:flutter/foundation.dart';

class Event {
  final String title;
  Event({required this.title});

  get date => null;

  String toString() => this.title;
}
