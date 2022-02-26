import 'package:flutter/material.dart';

enum DayOfWeek {
  sunday,
  monday,
  tuesDay,
  wednesday,
  thursday,
  friday,
  saturday,
}

Map<DayOfWeek, String> day0fWeekLabel = {
  DayOfWeek.monday: '月',
  DayOfWeek.tuesDay: '火',
  DayOfWeek.wednesday: '水',
  DayOfWeek.thursday: '木',
  DayOfWeek.friday: '金',
  DayOfWeek.saturday: '土',
  DayOfWeek.sunday: '日',
};

Map<DayOfWeek, Color> dateColor = {
  DayOfWeek.monday: Colors.black,
  DayOfWeek.tuesDay: Colors.black,
  DayOfWeek.wednesday: Colors.black,
  DayOfWeek.thursday: Colors.black,
  DayOfWeek.friday: Colors.black,
  DayOfWeek.saturday: Colors.blue,
  DayOfWeek.sunday: Colors.deepOrange,
};

Map<int, String> numToWeekDay = {
  0: '月',
  1: '火',
  2: '水',
  3: '木',
  4: '金',
  5: '土',
  6: '日',
};
