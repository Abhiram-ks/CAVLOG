import 'dart:developer';

import 'package:barber_pannel/cavlog/app/data/repositories/fetch_barber_details.dart';
import 'package:barber_pannel/cavlog/auth/data/models/barber_model.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'fetch_barber_event.dart';
part 'fetch_barber_state.dart';

class FetchBarberBloc extends Bloc<FetchBarberEvent, FetchBarberState> {
  final FetchBarberRepository reposiyoty ;
  FetchBarberBloc(this.reposiyoty) : super(FetchBarberInitial()) {
    on<FetchCurrentBarber>(_onFetchCurrentBarber);
  }

  Future<void> _onFetchCurrentBarber(
    FetchCurrentBarber event, Emitter<FetchBarberState> emit) async {
      emit(FetchBarbeLoading());
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? barberUid = prefs.getString('barberUid');
        log('Fetching barber uid: $barberUid ');

      if (barberUid != null) {
          await emit.forEach(
            reposiyoty.streamBarberData(barberUid),
            onData:(barber) => barber != null 
            ? FetchBarberLoaded(barber: barber)
            : FetchBarberError("Error due to: Barber not found"),
          );
        } else {
          emit(FetchBarberInitial()); 
        }
      } catch (e) {
        emit(FetchBarberError('Error due to: $e'));
      }
  }
}
