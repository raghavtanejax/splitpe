import 'package:flutter/foundation.dart';

class OcrService {
  static Future<double?> scanBillForTotal() async {
    debugPrint("OCR is not supported on the Web platform.");
    return null;
  }
}
