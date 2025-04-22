import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:user_panel/app/data/models/barber_model.dart';
import '../../../../data/repositories/fetch_barber_repo.dart';
part 'fetch_allbarber_event.dart';
part 'fetch_allbarber_state.dart';


class FetchAllbarberBloc extends Bloc<FetchAllbarberEvent, FetchAllbarberState> {
  final FetchBarberRepository fetchBarberRepository;
  StreamSubscription? _barberSubscription;
  
  FetchAllbarberBloc(this.fetchBarberRepository) : super(FetchAllbarberInitial()) {
    on<FetchAllBarbersRequested>(_onFetchAllBarbersRequested);
    on<SearchBarbersRequested>(_onSearchBarbersRequested);
  }
  
  Future<void> _onFetchAllBarbersRequested(
    FetchAllBarbersRequested event, 
    Emitter<FetchAllbarberState> emit
  ) async {
    await _barberSubscription?.cancel();
    emit(FetchAllbarberLoading());

    await _barberSubscription?.cancel();
    
    await emit.forEach<List<BarberModel>>(
       fetchBarberRepository.streamAllBarbers(),
       onData: (barbers) {
         final verifiedBarbers = barbers.where((barber) => barber.isVerified).toList();
         if (verifiedBarbers.isEmpty) {
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
  
  Future<void> _onSearchBarbersRequested(
    SearchBarbersRequested event, Emitter<FetchAllbarberState> emit) async {
      emit(FetchAllbarberLoading());
      await emit.forEach<List<BarberModel>>(
       fetchBarberRepository.streamAllBarbers(),

         onData: (barbers) {
        final filteredBarbers = barbers
            .where((barber) => barber.ventureName.toLowerCase().contains(event.searchTerm.toLowerCase()))
            .toList();
          if (filteredBarbers.isEmpty) {
          return FetchAllbarberEmpty();
        } else {
          return FetchAllbarberSuccess(barbers: filteredBarbers);
        }
         },
          onError: (error, stackTrace) {
        return FetchAllbarberFailure(error.toString());
      },
        );
    } 



  @override
  Future<void> close() {
    _barberSubscription?.cancel();
    return super.close();
  }

}