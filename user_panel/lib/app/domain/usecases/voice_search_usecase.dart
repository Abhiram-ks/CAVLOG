import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceSearchUseCase {
  final stt.SpeechToText speechToText;
  Function(String)? onTextRecognized;
  
  VoiceSearchUseCase(this.speechToText);
  
  Future<bool> startListening() async {
    final isAvailable = await speechToText.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          stopListening();
        }
      },
      onError: (error) => debugPrint("Speech recognition error: $error"),
    );
    
    if (isAvailable) {
      await speechToText.listen(
        onResult: (result) {
          final recognizedWords = result.recognizedWords;
          if (recognizedWords.isNotEmpty && onTextRecognized != null) {
            onTextRecognized!(recognizedWords);
          }
        },
        listenFor: const Duration(seconds: 30),
      );
    }
    
    return isAvailable;
  }
  
  Future<void> stopListening() async {
    await speechToText.stop();
  }
}