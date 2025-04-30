import 'dart:async';
import 'dart:developer';
import 'package:barber_pannel/cavlog/app/data/models/slot_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/repositories/fetch_barber_slot_repo.dart';
part 'fetch_slots_specificdate_event.dart';
part 'fetch_slots_specificdate_state.dart';


class FetchSlotsSpecificdateBloc extends Bloc<FetchSlotsSpecificdateEvent, FetchSlotsSpecificDateState> {
  final FetchSlotsRepository _fetchSlotsRepository;
  
  FetchSlotsSpecificdateBloc(this._fetchSlotsRepository) : super(FetchSlotsSpecificDateInitial()) {
    on<FetchSlotsSpecificdateRequst>(_onFetchSlotsSpecificDateRequest);
  }

  Future<void> _onFetchSlotsSpecificDateRequest(
    FetchSlotsSpecificdateRequst event,
    Emitter<FetchSlotsSpecificDateState> emit,
  ) async {
    emit(FetchSlotsSpecificDateLoading());
    log('Fetching date in specific day : ${event.selectedDate}');
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? barberUid = prefs.getString('barberUid');

      if (barberUid == null) {
        emit(FetchSlotsSpecificDateFailure('Barber UID not found.'));
        return;
      }

      await emit.forEach<List<SlotModel>>(
        _fetchSlotsRepository.streamSlots(
          barberUid: barberUid,
          selectedDate: event.selectedDate,
        ),
        onData: (slots) {
          if (slots.isEmpty) {
            return FetchSlotsSpecificDateEmpty(event.selectedDate);
          } else {
            return FetchSlotsSpecificDateLoaded(slots: slots);
          }
        },
        onError: (error, stackTrace) {
          return FetchSlotsSpecificDateFailure(error.toString());
        },
      );

    } catch (e) {
      emit(FetchSlotsSpecificDateFailure(e.toString()));
    }
  }
}
