import 'package:flutter/foundation.dart';

class LoggerService {
  // INFO
  static void info(String message) {
    debugPrint("[INFO] $message");
  }

  // DEBUG
  static void debug(String message) {
    debugPrint("[DEBUG] $message");
  }

  // ERROR
  static void error(String message) {
    debugPrint("[ERROR] $message");
  }
}
