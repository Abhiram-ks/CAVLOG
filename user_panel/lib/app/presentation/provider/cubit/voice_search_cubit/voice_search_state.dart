
class VoiceSearchState {
  final bool isListening;
  final String recognizedText;

  VoiceSearchState({this.isListening = false, this.recognizedText = ''});

  VoiceSearchState copyWith({bool? isListening, String? recognizedText}) {
    return VoiceSearchState(
      isListening: isListening ?? this.isListening,
      recognizedText: recognizedText ?? this.recognizedText,
    );
  }

  bool get isEmpty => !isListening && recognizedText.isEmpty;
}
