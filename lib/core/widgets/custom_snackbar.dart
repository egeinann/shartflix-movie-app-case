import 'package:flutter/material.dart';


void showCustomSnackBar(
  BuildContext context,
  String message, {
  bool isError = true,
  Duration duration = const Duration(seconds: 3),
}) {
  final color = isError ? Color(0xFFF47171) : Color(0xFF00C247);

  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontWeight: FontWeight.w600),
    ),
    backgroundColor: color,
    duration: duration,
    
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    // Yukarıdan gelsin
    dismissDirection: DismissDirection.up,
    
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}