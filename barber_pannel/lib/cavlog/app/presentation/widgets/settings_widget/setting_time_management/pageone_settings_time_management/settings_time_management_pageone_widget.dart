import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utils/constant/constant.dart';
import '../../../../provider/bloc/fetchings/fetch_slots_dates_bloc/fetch_slots_dates_bloc.dart';
import 'settings_time_management_durationpicker.dart';
import 'settings_time_management_pageone_timepicker.dart';
import 'settings_generate_slots_action_widget.dart' show generateSlotsActionbutton;
import 'settings_time_mangement_pageone_date_picker.dart' show TimeManagementDatePIcker;

class TimeManagementPageOne extends StatelessWidget {
  const TimeManagementPageOne({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FetchSlotsDatesBloc>().add(FetchSlotsDateRequest());
    });

    

    return Column(
      children: [
        TimeManagementDatePIcker(),
        ConstantWidgets.hight20(context),
        timeManagementDatePIckerFunction,
        timeManagementDurationPIckerFunction,
        ConstantWidgets.hight20(context),
        generateSlotsActionbutton(context,screenWidth, screenHeight)
      ],
    );
  }


}


