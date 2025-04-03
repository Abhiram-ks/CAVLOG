import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'googlesign_event.dart';
part 'googlesign_state.dart';

class GooglesignBloc extends Bloc<GooglesignEvent, GooglesignState> {
  GooglesignBloc() : super(GooglesignInitial()) {
    on<GooglesignEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
