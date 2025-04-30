  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/common/common_action_button.dart';
import '../../../../provider/bloc/booking_generate_bloc/generate_slot_bloc/generate_slot_bloc.dart';
import '../../../../provider/cubit/booking_generate_cubit/calender_picker/calender_picker_cubit.dart';
import '../../../../provider/cubit/booking_generate_cubit/duration_picker/duration_picker_cubit.dart';
import '../../../../provider/cubit/booking_generate_cubit/time_picker/time_picker_cubit.dart';
import 'handle_slotupload_state.dart';

Padding generateSlotsActionbutton(BuildContext context, double screenWidth, double screenHeight) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
        child: BlocListener<GenerateSlotBloc, GenerateSlotState>(
          listener: (context, state) {
            handleSlotUploadState(context, state);
          },
          child: ActionButton(
              screenWidth: screenWidth,
              screenHight: screenHeight,
              onTap: () {
                final selectedDate = context.read<CalenderPickerCubit>().state.selectedDate;
                final startTime =  context.read<TimePickerCubit>().state.startTime;
                final endTime = context.read<TimePickerCubit>().state.endTime;
                final duration = context.read<DurationPickerCubit>().state;

                context.read<GenerateSlotBloc>().add(SlotGenerateRequest(
                    selectedDate: selectedDate,startTime: startTime,endTime: endTime,duration: duration));
              },
              label: 'Generate Slots',),
        ),
      );
  }