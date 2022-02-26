import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'db.g.dart';

class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1)();
  TextColumn get comment => text().withLength(min: 1)();
  DateTimeColumn get day => dateTime()();
  BoolColumn get isAllDay => boolean().withDefault(const Constant(false))();
  DateTimeColumn? get start => dateTime().nullable()();
  DateTimeColumn? get end => dateTime().nullable()();
}

final dbProvider = Provider.autoDispose((ref) => AppDatabase());

@UseMoor(tables: [Schedules])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Stream<List<Schedule>> watchSchedules() => select(schedules).watch();

  Future<void> insertSchedule(SchedulesCompanion schedule) =>
      into(schedules).insert(schedule);

  Future<void> updateSchedule(
    int id,
    SchedulesCompanion schedule,
  ) {
    return (update(schedules)..where((it) => it.id.equals(id))).write(schedule);
  }

  Future<void> deleteSchedule(int id) =>
      (delete(schedules)..where((it) => it.id.equals(id))).go();
}
