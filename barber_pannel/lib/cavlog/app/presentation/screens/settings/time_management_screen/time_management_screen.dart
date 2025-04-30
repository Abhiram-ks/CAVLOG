import 'dart:developer';

import 'package:barber_pannel/cavlog/app/data/repositories/fetch_barber_slot_repo.dart';
import 'package:barber_pannel/cavlog/app/data/repositories/slot_update_generated_repo.dart';
import 'package:barber_pannel/cavlog/app/domain/usecases/is_slottime_exceeded_usecase.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/booking_generate_bloc/generate_slot_bloc/generate_slot_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/booking_generate_bloc/modify_slots_generate_bloc/modify_slots_generate_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/booking_generate_cubit/duration_picker/duration_picker_cubit.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/booking_generate_cubit/slote_delete_privious_bloc/slot_delete_privious_cubit.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/booking_generate_cubit/time_picker/time_picker_cubit.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/edit_mode/edit_mode_cubit.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/settings_widget/setting_time_management/pagetwo_settings_time_management/handle_slot_modify_state.dart';
import 'package:barber_pannel/core/common/common_action_button.dart';
import 'package:barber_pannel/core/utils/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../core/common/custom_app_bar.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../data/datasources/slot_remote_datasource.dart';
import '../../../../data/models/date_model.dart';
import '../../../provider/bloc/booking_generate_bloc/fetch_slots_specificdate_bloc/fetch_slots_specificdate_bloc.dart';
import '../../../provider/bloc/fetchings/fetch_slots_dates_bloc/fetch_slots_dates_bloc.dart';
import '../../../provider/cubit/booking_generate_cubit/calender_picker/calender_picker_cubit.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import '../../../provider/cubit/current_service_cubit/current_service_cubit.dart';
import '../../../widgets/settings_widget/setting_time_management/pageone_settings_time_management/settings_time_management_pageone_widget.dart';
import '../../../widgets/settings_widget/settings_service_management/service_management_filed_widget.dart';

class TimeManagementScreen extends StatefulWidget {
  const TimeManagementScreen({super.key});

  @override
  State<TimeManagementScreen> createState() => _TimeManagementScreenState();
}

class _TimeManagementScreenState extends State<TimeManagementScreen> {
  @override
  void initState() {
    super.initState();
    _deleteOldSlots();
  }

