import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barber_pannel/cavlog/app/data/models/barberservice_model.dart';
import '../../../../data/repositories/fetch_barber_service_repo.dart';
part 'fetch_barber_service_event.dart';
part 'fetch_barber_service_state.dart';

class FetchBarberServiceBloc extends Bloc<FetchBarberServiceEvent, FetchBarberServiceState> {
  final FetchBarberServiceRepository repository;
  StreamSubscription<List<BarberServiceModel>>? _subscription;


  FetchBarberServiceBloc({required this.repository})
      : super(FetchBarberServiceInitial()) {
    on<FetchBarberServiceRequestEvent>(_onFetchBarberService);
  }
  Future<void> _onFetchBarberService(
    FetchBarberServiceRequestEvent event,
    Emitter<FetchBarberServiceState> emit,
  ) async {
    emit(FetchBarberServiceLoading());

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? barberUid = prefs.getString('barberUid');
      if (barberUid == null) {
        emit(FetchBarberServiceEmpty());
        return;
      }

      await emit.forEach<List<BarberServiceModel>>(
        repository.fetchBarberServicesData(barberUid),
        onData: (services) {
          if (services.isEmpty) {
            return FetchBarberServiceEmpty();
          } else {
            return FetchBarberServiceSuccess(services: services);
          }
        },
        onError: (error, _) {
          return FetchBarberServiceError(error: error.toString());
        },
      );
    } catch (e) {
      emit(FetchBarberServiceError(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
