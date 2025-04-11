import 'package:bloc/bloc.dart';
part 'showhide_section_event.dart';
part 'showhide_section_state.dart';

class ShowhideSectionBloc extends Bloc<ShowhideSectionEvent, ShowhideSectionState> {
  ShowhideSectionBloc() : super(ShowTopsectionState(true)) {
     on<ShowTopSection>((event, emit) {
      emit(ShowTopsectionState(true));
    });
     on<HideTopSection>((event, emit) {
      emit(ShowTopsectionState(false));
    });
}
}