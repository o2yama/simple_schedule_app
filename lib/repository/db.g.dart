// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Schedule extends DataClass implements Insertable<Schedule> {
  final int id;
  final String title;
  final String comment;
  final DateTime day;
  final bool isAllDay;
  final DateTime? start;
  final DateTime? end;
  Schedule(
      {required this.id,
      required this.title,
      required this.comment,
      required this.day,
      required this.isAllDay,
      this.start,
      this.end});
  factory Schedule.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Schedule(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      comment: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}comment'])!,
      day: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}day'])!,
      isAllDay: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_all_day'])!,
      start: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}start']),
      end: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}end']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['comment'] = Variable<String>(comment);
    map['day'] = Variable<DateTime>(day);
    map['is_all_day'] = Variable<bool>(isAllDay);
    if (!nullToAbsent || start != null) {
      map['start'] = Variable<DateTime?>(start);
    }
    if (!nullToAbsent || end != null) {
      map['end'] = Variable<DateTime?>(end);
    }
    return map;
  }

  SchedulesCompanion toCompanion(bool nullToAbsent) {
    return SchedulesCompanion(
      id: Value(id),
      title: Value(title),
      comment: Value(comment),
      day: Value(day),
      isAllDay: Value(isAllDay),
      start:
          start == null && nullToAbsent ? const Value.absent() : Value(start),
      end: end == null && nullToAbsent ? const Value.absent() : Value(end),
    );
  }

  factory Schedule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Schedule(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      comment: serializer.fromJson<String>(json['comment']),
      day: serializer.fromJson<DateTime>(json['day']),
      isAllDay: serializer.fromJson<bool>(json['isAllDay']),
      start: serializer.fromJson<DateTime?>(json['start']),
      end: serializer.fromJson<DateTime?>(json['end']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'comment': serializer.toJson<String>(comment),
      'day': serializer.toJson<DateTime>(day),
      'isAllDay': serializer.toJson<bool>(isAllDay),
      'start': serializer.toJson<DateTime?>(start),
      'end': serializer.toJson<DateTime?>(end),
    };
  }

  Schedule copyWith(
          {int? id,
          String? title,
          String? comment,
          DateTime? day,
          bool? isAllDay,
          DateTime? start,
          DateTime? end}) =>
      Schedule(
        id: id ?? this.id,
        title: title ?? this.title,
        comment: comment ?? this.comment,
        day: day ?? this.day,
        isAllDay: isAllDay ?? this.isAllDay,
        start: start ?? this.start,
        end: end ?? this.end,
      );
  @override
  String toString() {
    return (StringBuffer('Schedule(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('day: $day, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('start: $start, ')
          ..write('end: $end')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              comment.hashCode,
              $mrjc(
                  day.hashCode,
                  $mrjc(isAllDay.hashCode,
                      $mrjc(start.hashCode, end.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Schedule &&
          other.id == this.id &&
          other.title == this.title &&
          other.comment == this.comment &&
          other.day == this.day &&
          other.isAllDay == this.isAllDay &&
          other.start == this.start &&
          other.end == this.end);
}

class SchedulesCompanion extends UpdateCompanion<Schedule> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> comment;
  final Value<DateTime> day;
  final Value<bool> isAllDay;
  final Value<DateTime?> start;
  final Value<DateTime?> end;
  const SchedulesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.comment = const Value.absent(),
    this.day = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
  });
  SchedulesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String comment,
    required DateTime day,
    this.isAllDay = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
  })  : title = Value(title),
        comment = Value(comment),
        day = Value(day);
  static Insertable<Schedule> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? comment,
    Expression<DateTime>? day,
    Expression<bool>? isAllDay,
    Expression<DateTime?>? start,
    Expression<DateTime?>? end,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (comment != null) 'comment': comment,
      if (day != null) 'day': day,
      if (isAllDay != null) 'is_all_day': isAllDay,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
    });
  }

  SchedulesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? comment,
      Value<DateTime>? day,
      Value<bool>? isAllDay,
      Value<DateTime?>? start,
      Value<DateTime?>? end}) {
    return SchedulesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      day: day ?? this.day,
      isAllDay: isAllDay ?? this.isAllDay,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (isAllDay.present) {
      map['is_all_day'] = Variable<bool>(isAllDay.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime?>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<DateTime?>(end.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('day: $day, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('start: $start, ')
          ..write('end: $end')
          ..write(')'))
        .toString();
  }
}

class $SchedulesTable extends Schedules
    with TableInfo<$SchedulesTable, Schedule> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SchedulesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title =
      GeneratedColumn<String?>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  final VerificationMeta _commentMeta = const VerificationMeta('comment');
  late final GeneratedColumn<String?> comment =
      GeneratedColumn<String?>('comment', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  final VerificationMeta _dayMeta = const VerificationMeta('day');
  late final GeneratedColumn<DateTime?> day = GeneratedColumn<DateTime?>(
      'day', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _isAllDayMeta = const VerificationMeta('isAllDay');
  late final GeneratedColumn<bool?> isAllDay = GeneratedColumn<bool?>(
      'is_all_day', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_all_day IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _startMeta = const VerificationMeta('start');
  late final GeneratedColumn<DateTime?> start = GeneratedColumn<DateTime?>(
      'start', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _endMeta = const VerificationMeta('end');
  late final GeneratedColumn<DateTime?> end = GeneratedColumn<DateTime?>(
      'end', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, comment, day, isAllDay, start, end];
  @override
  String get aliasedName => _alias ?? 'schedules';
  @override
  String get actualTableName => 'schedules';
  @override
  VerificationContext validateIntegrity(Insertable<Schedule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    } else if (isInserting) {
      context.missing(_commentMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day']!, _dayMeta));
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('is_all_day')) {
      context.handle(_isAllDayMeta,
          isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta));
    }
    if (data.containsKey('start')) {
      context.handle(
          _startMeta, start.isAcceptableOrUnknown(data['start']!, _startMeta));
    }
    if (data.containsKey('end')) {
      context.handle(
          _endMeta, end.isAcceptableOrUnknown(data['end']!, _endMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Schedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Schedule.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SchedulesTable createAlias(String alias) {
    return $SchedulesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SchedulesTable schedules = $SchedulesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [schedules];
}
