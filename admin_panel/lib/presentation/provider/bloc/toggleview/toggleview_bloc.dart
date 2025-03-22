import 'package:bloc/bloc.dart';
part 'toggleview_event.dart';
part 'toggleview_state.dart';

class ToggleviewBloc extends Bloc<ToggleviewEvent, ToggleviewState> {
  ToggleviewBloc() : super(ToggleviewInitial()) {
    on<ToggleviewAction>((event, emit) {
      if (state is ToggleviewInitial) {
        emit(ToggleviewStatus());
      }else{
        emit(ToggleviewInitial());
      }
    });
  }
}
