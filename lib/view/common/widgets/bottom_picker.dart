import 'package:flutter/cupertino.dart';

Widget bottomPicker(Widget picker) {
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
