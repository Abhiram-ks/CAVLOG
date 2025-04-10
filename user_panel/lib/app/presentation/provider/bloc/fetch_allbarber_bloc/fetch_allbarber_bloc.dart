import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:user_panel/app/data/models/barber_model.dart';
import '../../../../data/repositories/fetch_allbarbers_repo.dart';
part 'fetch_allbarber_event.dart';
part 'fetch_allbarber_state.dart';
class FetchAllbarberBloc extends Bloc<FetchAllbarberEvent, FetchAllbarberState> {
  final FetchBarberRepository fetchBarberRepository;
  StreamSubscription? _barberSubscription;
  
  FetchAllbarberBloc(this.fetchBarberRepository) : super(FetchAllbarberInitial()) {
    on<FetchAllBarbersRequested>(_onFetchAllBarbersRequested);
  }
  
  Future<void> _onFetchAllBarbersRequested(
    FetchAllBarbersRequested event, 
    Emitter<FetchAllbarberState> emit
  ) async {
    emit(FetchAllbarberLoading());
    
    await _barberSubscription?.cancel();
    
    await emit.forEach(
      fetchBarberRepository.streamAllBarbers(),
      onData: (List<BarberModel> barbers) {
        if (barbers.isEmpty) {
          return FetchAllbarberEmpty();
        } else {
          return FetchAllbarberSuccess(barbers: barbers);
        }
      },
      onError: (error, stackTrace) {
        return FetchAllbarberFailure(error.toString());
      }
    );
  }
  
  @override
  Future<void> close() {
    _barberSubscription?.cancel();
    return super.close();
  }
}