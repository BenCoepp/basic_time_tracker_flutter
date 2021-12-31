import 'package:flutter/material.dart';

class Item {
  late String date;
  late String day;
  late double time;

  Item({
    required this.date,
    required this.day,
    required this.time,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      date: json['date'],
      day: json['day'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'day': day,
        'time': time,
      };
}
