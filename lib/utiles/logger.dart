import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void logger(String filename, String? funcName, String message) {
  debugPrint(
      "[${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now())}] [$filename${funcName != null ? "/$funcName" : ""}] $message");
}
