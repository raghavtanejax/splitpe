import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class OcrService {
  static final ImagePicker _picker = ImagePicker();

  /// Captures an image using the camera and processes it for the highest currency amount.
  static Future<double?> scanBillForTotal() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return null;

      final inputImage = InputImage.fromFilePath(image.path);
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      await textRecognizer.close();

      return _extractTotalAmount(recognizedText.text);
    } catch (e) {
      return null;
    }
  }

  /// Extracts the most likely "Total" amount from the scanned text.
  /// Strategy: Find all valid decimal/currency numbers in the text and return the largest one.
  static double? _extractTotalAmount(String text) {
    final RegExp regex = RegExp(r'\b\d{1,3}(?:[,\s]?\d{3})*(?:\.\d{1,2})?\b');
    final Iterable<Match> matches = regex.allMatches(text);

    double maxAmount = 0.0;
    
    for (final Match m in matches) {
      if (m.group(0) != null) {
        String cleanNum = m.group(0)!.replaceAll(RegExp(r'[,\s]'), '');
        double? val = double.tryParse(cleanNum);
        if (val != null && val > maxAmount) {
          maxAmount = val;
        }
      }
    }

    return maxAmount > 0 ? maxAmount : null;
  }
}
