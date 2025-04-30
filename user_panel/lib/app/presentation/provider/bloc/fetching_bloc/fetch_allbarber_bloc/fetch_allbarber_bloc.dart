import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_panel/app/data/models/barber_model.dart';
import '../../../../../data/repositories/fetch_barber_repo.dart';
part 'fetch_allbarber_event.dart';
part 'fetch_allbarber_state.dart';

class FetchAllbarberBloc
    extends Bloc<FetchAllbarberEvent, FetchAllbarberState> {
  final FetchBarberRepository fetchBarberRepository;
  StreamSubscription? _barberSubscription;

  FetchAllbarberBloc(this.fetchBarberRepository)
      : super(FetchAllbarberInitial()) {
    on<FetchAllBarbersRequested>(_onFetchAllBarbersRequested);
    on<SearchBarbersRequested>(_onSearchBarbersRequested);
    on<FilterBarbersRequested>(_onFilterBarbersRequested); 
  }

  Future<void> _onFetchAllBarbersRequested(
      FetchAllBarbersRequested event, Emitter<FetchAllbarberState> emit) async {
    await _barberSubscription?.cancel();
    emit(FetchAllbarberLoading());

    await _barberSubscription?.cancel();

    await emit.forEach<List<BarberModel>>(
        fetchBarberRepository.streamAllBarbers(), onData: (barbers) {
      final verifiedBarbers =
          barbers.where((barber) => barber.isVerified).toList();
      if (verifiedBarbers.isEmpty) {
        return FetchAllbarberEmpty();
      } else {
        return FetchAllbarberSuccess(barbers: barbers);
      }
    }, onError: (error, stackTrace) {
      return FetchAllbarberFailure(error.toString());
    });
  }

  /* Handles the searching logic for the barbers field within the BLoC */

  Future<void> _onSearchBarbersRequested(
      SearchBarbersRequested event, Emitter<FetchAllbarberState> emit) async {
    emit(FetchAllbarberLoading());

    await emit.forEach<List<BarberModel>>(
      fetchBarberRepository.streamAllBarbers(),
      onData: (barbers) {
        final filteredBarbers = barbers
            .where((barber) => barber.ventureName
                .toLowerCase()
                .contains(event.searchTerm.toLowerCase()))
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
 Future<void> _onFilterBarbersRequested(
  FilterBarbersRequested event,
  Emitter<FetchAllbarberState> emit,
) async {
  emit(FetchAllbarberLoading());
  
  try {
    final List<BarberModel> barbers = await fetchBarberRepository.streamAllBarbers().first;
    List<BarberModel> filteredList = [];
    
    for (final barber in barbers) {
      bool genderMatch = true;
      if (event.gender != null && event.gender!.isNotEmpty) {
        if (event.gender!.toLowerCase() == "unisex") {
          genderMatch = true;
        } else {
          genderMatch = barber.gender?.toLowerCase() == event.gender!.toLowerCase();
        }
      }
      

      final ratingMatch = event.rating <= 0.0 || (barber.rating ?? 0.0) >= event.rating;
      
      if (!genderMatch || !ratingMatch) continue;

      if (event.selectServices.isNotEmpty) {
        try {
          final serviceDoc = await FirebaseFirestore.instance
              .collection('individual_barber_services')
              .doc(barber.uid)
              .get();
          
          if (!serviceDoc.exists) {
            continue;
          }
          
          final Map<String, dynamic> docData = serviceDoc.data() ?? {};
          Map<String, dynamic> servicesMap = {};
          
          if (docData.containsKey('services') && docData['services'] is Map) {
            servicesMap = docData['services'] as Map<String, dynamic>;
          } else {
            servicesMap = docData;
          }
          
          bool hasMatchingServices = false;
          
          for (String selectedService in event.selectServices) {
            if (servicesMap.keys.any((key) => 
                key.toLowerCase() == selectedService.toLowerCase())) {
              hasMatchingServices = true;
              break;
            }
          }
          
          if (hasMatchingServices) {
            filteredList.add(barber);
          }
        } catch (e) {
          log('Error fetching services for barber ${barber.uid}: $e');
          continue;
        }
      } else {
        filteredList.add(barber);
      }
    }
    
    if (filteredList.isEmpty) {
      emit(FetchAllbarberEmpty());
    } else {
      emit(FetchAllbarberSuccess(barbers: filteredList));
    }
  } catch (e) {
    emit(FetchAllbarberFailure(e.toString()));
  }
}

  @override
  Future<void> close() {
    _barberSubscription?.cancel();
    return super.close();
  }
}
