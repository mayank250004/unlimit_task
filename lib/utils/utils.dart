import 'package:flutter/foundation.dart';

void debugPrint(String message, {bool debug = true}) {
  if (kDebugMode) {
    print(message);
  }
}


