import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/booking_generate/duration_picker/duration_picker_cubit.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/booking_generate/time_picker/time_picker_cubit.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/edit_mode/edit_mode_cubit.dart';
import 'package:barber_pannel/core/common/common_action_button.dart';
import 'package:barber_pannel/core/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../core/common/custom_app_bar.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../provider/cubit/booking_generate/calender_picker/calender_picker_cubit.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

import '../../../provider/cubit/current_service_cubit/current_service_cubit.dart';
import '../../../widgets/settings_widget/settings_service_management/service_management_filed_widget.dart';

class TimeManagementScreen extends StatelessWidget {
  const TimeManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CalenderPickerCubit()),
        BlocProvider(create: (_) => TimePickerCubit()),
        BlocProvider(create: (_) => EditModeCubit()),
        BlocProvider(create: (_) => DurationPickerCubit()),
        BlocProvider(create: (_) => ServicePageCubit()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          return ColoredBox(
            color: AppPalette.scafoldClr ?? AppPalette.whiteClr,
            child: SafeArea(
              child: Scaffold(
                appBar: CustomAppBar(),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: BlocBuilder<ServicePageCubit, CurrentServicePage>(
                    builder: (context, state) {
                      switch (state) {
                        case CurrentServicePage.pageOne:
                          return TimeManagementPageOne(screenWidth: screenWidth, screenHeight: screenHeight);
                        case CurrentServicePage.pageTwo:
                          return TimeManagementPageTwo(screenWidth: screenWidth, screenHeight: screenHeight);
                           
                      }
                    },
                  ),
                ),
               floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: SizedBox(
                    width: screenWidth * .9,
                    child: BlocBuilder<ServicePageCubit, CurrentServicePage>(
                      builder: (context, state) {
                        final isPageOne = state == CurrentServicePage.pageOne;
                        return ActionButton(
                            hasBorder:  true,
                            textColor: AppPalette.buttonClr,
                            borderColor: AppPalette.buttonClr,
                            color: AppPalette.trasprentClr,
                            screenWidth: screenWidth,
                            onTap: () {
                              isPageOne
                              ? context.read<ServicePageCubit>().goToPageTwo()
                              : context.read<ServicePageCubit>().goToPageOne();
                            },
                            label: isPageOne ? 'View Slots' : 'Back to Generator',
                            screenHight: screenHeight);
                      },
                    ),
                  )

              ),
            ),
          );
        },
      ),
    );
  }
}

class TimeManagementPageTwo extends StatelessWidget {
  const TimeManagementPageTwo({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CalenderPickerCubit, CalenderPickerState>(
          builder: (context, state) {
            return Column(
              children: [
                TableCalendar(
                  focusedDay: state.selectedDate,
                  firstDay: DateTime.now(),
                  lastDay: DateTime(
                    DateTime.now().year + 3,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month'
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(state.selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    context.read<CalenderPickerCubit>().updateSelectedDate(selectedDay);
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: AppPalette.orengeClr,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppPalette.buttonClr,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: AppPalette.whiteClr,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ConstantWidgets.hight10(context),
                Text(
                  "Picked Date: ${state.selectedDate.day}/${state.selectedDate.month}/${state.selectedDate.year}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        ConstantWidgets.hight30(context),
        Padding(
          padding: EdgeInsets.symmetric(  horizontal: screenWidth * 0.08),
          child: Column(
            children: [
              ServiceManagementFiled(
                context: context,
                icon: Icons.timer,
                screenWidth: screenWidth,
                label: 'Avalable',
                serviceRate:'10: 00 - 13: 00',
                deleteAction: () {},
                updateAction: (value) {},
                )
          
            ],
          ),
         )
      ]
    );
  }
}

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
    return Column(
      children: [
        BlocBuilder<CalenderPickerCubit, CalenderPickerState>(
          builder: (context, state) {
            return Column(
              children: [
                TableCalendar(
                  focusedDay: state.selectedDate,
                  firstDay: DateTime.now(),
                  lastDay: DateTime(
                    DateTime.now().year + 3,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month'
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(state.selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    context.read<CalenderPickerCubit>().updateSelectedDate(selectedDay);
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: AppPalette.orengeClr,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppPalette.buttonClr,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: AppPalette.whiteClr,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ConstantWidgets.hight10(context),
                Text(
                  "Selected Date: ${state.selectedDate.day}/${state.selectedDate.month}/${state.selectedDate.year}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        ConstantWidgets.hight20(context),
        BlocBuilder<TimePickerCubit, TimePickerState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                timePickerwidget(
                    context: context,
                    initialTime: state.startTime,
                    onTimeChanged: (newTime) => context
                        .read<TimePickerCubit>()
                        .updateStartTime(newTime),
                    labelText: 'StartTime '),
                Text(
                  state.startTime.format(context),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ConstantWidgets.width20(context),
                timePickerwidget(
                    context: context,
                    initialTime: state.endTime,
                    onTimeChanged: (newTime) =>
                        context.read<TimePickerCubit>().updateEndtime(newTime),
                    labelText: 'EndTime '),
                Text(
                  state.endTime.format(context),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        BlocBuilder<DurationPickerCubit, DurationTime>(
            builder: (context, selectDuration) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Duration:   ',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ConstantWidgets.width20(context),
              DropdownButton<DurationTime>(
                value: selectDuration,
                elevation: 20,
                focusColor: AppPalette.whiteClr,
                onChanged: (val) {
                  if (val != null) {
                    context.read<DurationPickerCubit>().updateDuration(val);
                  }
                },
                items: DurationTime.values.map((val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(_getDurationLabel(val)),
                  );
                }).toList(),
                dropdownColor: AppPalette.whiteClr,
                style: TextStyle(fontSize: 16, color: AppPalette.blueClr),
                iconEnabledColor: AppPalette.blackClr,
                icon: Icon(Icons.arrow_drop_down_outlined),
              ),
            ],
          );
        }),
        ConstantWidgets.hight20(context),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
          child: ActionButton(
              screenWidth: screenWidth,
              onTap: () {},
              label: 'Generate Slots',
              screenHight: screenHeight),
        )
      ],
    );
  }
}

String _getDurationLabel(DurationTime plan) {
  switch (plan) {
    case DurationTime.basic:
      return '30 minutes';
    case DurationTime.standard:
      return '45 minutes';
    case DurationTime.elite:
      return '1 hours';
    case DurationTime.master:
      return '2 hours';
  }
}

TextButton timePickerwidget({
  required BuildContext context,
  required TimeOfDay initialTime,
  required Function(Time) onTimeChanged,
  required String labelText,
}) {
  return TextButton(
    onPressed: () {
      Navigator.of(context).push(
        showPicker(
            is24HrFormat: true,
            context: context,
            value: Time.fromTimeOfDay(initialTime, 0),
            onChange: onTimeChanged,
            duskSpanInMinutes: 120,
            blurredBackground: true,
            iosStylePicker: true,
            focusMinutePicker: true,
            okText: 'schedule',
            backgroundColor: AppPalette.scafoldClr,
            cancelStyle: TextStyle(color: AppPalette.blackClr),
            okStyle: TextStyle(
              color: AppPalette.orengeClr,
            )),
      );
    },
    child: Text(
      "$labelText :",
      style: TextStyle(
        color: AppPalette.blueClr,
        fontSize: 16,
      ),
    ),
  );
}
