import 'package:flutter/material.dart';
import 'package:stv_test_app/view/schedule_page/schedule_arguments.dart';
import 'package:stv_test_app/view/schedule_page/schedule_page.dart';

class AppRoutes {
  static const calender = '/';
  static const scheduleDetail = '/scheduleDetail';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.scheduleDetail:
      final arguments = settings.arguments! as ScheduleArguments;
      return _buildRoute(
        SchedulePage(arguments: arguments),
        settings: settings,
        fullScreenDialog: true,
      );
    default:
      return null;
  }
}

Route _buildRoute(
  Widget child, {
  RouteSettings? settings,
  bool fullScreenDialog = false,
}) {
  return MaterialPageRoute<Widget>(
    builder: (BuildContext context) => child,
    settings: settings,
    fullscreenDialog: fullScreenDialog,
  );
}
