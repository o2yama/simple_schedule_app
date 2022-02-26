import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stv_test_app/model/calendar_data_model/calendar_date.dart';

final dateCardIndexProvider = StateNotifierProvider<DateCardIndexState, int>(
  (ref) => DateCardIndexState(),
);

class DateCardIndexState extends StateNotifier<int> {
  DateCardIndexState() : super(0);

  void setIndex(
    List<CalendarDate> calendarDateList,
    CalendarDate calendarDate,
  ) {
    calendarDateList.asMap().forEach(
      (index, value) {
        if (calendarDate == value) {
          state = index;
        }
      },
    );
  }
}
