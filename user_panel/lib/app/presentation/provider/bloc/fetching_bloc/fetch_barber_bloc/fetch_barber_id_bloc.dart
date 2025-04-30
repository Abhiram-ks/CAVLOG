import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../data/models/barber_model.dart';
import '../../../../../data/models/service_model.dart';
import '../../../../../data/repositories/fetch_barber_repo.dart';

part 'fetch_barber_id_event.dart';
part 'fetch_barber_id_state.dart';

class FetchBarberIdBloc extends Bloc<FetchBarberIdEvent, FetchBarberIdState> {
  final FetchBarberRepository _barberRepository;
  StreamSubscription<BarberServiceModel>? _subscription;
  
  FetchBarberIdBloc(this._barberRepository) : super(FetchBarberIdInitial()) {
      on<FetchBarberDetailsAction>(_onFetchBarberDetailsRequest);
  }

    Future<void> _onFetchBarberDetailsRequest(
    FetchBarberDetailsAction event,
    Emitter<FetchBarberIdState> emit,
  ) async {
    emit(FetchBarberDetailsLoading());
  
    await emit.forEach(
      _barberRepository.streamBarber(event.barberId),
      onData: (barber) => FetchBarberDetailsSuccess(barber),
      onError: (error, _) => FetchBarberDetailsFailure(error.toString()),
    );
  }

  
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
