import 'package:flutter/cupertino.dart';
import 'package:stv_test_app/model/calendar_data_model/calendar_week.dart';
import 'package:stv_test_app/repository/db.dart';
import 'date_cell.dart';

class WeekRow extends StatelessWidget {
  const WeekRow({
    required this.calendarWeek,
    required this.allSchedules,
    Key? key,
  }) : super(key: key);

  final CalendarWeek calendarWeek;
  final List<Schedule> allSchedules;

  static const int monday = 0;
  static const int tuesday = 1;
  static const int wednesday = 2;
  static const int thursday = 3;
  static const int friday = 4;
  static const int saturday = 5;
  static const int sunday = 6;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            DateCell(
              calendarDate: calendarWeek.days![monday],
              allSchedules: allSchedules,
            ),
            DateCell(
              calendarDate: calendarWeek.days![tuesday],
              allSchedules: allSchedules,
            ),
            DateCell(
              calendarDate: calendarWeek.days![wednesday],
              allSchedules: allSchedules,
            ),
            DateCell(
              calendarDate: calendarWeek.days![thursday],
              allSchedules: allSchedules,
            ),
            DateCell(
              calendarDate: calendarWeek.days![friday],
              allSchedules: allSchedules,
            ),
            DateCell(
              calendarDate: calendarWeek.days![saturday],
              allSchedules: allSchedules,
            ),
            DateCell(
              calendarDate: calendarWeek.days![sunday],
              allSchedules: allSchedules,
            ),
          ],
        ),
      ],
    );
  }
}