  Future<void> _deleteOldSlots() async {
    await context.read<SlotDeletePriviousCubit>().deleteOldSlots();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CalenderPickerCubit()),
        BlocProvider(create: (_) => TimePickerCubit()),
        BlocProvider(create: (_) => EditModeCubit()),
        BlocProvider(create: (_) => DurationPickerCubit()),
        BlocProvider(create: (_) => ServicePageCubit()),
        BlocProvider(create: (_) => GenerateSlotBloc(SlotRepositoryImpl())),
        BlocProvider(
            create: (_) => FetchSlotsDatesBloc(FetchSlotsRepositoryImpl())),
        BlocProvider( create: (_) =>
                FetchSlotsSpecificdateBloc(FetchSlotsRepositoryImpl())),
        BlocProvider(
            create: (_) => ModifySlotsGenerateBloc(SlotUpdateRepositoryImpl()))
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
                            return TimeManagementPageOne(
                                screenWidth: screenWidth,
                                screenHeight: screenHeight);
                          case CurrentServicePage.pageTwo:
                            return TimeManagementPageTwo(
                                screenWidth: screenWidth,
                                screenHeight: screenHeight);
                        }
                      },
                    ),
                  ),
                  floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: SizedBox(
                    width: screenWidth * .9,
                    child: BlocBuilder<ServicePageCubit, CurrentServicePage>(
                      builder: (context, state) {
                        final isPageOne = state == CurrentServicePage.pageOne;
                        return ActionButton(
                          hasBorder: true,
                          textColor: isPageOne
                              ? AppPalette.buttonClr
                              : AppPalette.whiteClr,
                          borderColor: AppPalette.buttonClr,
                          color: isPageOne
                              ? AppPalette.trasprentClr
                              : AppPalette.buttonClr,
                          screenWidth: screenWidth,
                          screenHight: screenHeight,
                          onTap: () {
                            isPageOne
                                ? context.read<ServicePageCubit>().goToPageTwo()
                                : context
                                    .read<ServicePageCubit>()
                                    .goToPageOne();
                          },
                          label: isPageOne ? 'View Slots' : 'Back to Generator',
                        );
                      },
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}

DateTime parseDate(String dateString) {
  final parts = dateString.split('-');
  final day = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final year = int.parse(parts[2]);
  return DateTime(year, month, day);
}

Set<DateTime> getDisabledDates(List<DateModel> dates) {
  return dates.map((dateModel) => parseDate(dateModel.date)).toSet();
}

class TimeManagementPageTwo extends StatefulWidget {
  const TimeManagementPageTwo({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  State<TimeManagementPageTwo> createState() => _TimeManagementPageTwoState();
}

class _TimeManagementPageTwoState extends State<TimeManagementPageTwo> {
  @override
  void initState() {
    super.initState();
    _fetchSlotsForToday();
  }

  void _fetchSlotsForToday() {
    final selectedDate = context.read<CalenderPickerCubit>().state.selectedDate;
    context.read<FetchSlotsSpecificdateBloc>().add( FetchSlotsSpecificdateRequst(selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<CalenderPickerCubit, CalenderPickerState>(
        builder: (context, calenderState) {
          return BlocBuilder<FetchSlotsDatesBloc, FetchSlotsDatesState>(
            builder: (context, dateState) {
              if (dateState is FetchSlotsDatesSuccess) {
                final List<DateModel> availableDates = dateState.dates;

                final Set<DateTime> enabledDates = availableDates
                    .map((dateModel) => parseDate(dateModel.date))
                    .toSet();

                return Column(
                  children: [
                    TableCalendar(
                      focusedDay: calenderState.selectedDate,
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
                        return isSameDay(calenderState.selectedDate, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (enabledDates.contains(DateTime(selectedDay.year,
                            selectedDay.month, selectedDay.day))) {
                          context
                              .read<CalenderPickerCubit>()
                              .updateSelectedDate(selectedDay);
                          context
                              .read<FetchSlotsSpecificdateBloc>()
                              .add(FetchSlotsSpecificdateRequst(selectedDay));
                        }
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
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          outsideDaysVisible: false,
                          defaultTextStyle:
                              TextStyle(fontWeight: FontWeight.w900)),
                      calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                        final isEnable = enabledDates
                            .contains(DateTime(day.year, day.month, day.day));

                        if (!isEnable) {
                          return Center(
                              child: Text(
                            '${day.day}',
                            style: TextStyle(color: AppPalette.greyClr),
                          ));
                        }
                        return null;
                      }),
                    ),
                    ConstantWidgets.hight10(context),
                  ],
                );
              }
              return Shimmer.fromColors(
                baseColor: Colors.grey[300] ?? AppPalette.greyClr,
                highlightColor: AppPalette.whiteClr,
                child: TableCalendar(
                  focusedDay: calenderState.selectedDate,
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
                  calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                          color: AppPalette.greyClr, shape: BoxShape.circle),
                      todayDecoration: BoxDecoration(
                          color: AppPalette.greyClr, shape: BoxShape.circle),
                      todayTextStyle: TextStyle(
                          color: AppPalette.whiteClr,
                          fontWeight: FontWeight.bold),
                      defaultDecoration: BoxDecoration(shape: BoxShape.circle),
                      outsideDaysVisible: false),
                ),
              );
            },
          );
        },
      ),
      ConstantWidgets.hight30(context),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.08),
        child: BlocBuilder<FetchSlotsSpecificdateBloc,
            FetchSlotsSpecificDateState>(
          builder: (context, state) {
            if (state is FetchSlotsSpecificDateEmpty) {
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer_off,
                    color: AppPalette.buttonClr,
                  ),
                  Text(
                      '${state.salectedDate.day}/${state.salectedDate.month}/${state.salectedDate.year}'),
                  Text('No slots are available at the moment'),
                ],
              );
            } else if (state is FetchSlotsSpecificDateFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.timer_off, color: AppPalette.redClr),
                  Text('Unexpected error occurred'),
                  Text(
                    '${state.errorMessage}. Please try again!',
                  ),
                ],
              );
            } else if (state is FetchSlotsSpecificDateLoading) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300] ?? AppPalette.greyClr,
                highlightColor: AppPalette.whiteClr,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(5, (index) {
                          return colorMarker(
                            context: context,
                            hintText: 'Mark Unavailable',
                            markColor: AppPalette.buttonClr,
                          );
                        }),
                      ),
                    ),
                    ConstantWidgets.hight30(context),
                    Column(
                      children: List.generate(5, (index) {
                        return ServiceManagementFiled(
                          context: context,
                          icon: Icons.timer,
                          screenWidth: widget.screenWidth,
                          label: 'avalable',
                          serviceRate: '--:-- AM?PM',
                          deleteAction: () {},
                          updateIcon: CupertinoIcons.circle,
                          updateAction: (value) {},
                        );
                      }),
                    ),
                  ],
                ),
              );
            }
            if (state is FetchSlotsSpecificDateLoaded) {
              final slots = state.slots;
              return Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        colorMarker(
                            context: context,
                            hintText: 'Mark Unavailable',
                            markColor: AppPalette.buttonClr),
                        colorMarker(
                            context: context,
                            hintText: 'Mark Available',
                            markColor: AppPalette.greyClr),
                        colorMarker(
                            context: context,
                            hintText: 'Booked',
                            markColor: AppPalette.greenClr),
                        colorMarker(
                            context: context,
                            hintText: 'Time Exceeded',
                            markColor: AppPalette.hintClr),
                      ],
                    ),
                  ),
                  ConstantWidgets.hight30(context),
                  BlocListener<ModifySlotsGenerateBloc,
                      ModifySlotsGenerateState>(
                    listener: (context, state) {
                      handleSlotUpdatesState(context, state);
                    },
                    child: Column(
                      children: slots.map((slot) {
                        final bool isTimeExceeded = isSlotTimeExceeded(slot.docId, slot.time);

                        return ServiceManagementFiled(
                          context: context,
                          icon: Icons.timer,
                          screenWidth: widget.screenWidth,
                          firstIconColor: slot.booked
                              ? AppPalette.greenClr.withAlpha(128)
                              : AppPalette.whiteClr,
                          firstIconBgColor: slot.booked
                              ? AppPalette.trasprentClr
                              : slot.available
                                  ? (isTimeExceeded
                                      ? AppPalette.greyClr.withAlpha(50)
                                      : AppPalette.greyClr)
                                  : (isTimeExceeded
                                      ? AppPalette.greyClr.withAlpha(50)
                                      : AppPalette.buttonClr),
                          secoundIconColor: slot.booked
                              ? AppPalette.greenClr.withAlpha(128)
                              : (isTimeExceeded
                                  ? AppPalette.whiteClr
                                  : AppPalette.whiteClr),
                          secoundIconBgColor: slot.booked
                              ? AppPalette.trasprentClr
                              : (isTimeExceeded
                                  ? AppPalette.redClr.withAlpha(50)
                                  : AppPalette.redClr),
                          label: slot.booked
                              ? 'Booked'
                              : slot.available
                                  ? (isTimeExceeded
                                      ? 'Available (Time Exceeded)'
                                      : 'Available')
                                  : (isTimeExceeded
                                      ? 'Unavailable (Time Exceeded)'
                                      : 'Unavailable'),
                          serviceRate: slot.time,
                          updateDeletIcon: slot.booked
                              ? CupertinoIcons.check_mark_circled
                              : CupertinoIcons.delete_solid,
                          updateIcon: slot.booked
                              ? CupertinoIcons.check_mark_circled
                              : CupertinoIcons.clear,
                          deleteAction: () {
                            if (slot.booked == false) {
                              context.read<ModifySlotsGenerateBloc>().add(
                                  RequestDeleteGeneratedSlotEvent(
                                      shopId: slot.shopId,
                                      docId: slot.docId,
                                      subDocId: slot.subDocId,
                                      time: slot.time));
                            }
                          },
                          updateOntap: () {
                            if (slot.booked == false &&
                                isTimeExceeded == false) {
                              context.read<ModifySlotsGenerateBloc>().add(
                                  ChangeSlotStatusEvent(
                                      shopId: slot.shopId,
                                      docId: slot.docId,
                                      subDocId: slot.subDocId,
                                      status: slot.available ? false : true));
                            }
                          },
                          updateAction: (value) {},
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.search, color: AppPalette.buttonClr),
                Text('Searching ...'),
                Text('Oops! Something went wrong. Try different date.')
              ],
            );
          },
        ),
      ),
      ConstantWidgets.hight50(context),
    ]);
  }
}

Row colorMarker(
    {required BuildContext context,
    required Color markColor,
    required String hintText}) {
  return Row(children: [
    Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: markColor,
          shape: BoxShape.rectangle,
        )),
    ConstantWidgets.width10(context),
    Text(hintText),
    ConstantWidgets.width40(context)
  ]);
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
