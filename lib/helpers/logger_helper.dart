import 'package:flutter/foundation.dart';

void xlog(String message, {String tag = 'log', Object? error}) {
  if (kDebugMode) {
    print('[$tag] $message');
  }
  if (error != null) {
    if (kDebugMode) {
      print('[$tag] $error');
    }
  }
}
