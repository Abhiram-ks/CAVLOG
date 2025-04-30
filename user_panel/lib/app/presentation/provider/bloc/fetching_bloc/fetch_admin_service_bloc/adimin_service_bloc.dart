import 'package:bloc/bloc.dart';
import 'package:user_panel/app/data/models/admin_service_model.dart';

import '../../../../../data/repositories/fetch_services_admin_repo.dart';

part 'adimin_service_event.dart';
part 'adimin_service_state.dart';

class AdiminServiceBloc extends Bloc<AdiminServiceEvent, AdiminServiceState> {
   final FetchServiceRepository _serviceRepository;

  AdiminServiceBloc(this._serviceRepository) : super(AdiminServiceInitial()) {
       on<FetchServiceRequst>(_onFetchAllService);
  }

  Future<void> _onFetchAllService(
    FetchServiceRequst event,
    Emitter<AdiminServiceState> emit,
  ) async {
    emit(FetchServiceLoading());
    try {
      await emit.forEach<List<AdminServiceModel>>(
        _serviceRepository.streamAllServices(),
        onData: (services) => FetchServiceLoaded(service: services),
        onError: (error, _) => FetchServiceError(error.toString()),
      );
    } catch (e) {
      emit(FetchServiceError(e.toString()));
    }
  }
}