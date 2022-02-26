import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stv_test_app/view/calendar/calendar_model.dart';
import 'package:stv_test_app/view/date_card_scroll_view/date_card_widget.dart';
import 'package:stv_test_app/view/date_card_scroll_view/date_list_index_state.dart';

class DateCardListview extends HookWidget {
  const DateCardListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _calendarModel = useProvider(calendarModelProvider);
    final _index = useProvider<int>(dateCardIndexProvider);

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _calendarModel.calendarDateList.length,
                itemBuilder: (context, index) => DateCardWidget(
                  calendarDate: _calendarModel.calendarDateList[index],
                ),
                initialScrollIndex: _index,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
