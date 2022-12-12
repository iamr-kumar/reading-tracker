import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Timestamp toTimestamp(TimeOfDay time) {
  final now = DateTime(2023, 1, 1);
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return Timestamp.fromDate(dt);
}

TimeOfDay fromTimestamp(Timestamp timestamp) {
  final dt =
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  return TimeOfDay(hour: dt.hour, minute: dt.minute);
}