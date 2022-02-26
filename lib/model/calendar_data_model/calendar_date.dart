import 'package:stv_test_app/service/db.dart';
import '../../common/convertor.dart';

class CalendarDate {
  CalendarDate({
    required this.year,
    required this.month,
    required this.day,
    required this.dayOfWeek,
    required this.isEnabled,
  });

  final int year;
  final int month;
  final int day;
  final DayOfWeek dayOfWeek;
  final bool isEnabled;
  final List<Schedule> schedules = [];
}
