import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_panel/app/presentation/widget/search_widget/booking_screen_widget/booking_chips_maker.dart';
import 'package:user_panel/core/common/custom_appbar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../../core/common/custom_actionbutton_widget.dart';
import '../../../../../../../core/themes/colors.dart';
import '../../../../../../../core/utils/constant/constant.dart';
import '../../../../../../data/models/date_model.dart';
import '../../../../../../data/repositories/fetch_barber_slots_dates.dart';
import '../../../../../provider/bloc/fetching_bloc/fetch_barber_details_bloc/fetch_barber_details_bloc.dart';
import '../../../../../provider/bloc/fetching_bloc/fetch_slots_dates_bloc/fetch_slots_dates_bloc.dart';
import '../../../../../provider/cubit/booking_cubits/calender_picker_cubit.dart/calender_picker_cubit.dart';

class BookingScreen extends StatelessWidget {
  final String shopId;
  const BookingScreen({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CalenderPickerCubit()),
        BlocProvider(
            create: (_) => FetchSlotsDatesBloc(FetchSlotsRepositoryImpl()))
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return ColoredBox(
          color: const Color.fromARGB(255, 241, 242, 243),
          child: SafeArea(
              child: Scaffold(
            appBar: CustomAppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Book Appointment',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      ConstantWidgets.hight10(context),
                      Text(
                          'Almost there! Pick a date, choose services, select a time slot, and proceed to payment.'),
                      ConstantWidgets.hight10(context),
                    ],
                  ),
                ),
                BookinScreenWidgets(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    barberid: shopId)
              ]),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
                width: screenWidth * 0.9,
                child: ButtonComponents.actionButton(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    label: 'Deal booking',
                    onTap: () {})),
          )),
        );
      }),
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

class BookinScreenWidgets extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String barberid;

  const BookinScreenWidgets(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.barberid});

  @override
  State<BookinScreenWidgets> createState() => _BookinScreenWidgetsState();
}

class _BookinScreenWidgetsState extends State<BookinScreenWidgets> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<FetchSlotsDatesBloc>()
          .add(FetchSlotsDateRequest(barberId: widget.barberid));
      context
          .read<FetchBarberDetailsBloc>()
          .add(FetchBarberServicesRequested(widget.barberid));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookingCalenderBlocBuilder(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstantWidgets.hight10(context),
              Text('Choose Service',style: TextStyle(fontWeight: FontWeight.w900)),
              BlocBuilder<FetchBarberDetailsBloc, FetchBarberDetailsState>(
                builder: (context, state) {
                  if (state is FetchBarberServicesEmpty) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.face_retouching_natural),
                          ConstantWidgets.width40(context),
                          Text('Still waiting for that first style.'),
                        ],
                      ),
                    );
                  } else if (state is FetchBarberServiceSuccess) {
                    final services = state.barberServices;
                    return SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: services.length,
                        separatorBuilder: (context, index) =>
                            ConstantWidgets.width40(context),
                        itemBuilder: (context, index) {
                          final service = services[index];
                          return ClipChipMaker.build(
                            text: "${service.serviceName}   ₹ ${service.amount}",
                            actionColor: AppPalette.hintClr,
                            textColor: AppPalette.blackClr,
                            backgroundColor: AppPalette.scafoldClr ?? AppPalette.hintClr,
                            borderColor: AppPalette.hintClr,
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => ConstantWidgets.width40(context),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey[300] ?? AppPalette.greyClr,
                            highlightColor: AppPalette.whiteClr,
                            child: ClipChipMaker.build(
                              text: 'HairCut ₹150',
                              actionColor: AppPalette.hintClr,
                              textColor: AppPalette.blackClr,
                              backgroundColor:AppPalette.scafoldClr ?? AppPalette.hintClr,
                              borderColor: AppPalette.greyClr,
                              onTap: () {},
                            ),
                        );
                      },
                    ),
                  );
                },
              ),
              ConstantWidgets.hight10(context),
              Text('Available time',style: TextStyle(fontWeight: FontWeight.w900)),
              
            ],
          ),
        )
      ],
    );
  }
}

class BookingCalenderBlocBuilder extends StatelessWidget {
  const BookingCalenderBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalenderPickerCubit, CalenderPickerState>(
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
                        //context.read<FetchSlotsSpecificdateBloc>().add(FetchSlotsSpecificdateRequst(selectedDay));
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
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
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
    );
  }
}
