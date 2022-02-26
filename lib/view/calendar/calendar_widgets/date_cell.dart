import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stv_test_app/common/convertor.dart';
import 'package:stv_test_app/model/calendar_data_model/calendar_date.dart';
import 'package:stv_test_app/service/db.dart';
import 'package:stv_test_app/view/calendar/calendar_model.dart';
import 'package:stv_test_app/view/date_card_scroll_view/date_card_list_view.dart';
import 'package:stv_test_app/view/date_card_scroll_view/date_list_index_state.dart';

class DateCell extends HookWidget {
  DateCell({
    Key? key,
    required this.calendarDate,
    required this.allSchedules,
  }) : super(key: key) {
    calendarDate.schedules.clear();
    //渡ってきた全ての予定から、この日の予定のみを取得
    for (final schedule in allSchedules) {
      final _calendarDay =
          DateTime(calendarDate.year, calendarDate.month, calendarDate.day);
      final scheduleDay =
          DateTime(schedule.day.year, schedule.day.month, schedule.day.day);
      if (scheduleDay == _calendarDay) {
        calendarDate.schedules.add(schedule);
      }
    }
  }

  final List<Schedule> allSchedules;
  final CalendarDate calendarDate;

  @override
  Widget build(BuildContext context) {
    final _calendarModel = useProvider(calendarModelProvider);
    final _indexController = useProvider(dateCardIndexProvider.notifier);

    Color dateColor() {
      if (!calendarDate.isEnabled) {
        return Colors.grey[300]!;
      } else if (calendarDate.dayOfWeek == DayOfWeek.saturday) {
        return Colors.blue;
      } else if (calendarDate.dayOfWeek == DayOfWeek.sunday) {
        return Colors.red;
      } else {
        return Colors.black;
      }
    }

    return Expanded(
      child: InkWell(
        onTap: () async {
          _indexController.setIndex(
            _calendarModel.calendarDateList,
            calendarDate,
          );
          await showDialog<Widget>(
            context: context,
            builder: (context) => const DateCardListview(),
          );
        },
        child: SizedBox(
          height: 70,
          child: Ink(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _calendarModel.isToday(calendarDate)
                    ? Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: dateColor()),
                        ),
                        child: Center(
                          child: Text(
                            calendarDate.day.toString(),
                            style: TextStyle(
                              color: dateColor(),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 40,
                        child: Center(
                          child: Text(
                            calendarDate.day.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: dateColor(),
                            ),
                          ),
                        ),
                      ),
                calendarDate.schedules.isNotEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(8),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.grey,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
