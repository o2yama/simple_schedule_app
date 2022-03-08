import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stv_test_app/common/convertor.dart';
import 'package:stv_test_app/model/calendar_data_model/calendar_date.dart';
import 'package:stv_test_app/model/calendar_data_model/calendar_week.dart';

final calendarModelProvider = ChangeNotifierProvider((ref) => CalendarModel());

class CalendarModel extends ChangeNotifier {
  CalendarModel() {
    initialize();
  }

  late int currentPage;
  late PageController pageController;
  late DateTime targetMonth;
  List<CalendarWeek> calendarWeekList = [];
  List<CalendarDate> calendarDateList = [];
  bool isDateSlideShow = false;

  void initialize() {
    final now = DateTime.now();
    targetMonth = now;
    currentPage = int.parse(DateFormat('yyyyMM').format(now));
    pageController = PageController(initialPage: currentPage);
    generateCalendarDates();
  }

  void selectMonth(DateTime selectedDate) {
    final page = int.parse(DateFormat('yyyyMM').format(selectedDate));
    currentPage = page;
    targetMonth = DateTime(selectedDate.year, selectedDate.month);
    generateCalendarDates();
  }

  //先月へ
  void movePreviousMonth() {
    currentPage--;
    targetMonth = DateTime(targetMonth.year, targetMonth.month - 1);
    generateCalendarDates();
  }

  //来月へ
  void moveNextMonth() {
    currentPage++;
    targetMonth = DateTime(targetMonth.year, targetMonth.month + 1);
    generateCalendarDates();
  }

  // 今日に移動
  void moveCurrentDate() {
    pageController
        .jumpToPage(int.parse(DateFormat('yyyyMM').format(DateTime.now())));
    currentPage = int.parse(DateFormat('yyyyMM').format(DateTime.now()));
    targetMonth = DateTime.now();
    generateCalendarDates();
  }

  bool isToday(CalendarDate calendarDate) {
    final now = DateTime.now();
    return now.year == calendarDate.year &&
        now.month == calendarDate.month &&
        now.day == calendarDate.day;
  }

  ///以下カレンダーの生成
  // 前月の日を埋めるリスト
  List<CalendarDate> prevPaddingDays() {
    final year = targetMonth.year;
    final month = targetMonth.month;
    final list = <CalendarDate>[];
    final firstDay = DateTime(year, month).weekday;
    //月曜スタートだから-1
    final paddingDayCount = (firstDay + 7 - 1) % 7;
    final prevLastDate = DateTime(year, month, 0).day;
    for (var day = prevLastDate - paddingDayCount + 1;
        day < prevLastDate + 1;
        day++) {
      list.add(
        CalendarDate(
          year: year,
          month: DateTime(year, month - 1).month,
          day: day,
          dayOfWeek:
              DayOfWeek.values[(DateTime(year, month - 1, day).weekday % 7)],
          isEnabled: false,
        ),
      );
    }
    return list;
  }

  // 今月の日にちリスト
  List<CalendarDate> currentDays() {
    final year = targetMonth.year;
    final month = targetMonth.month;
    final list = <CalendarDate>[];
    final lastDate = DateTime(year, month + 1, 0);
    final currentDayCount = lastDate.day;
    for (var day = 1; day < currentDayCount + 1; day++) {
      list.add(CalendarDate(
        year: year,
        month: month,
        day: day,
        dayOfWeek: DayOfWeek.values[(DateTime(year, month, day).weekday % 7)],
        isEnabled: true,
      ));
    }
    return list;
  }

  // 来月の日を埋めるリスト
  List<CalendarDate> nextPaddingDays(
    List<CalendarDate> prevList,
    List<CalendarDate> currentList,
  ) {
    final year = targetMonth.year;
    final month = targetMonth.month;
    final list = <CalendarDate>[];
    final paddingDayCount = (42 - (prevList.length + currentList.length)) % 7;
    for (var day = 1; day < paddingDayCount + 1; day++) {
      list.add(
        CalendarDate(
          year: year,
          month: DateTime(year, month + 1).month,
          day: day,
          dayOfWeek:
              DayOfWeek.values[(DateTime(year, month + 1, day).weekday % 7)],
          isEnabled: false,
        ),
      );
    }
    return list;
  }

  void generateCalendarDates() {
    final prevList = prevPaddingDays();
    final currentList = currentDays();
    final nextList = nextPaddingDays(prevList, currentList);

    calendarDateList = [...prevList, ...currentList, ...nextList];
    calendarWeekList = changeToWeekList(calendarDateList);
    notifyListeners();
  }

  // DateのListをWeekのListに変換
  List<CalendarWeek> changeToWeekList(List<CalendarDate> dateList) {
    final weekList = <CalendarWeek>[];

    final firstWeek = <CalendarDate>[];
    final secondWeek = <CalendarDate>[];
    final thirdWeek = <CalendarDate>[];
    final forthWeek = <CalendarDate>[];
    final fifthWeek = <CalendarDate>[];
    final sixWeek = <CalendarDate>[];
    for (var i = 0; i < dateList.length; i++) {
      if (i < 7) {
        firstWeek.add(dateList[i]);
      } else if (i < 14) {
        secondWeek.add(dateList[i]);
      } else if (i < 21) {
        thirdWeek.add(dateList[i]);
      } else if (i < 28) {
        forthWeek.add(dateList[i]);
      } else if (i < 35) {
        fifthWeek.add(dateList[i]);
      } else {
        sixWeek.add(dateList[i]);
      }
      weekList
        ..add(CalendarWeek(days: firstWeek))
        ..add(CalendarWeek(days: secondWeek))
        ..add(CalendarWeek(days: thirdWeek))
        ..add(CalendarWeek(days: forthWeek))
        ..add(CalendarWeek(days: fifthWeek))
        ..add(CalendarWeek(days: sixWeek));
    }
    return weekList;
  }
}
