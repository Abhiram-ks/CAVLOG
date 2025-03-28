import 'package:admin/data/models/service_models.dart';
import 'package:admin/data/repositories/service_repository.dart';
import 'package:bloc/bloc.dart';
part 'fetching_service_event.dart';
part 'fetching_service_state.dart';

class FetchingServiceBloc extends Bloc<FetchingServiceEvent, FetchingServiceState> {
  final  ServiceRepository repository;
  FetchingServiceBloc(this.repository) : super(FetchingServiceInitial()) {
    on<FetchServiceDataEvent>((event, emit) async{
      emit(FetchingServiceInitial());
      await emit.forEach(
        repository.getServiceStream(),
        onData: (services) {
          if (services.isEmpty) {
            emit(ServiceEmptyState());
          }
          return ServiceLoadedState(services);
        },onError: (error, stackTrace) {
          return ServiceFechingErrorState('Failed to fetch service: $error');
        },
        );
    });
  }
}
