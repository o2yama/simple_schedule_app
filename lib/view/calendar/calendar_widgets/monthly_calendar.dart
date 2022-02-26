import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stv_test_app/model/calendar_data_model/calendar_week.dart';
import 'package:stv_test_app/service/db.dart';
import 'package:stv_test_app/view/calendar/calendar_widgets/week_row.dart';
import 'package:stv_test_app/view/common/loading_view.dart';

class MonthlyCalendar extends HookWidget {
  const MonthlyCalendar({required this.calendarWeekList, Key? key})
      : super(key: key);

  final List<CalendarWeek> calendarWeekList;

  static const firstWeek = 0;
  static const secondWeek = 1;
  static const thirdWeek = 2;
  static const forthWeek = 3;
  static const fifthWeek = 4;
  static const sixWeek = 5;

  @override
  Widget build(BuildContext context) {
    final _db = useProvider(dbProvider);

    return StreamBuilder(
      stream: _db.watchSchedules(),
      builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        } else if (calendarWeekList.isEmpty) {
          return const Center(
            child: Text('カレンダーの取得に失敗しました。'),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WeekRow(
                calendarWeek: calendarWeekList[firstWeek],
                allSchedules: snapshot.data!,
              ),
              WeekRow(
                calendarWeek: calendarWeekList[secondWeek],
                allSchedules: snapshot.data!,
              ),
              WeekRow(
                calendarWeek: calendarWeekList[thirdWeek],
                allSchedules: snapshot.data!,
              ),
              WeekRow(
                calendarWeek: calendarWeekList[forthWeek],
                allSchedules: snapshot.data!,
              ),
              calendarWeekList[fifthWeek].days!.isEmpty
                  ? Container()
                  : WeekRow(
                      calendarWeek: calendarWeekList[fifthWeek],
                      allSchedules: snapshot.data!,
                    ),
              calendarWeekList[sixWeek].days!.isEmpty
                  ? Container()
                  : WeekRow(
                      calendarWeek: calendarWeekList[sixWeek],
                      allSchedules: snapshot.data!,
                    ),
            ],
          );
        }
      },
    );
  }
}
