import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class OcrService {
  final TextRecognizer _textRecognizer = TextRecognizer();
  final ImagePicker _imagePicker = ImagePicker();

  Future<String?> pickImageAndExtractText(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      
      if (pickedFile == null) {
        return null;
      }

      final String imagePath = pickedFile.path;
      final File imageFile = File(imagePath);
      
      return await extractTextFromImage(imageFile);
    } catch (e) {
      throw Exception('Erro ao selecionar imagem: $e');
    }
  }

  Future<String> extractTextFromImage(File imageFile) async {
    try {
      final InputImage inputImage = InputImage.fromFile(imageFile);
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);

      String extractedText = '';
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          extractedText += '${line.text}\n';
        }
      }

      return extractedText.trim();
    } catch (e) {
      throw Exception('Erro ao extrair texto da imagem: $e');
    }
  }

  void dispose() {
    _textRecognizer.close();
  }
}