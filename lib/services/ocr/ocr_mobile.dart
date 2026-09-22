import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class OcrService {
  static final ImagePicker _picker = ImagePicker();

  /// Captures an image using the camera. ML Kit OCR is temporarily disabled to allow Web Compilation.
  static Future<double?> scanBillForTotal() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return null;
      debugPrint("OCR is disabled in this build to support Web.");
      return null;
    } catch (e) {
      return null;
    }
  }
}
