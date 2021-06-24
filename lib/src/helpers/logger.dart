import 'dart:developer' as developer;

/// logger
// ignore: camel_case_types
class l {
  /// global setting for logger
  static bool enable = false;

  /// log
  static void log(
    String? message, {
    DateTime? time,
    int? sequenceNumber,
    int level = 0,
    String name = '',
    // ignore: avoid_annotating_with_dynamic
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!enable) {
      return;
    }
    developer.log(message ?? '',
        name: name, error: error, stackTrace: stackTrace);
  }
}
