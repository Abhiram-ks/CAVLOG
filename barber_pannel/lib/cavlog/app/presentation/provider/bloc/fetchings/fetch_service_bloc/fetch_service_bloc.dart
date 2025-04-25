import 'package:barber_pannel/cavlog/app/data/models/service_model.dart';
import 'package:barber_pannel/cavlog/app/data/repositories/fetch_servicedata_repo.dart';
import 'package:bloc/bloc.dart';

part 'fetch_service_event.dart';
part 'fetch_service_state.dart';

class FetchServiceBloc extends Bloc<FetchServiceEvent, FetchServiceState> {
  final FetchServiceRepository serviceRepository;

  FetchServiceBloc(this.serviceRepository) : super(FetchServiceInitial()) {
    on<FetchServiceRequst>(_onFetchAllService);
  }

  Future<void> _onFetchAllService(
    FetchServiceRequst event,
    Emitter<FetchServiceState> emit,
  ) async {
    emit(FetchServiceLoading());
    try {
      await emit.forEach<List<ServiceModel>>(
        serviceRepository.streamAllServices(),
        onData: (services) => FetchServiceLoaded(service: services),
        onError: (error, _) => FetchServiceError(error.toString()),
      );
    } catch (e) {
      emit(FetchServiceError(e.toString()));
    }
  }
}
