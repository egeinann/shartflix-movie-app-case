import 'package:flutter/material.dart';

Widget outlinedContainer(BuildContext context,Widget widget) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        width: 1.5,
        color: Theme.of(context).shadowColor.withAlpha(50),
      ),
      color: Theme.of(context).cardColor.withAlpha(40),
      borderRadius: BorderRadius.circular(14),
    ),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: widget,
  );
}
