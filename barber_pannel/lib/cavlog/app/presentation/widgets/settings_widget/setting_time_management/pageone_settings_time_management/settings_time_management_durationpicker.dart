    import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/themes/colors.dart';
import '../../../../../../../core/utils/constant/constant.dart';
import '../../../../provider/cubit/booking_generate_cubit/duration_picker/duration_picker_cubit.dart';

var timeManagementDurationPIckerFunction = BlocBuilder<DurationPickerCubit, DurationTime>(
       builder: (context, selectDuration) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Duration:   ',style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ConstantWidgets.width20(context),
              DropdownButton<DurationTime>(
                value: selectDuration,
                elevation: 20,
                focusColor: AppPalette.whiteClr,
                onChanged: (val) {
                  if (val != null) {context.read<DurationPickerCubit>().updateDuration(val);}
                },
                items: DurationTime.values.map((val) {
                  return DropdownMenuItem(value: val,child: Text(_getDurationLabel(val)),
                  );
                }).toList(),
                dropdownColor: AppPalette.whiteClr,
                style: TextStyle(fontSize: 16, color: AppPalette.blueClr),
                iconEnabledColor: AppPalette.blackClr,
                icon: Icon(Icons.arrow_drop_down_outlined),
              ),
            ],
          );
        });


        

String _getDurationLabel(DurationTime plan) {
  switch (plan) {
    case DurationTime.basic:
      return '30 minutes';
    case DurationTime.standard:
      return '45 minutes';
    case DurationTime.elite:
      return '1 hours';
  }
}