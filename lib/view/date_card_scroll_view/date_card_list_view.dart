import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stv_test_app/view/calendar/calendar_model.dart';
import 'package:stv_test_app/view/date_card_scroll_view/date_card_widget.dart';
import 'package:stv_test_app/view/date_card_scroll_view/date_list_index_state.dart';

class DateCardListview extends ConsumerWidget {
  const DateCardListview({Key? key}) : super(key: key);

  static Route<Widget> route({bool? fullScreenDialog}) {
    return MaterialPageRoute<Widget>(
      builder: (_) => const DateCardListview(),
      fullscreenDialog: fullScreenDialog ?? false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _calendarModel = ref.watch(calendarModelProvider);
    final _index = ref.watch<int>(dateCardIndexProvider);

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  return;
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 80),
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: ScrollablePositionedList.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _calendarModel.calendarDateList.length,
                    itemBuilder: (context, index) => DateCardWidget(
                      calendarDate: _calendarModel.calendarDateList[index],
                    ),
                    initialScrollIndex: _index,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
