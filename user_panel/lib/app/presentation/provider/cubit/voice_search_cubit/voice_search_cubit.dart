import 'package:bloc/bloc.dart';
import 'package:user_panel/app/domain/usecases/voice_search_usecase.dart';
import 'package:user_panel/app/presentation/provider/cubit/voice_search_cubit/voice_search_state.dart';

import '../../../screens/pages/search/search_screen.dart';


class VoiceSearchCubit extends Cubit<VoiceSearchState> {
  VoiceSearchCubit() : super(VoiceSearchState());
  
  Future<void> startVoiceSearch(VoiceSearchUseCase voiceSearchUseCase) async {
    emit(state.copyWith(isListening: true, recognizedText: ''));
    
    final result = await voiceSearchUseCase.startListening();
    
    if (result) {
      voiceSearchUseCase.onTextRecognized = (text) {
        emit(state.copyWith(recognizedText: text));
        GlobalSearchController.searchController.text = text;
      };
    } else {
      emit(state.copyWith(isListening: false));
    }
  }
  
  void stopVoiceSearch() {
    emit(state.copyWith(isListening: false));
  }
}
