class Term {
  final beginning = DateTime(2022);
  final finish = DateTime(2030);

  List<DateTime> values() {
    final term = <DateTime>[];
    var t = beginning;

    while (t.year < finish.year) {
      term.add(t);
      if (t.month < 12) {
        final nextMonth = t.month + 1;
        t = DateTime(t.year, nextMonth);
      } else if (t.month == 12) {
        final nextYear = t.year + 1;
        t = DateTime(nextYear);
      }
    }

    return term;
  }
}
