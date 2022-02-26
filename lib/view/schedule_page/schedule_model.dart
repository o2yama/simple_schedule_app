import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stv_test_app/service/db.dart';
import 'package:stv_test_app/view/schedule_page/schedule_page.dart';

final scheduleModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) => ScheduleModel(),
);

class ScheduleModel extends ChangeNotifier {
  bool isEdited = false;
  bool isAllDay = false;
  Color buttonTextColor = Colors.grey[300]!;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();

  void startEditing() {
    isEdited = false;
    notifyListeners();
  }

  void onTextFieldChanged() {
    titleController.text.isNotEmpty && commentController.text.isNotEmpty
        ? buttonTextColor = Colors.black
        : buttonTextColor = Colors.grey[300]!;
    isEdited = true;
    notifyListeners();
  }

  void clearText() {
    titleController.clear();
    commentController.clear();
  }

  void setSchedule(Schedule schedule) {
    titleController.text = schedule.title;
    commentController.text = schedule.comment;
    isAllDay = schedule.isAllDay;
    if (!isAllDay) {
      start = schedule.start!;
      end = schedule.end!;
    }
    onTextFieldChanged();
    notifyListeners();
  }

  void changeIsAllDay() {
    if (isAllDay) {
      isAllDay = false;
    } else {
      isAllDay = true;
    }
    notifyListeners();
  }

  void onStartSelected(DateTime date) {
    start = date;
    notifyListeners();
  }

  void onEndSelected(DateTime date) {
    end = date;
    notifyListeners();
  }

  String startTimeText() {
    return isAllDay
        ? DateFormat('yyyy/MM/dd').format(start)
        : DateFormat('yyyy/MM/dd HH:mm').format(start);
  }

  String endTimeText() {
    return isAllDay
        ? DateFormat('yyyy/MM/dd').format(end)
        : DateFormat('yyyy/MM/dd HH:mm').format(end);
  }

  void validateText() {
    if (titleController.text == '') {
      throw Exception('タイトルを入力してください。');
    } else if (commentController.text == '') {
      throw Exception('コメントを入力してください。');
    }
  }
}
