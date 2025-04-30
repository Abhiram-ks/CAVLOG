import 'package:barber_pannel/cavlog/app/domain/usecases/generate_slot_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/datasources/slot_remote_datasource.dart';
import '../../../cubit/booking_generate_cubit/duration_picker/duration_picker_cubit.dart';

part 'generate_slot_event.dart';
part 'generate_slot_state.dart';

class GenerateSlotBloc extends Bloc<GenerateSlotEvent, GenerateSlotState> {
  final SlotRepository slotRepository;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  DurationTime _duration = DurationTime.standard;

  GenerateSlotBloc(this.slotRepository) : super(GenerateSlotInitial()) {
    on<SlotGenerateRequest>((event, emit) {
      _selectedDate = event.selectedDate;
      _startTime = event.startTime;
      _endTime = event.endTime;
      _duration = event.duration;
      emit(GenerateSlotAlertState(selectedDate: event.selectedDate, startTime: event.startTime, endTime: event.endTime, duration: event.duration));
    });

    on<SlotGenerateConfirmation>((event, emit) async {
      emit(GenerateSlotLoading());
      try {
        List<String> generatedSlots = SlotGenerator.generateSlots(
          date: _selectedDate, 
          start: _startTime, 
          end: _endTime, 
          duration: _duration);
        
        if(generatedSlots.isEmpty){
          emit(GenerateSLotFailure('No slots generated. Please check your timings'));
          return;
        }

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? barberUid = prefs.getString('barberUid');

        if (barberUid != null) {
          bool isSuccess = await slotRepository.uploadSlots(
          barberUid: barberUid,
          selectedDate: _selectedDate,
          duration: _duration,
          slotTime: generatedSlots);


          if (isSuccess) {
            emit(GenerateSlotGenerated());
          }else{
            emit(GenerateSLotFailure('An unexpected error occurred :Slots for Session failure'));
          }
        }else {
           emit(GenerateSLotFailure('An error occurred: Barber Not found!'));
        }
      } catch (e) {
        emit(GenerateSLotFailure('An unexpected error occurred: $e'));
      }
    });
  }
}
