import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:stv_test_app/common/app_theme.dart';
import 'package:stv_test_app/service/db.dart';
import 'package:stv_test_app/view/common/loading_view.dart';
import 'package:stv_test_app/view/schedule_page/schedule_arguments.dart';
import 'schedule_model.dart';

final titleController = TextEditingController();
final commentController = TextEditingController();

class SchedulePage extends HookWidget {
  const SchedulePage({required this.arguments, Key? key}) : super(key: key);
  final ScheduleArguments arguments;

  @override
  Widget build(BuildContext context) {
    final _db = useProvider(dbProvider);
    final _scheduleModel = useProvider(scheduleModelProvider);
    final _isLoading = useProvider(loadingState);
    final _loadingController = useProvider(loadingState.notifier);

    Widget _backButton() {
      return IconButton(
        onPressed: () async {
          if (_scheduleModel.isEdited) {
            await showCupertinoModalPopup<Widget>(
              context: context,
              builder: (context) {
                return CupertinoActionSheet(
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('編集を破棄'),
                    )
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('キャンセル'),
                  ),
                );
              },
            );
          } else {
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.clear),
      );
    }

    Widget _titleField() {
      return Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            onChanged: (text) => _scheduleModel.onTextFieldChanged(),
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'タイトルを入力してください',
              border: InputBorder.none,
            ),
            minLines: 1,
            maxLines: 1,
          ),
        ),
      );
    }

    Widget _bottomPicker(Widget picker) {
      return Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6),
        color: CupertinoColors.white,
        child: DefaultTextStyle(
          style: const TextStyle(
            color: CupertinoColors.black,
            fontSize: 22,
          ),
          child: SafeArea(top: false, child: picker),
        ),
      );
    }

    Widget _isAllDaySwitch() {
      return ListTile(
        tileColor: Colors.white,
        title: const Text('終日'),
        trailing: Switch.adaptive(
          value: _scheduleModel.isAllDay,
          onChanged: (bool value) => _scheduleModel.changeIsAllDay(),
        ),
      );
    }

    Widget _startTimeTile() {
      return ListTile(
        onTap: () async {
          await showCupertinoModalPopup<Widget>(
            context: context,
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoButton(
                          onPressed: () => Navigator.pop(context),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          child: const Text('完了'),
                        )
                      ],
                    ),
                  ),
                  _bottomPicker(
                    CupertinoDatePicker(
                      mode: _scheduleModel.isAllDay
                          ? CupertinoDatePickerMode.date
                          : CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: _scheduleModel.start,
                      onDateTimeChanged: _scheduleModel.onStartSelected,
                      use24hFormat: true,
                    ),
                  ),
                ],
              );
            },
          );
        },
        tileColor: Colors.white,
        title: const Text('開始'),
        trailing: Text(_scheduleModel.startTimeText()),
      );
    }

    Widget _endTimeTile() {
      return ListTile(
        onTap: () async {
          await showCupertinoModalPopup<Widget>(
            context: context,
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          child: const Text('完了'),
                        )
                      ],
                    ),
                  ),
                  _bottomPicker(
                    CupertinoDatePicker(
                      mode: _scheduleModel.isAllDay
                          ? CupertinoDatePickerMode.date
                          : CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: _scheduleModel.end,
                      onDateTimeChanged: _scheduleModel.onEndSelected,
                      use24hFormat: true,
                    ),
                  ),
                ],
              );
            },
          );
        },
        tileColor: Colors.white,
        title: const Text('終了'),
        trailing: Text(_scheduleModel.endTimeText()),
      );
    }

    Widget _commentField() {
      return Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            onChanged: (text) => _scheduleModel.onTextFieldChanged(),
            controller: commentController,
            decoration: const InputDecoration(
              hintText: 'コメントを入力してください',
              border: InputBorder.none,
            ),
            minLines: 5,
            maxLines: 100,
          ),
        ),
      );
    }

    Widget _deleteButton() {
      return Container(
        height: 50,
        decoration: const BoxDecoration(color: Colors.white),
        child: const Center(
          child: Text(
            'この予定を削除',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    Widget _storeButton() {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppTheme.backGroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () async {
            try {
              _scheduleModel.validateText();
              _loadingController.startLoading();
              if (arguments.schedule == null) {
                //insertの時
                _scheduleModel.isAllDay
                    ? await _db.insertSchedule(
                        SchedulesCompanion(
                          title: moor.Value(titleController.text),
                          comment: moor.Value(commentController.text),
                          day: moor.Value(_scheduleModel.start),
                          isAllDay: moor.Value(_scheduleModel.isAllDay),
                        ),
                      )
                    : await _db.insertSchedule(
                        SchedulesCompanion(
                          title: moor.Value(titleController.text),
                          comment: moor.Value(commentController.text),
                          day: moor.Value(_scheduleModel.start),
                          isAllDay: moor.Value(_scheduleModel.isAllDay),
                          start: moor.Value(_scheduleModel.start),
                          end: moor.Value(_scheduleModel.end),
                        ),
                      );
              } else if (arguments.schedule != null) {
                //updateの時
                _scheduleModel.isAllDay
                    ? await _db.updateSchedule(
                        arguments.schedule!.id,
                        SchedulesCompanion(
                          title: moor.Value(titleController.text),
                          comment: moor.Value(commentController.text),
                          day: moor.Value(_scheduleModel.start),
                          isAllDay: moor.Value(_scheduleModel.isAllDay),
                        ),
                      )
                    : await _db.updateSchedule(
                        arguments.schedule!.id,
                        SchedulesCompanion(
                          title: moor.Value(titleController.text),
                          comment: moor.Value(commentController.text),
                          day: moor.Value(_scheduleModel.start),
                          isAllDay: moor.Value(_scheduleModel.isAllDay),
                          start: moor.Value(_scheduleModel.start),
                          end: moor.Value(_scheduleModel.end),
                        ),
                      );
              }
              _loadingController.endLoading();
              await showDialog<Widget>(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('保存しました。'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    )
                  ],
                ),
              );
              titleController.clear();
              commentController.clear();
            } on Exception catch (e) {
              _loadingController.endLoading();
              debugPrint(e.toString());
            }
          },
          child: Text(
            '保存',
            style: TextStyle(color: _scheduleModel.buttonTextColor),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: AppTheme.backGroundColor,
        appBar: AppBar(
            leading: _backButton(),
            title: Text(arguments.schedule == null ? '予定の追加' : '予定の編集'),
            actions: [_storeButton()]),
        body: _isLoading
            ? const LoadingView()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _titleField(),
                        const SizedBox(height: 24),
                        _startTimeTile(),
                        const Divider(height: 1, color: Colors.grey),
                        _endTimeTile(),
                        const Divider(height: 1, color: Colors.grey),
                        _isAllDaySwitch(),
                        const SizedBox(height: 8),
                        _commentField(),
                        const SizedBox(height: 24),
                        arguments.schedule != null
                            ? _deleteButton()
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
