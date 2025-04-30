import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/date_model.dart';
import '../../../../../data/repositories/fetch_barber_slots_dates.dart';

part 'fetch_slots_dates_event.dart';
part 'fetch_slots_dates_state.dart';

class FetchSlotsDatesBloc extends Bloc<FetchSlotsDatesEvent, FetchSlotsDatesState> {
   final FetchSlotsRepository _fetchSlotsRepository;
   StreamSubscription<List<DateModel>>? _slotSubscription;

  FetchSlotsDatesBloc(this._fetchSlotsRepository) : super(FetchSlotsDatesInitial()) {
     on<FetchSlotsDateRequest>(_onFetchSlotsDatesRequest);
  }

  Future<void> _onFetchSlotsDatesRequest(
   FetchSlotsDateRequest event, Emitter<FetchSlotsDatesState> emit) async {
   emit(FetchSlotsDateLoading());
   log('the date fetching was working');
   
   try {
     await _fetchSlotsRepository.streamDates(event.barberId).forEach((dates) {
       emit(FetchSlotsDatesSuccess(dates));
     });
   } catch (e) {
     log('Error in _onFetchSlotsDatesRequest: $e');
     emit(FetchSlotsDateFailure('An error occurred'));
   }
 }


  @override
  Future<void> close() {
    _slotSubscription?.cancel();
    return super.close();
  }
}
