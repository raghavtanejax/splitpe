import 'package:flutter/foundation.dart';

class OcrService {
  /// OCR bill scanning is a mobile-only feature.
  static Future<double?> scanBillForTotal() async {
    debugPrint("OCR is not supported on the Web platform.");
    return null;
  }
}
