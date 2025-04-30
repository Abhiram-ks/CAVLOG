import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:user_panel/app/data/models/service_model.dart';
import 'package:user_panel/app/data/repositories/fetch_barber_details_repo.dart';
part 'fetch_barber_details_event.dart';
part 'fetch_barber_details_state.dart';

class FetchBarberDetailsBloc
    extends Bloc<FetchBarberDetailsEvent, FetchBarberDetailsState> {
  final FetchBarberDetailsRepository repository;
  StreamSubscription<List<BarberServiceModel>>? _subscription;

  FetchBarberDetailsBloc(this.repository)
      : super(FetchBarberDetailsInitial()) {
    on<FetchBarberServicesRequested>(_onFetchBarberServicesRequested);
  
  }

  Future<void> _onFetchBarberServicesRequested(
    FetchBarberServicesRequested event,
    Emitter<FetchBarberDetailsState> emit,
  ) async {
    emit(FetchBarberServicesLoading());

    try {
      await emit.forEach<List<BarberServiceModel>>(
        repository.streamAllBarbersServices(event.barberId),
        onData: (services) {
          if (services.isEmpty) {
            return FetchBarberServicesEmpty();
          } else {
            return FetchBarberServiceSuccess(services);
          }
        },
        onError: (error, _) {
          return FetchBarberServicesFailure(error.toString());
        },
      );
    } catch (e) {
      emit(FetchBarberServicesFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
