
import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:user_panel/auth/domain/usecases/get_location_usecase.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocationUseCase getLocationUseCase;
  LocationBloc(this.getLocationUseCase) : super(LocationInitial()) {
    on<GetCurrentLocationEvent>((event, emit) async {
      emit(LocationLoading());
      try {
        final position = await getLocationUseCase();
        emit(LocationLoaded(position));
      } catch (e) {
        emit(LocationError("Failed to fetch location: $e"));
      }
    });

    on<UpdateLocationEvent>((event, emit) {
      emit(LocationLoaded(event.newPosition));
    });


  }
}
