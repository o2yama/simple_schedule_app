import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stv_test_app/common/app_theme.dart';
import 'package:stv_test_app/common/convertor.dart';
import 'package:stv_test_app/model/calendar_data_model/term.dart';
import 'package:stv_test_app/view/calendar/calendar_model.dart';

class CalendarHeader extends HookWidget {
  const CalendarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _calendarModel = useProvider(calendarModelProvider);

    return Column(
      children: [
        Container(
          color: CupertinoColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _monthText(_calendarModel),
              _toTodayButton(_calendarModel.moveCurrentDate),
            ],
          ),
        ),
        _dateOfWeekLabel(context),
      ],
    );
  }

  Widget _monthText(CalendarModel calendarModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<DateTime>(
        initialValue: calendarModel.targetMonth,
        itemBuilder: (context) => Term()
            .values()
            .map(
              (date) => PopupMenuItem<DateTime>(
                onTap: () {
                  calendarModel.selectMonth(date);
                },
                child: SizedBox(
                  width: 100,
                  height: 30,
                  child: Text(
                    DateFormat('yyyy年MM月').format(date),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        child: Row(
          children: [
            Text(
              DateFormat('yyyy年MM月 ').format(
                calendarModel.targetMonth,
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toTodayButton(VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(width: 1, color: Colors.grey[300]!),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          '今日',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _dateOfWeekLabel(BuildContext context) {
    return Container(
      height: 30,
      color: AppTheme.backGroundColor,
      child: Row(
        children: day0fWeekLabel.keys
            .map(
              (date) => SizedBox(
                width: MediaQuery.of(context).size.width / 7,
                child: Center(
                  child: Text(
                    day0fWeekLabel[date]!,
                    style: TextStyle(color: dateColor[date]),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
