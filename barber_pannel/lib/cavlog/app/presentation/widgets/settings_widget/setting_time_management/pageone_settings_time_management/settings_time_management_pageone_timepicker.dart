import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/constant/constant.dart';
import '../../../../provider/cubit/booking_generate_cubit/time_picker/time_picker_cubit.dart';
import '../../../../screens/settings/time_management_screen/time_management_screen.dart';

var timeManagementDatePIckerFunction = BlocBuilder<TimePickerCubit, TimePickerState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                timePickerwidget( context: context,initialTime: state.startTime,
                    onTimeChanged: (newTime) => context.read<TimePickerCubit>().updateStartTime(newTime),
                    labelText: 'StartTime '),
                Text(
                  state.startTime.format(context),
                  style: const TextStyle( fontSize: 16, fontWeight: FontWeight.w500, ),
                ),
                ConstantWidgets.width20(context),
                timePickerwidget(
                    context: context, initialTime: state.endTime,
                    onTimeChanged: (newTime) =>context.read<TimePickerCubit>().updateEndtime(newTime),
                    labelText: 'EndTime '),
                Text(
                  state.endTime.format(context),
                  style: const TextStyle( fontSize: 16,fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        );