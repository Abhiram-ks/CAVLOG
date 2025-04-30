import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../presentation/provider/cubit/booking_generate_cubit/duration_picker/duration_picker_cubit.dart';



class SlotGenerator {
  static List<String> generateSlots({
    required DateTime date,
    required TimeOfDay start,
    required TimeOfDay end,
    required DurationTime duration,
  }) {
    IntravelConverter converter = IntravelConverter(duration);
    Duration slotDuration = converter.getDurationType();

    final DateTime startDateTime = DateTime(date.year, date.month, date.day, start.hour, start.minute);
    final DateTime endDateTime = DateTime(date.year, date.month, date.day, end.hour, end.minute);

    List<String> slotList = [];

    DateTime currentSlotTime = startDateTime;
    while (currentSlotTime.isBefore(endDateTime)) {
      if (currentSlotTime.add(slotDuration).isAfter(endDateTime)) {
        break;
      }
      String formattedTime = DateFormat.jm().format(currentSlotTime);
      slotList.add(formattedTime);

      currentSlotTime = currentSlotTime.add(slotDuration);
    }
    
    log('Generated slots Are: $slotList');
    return slotList;
  }
}



class IntravelConverter {
  DurationTime duration;

  IntravelConverter(this.duration);

  Duration getDurationType() {
    switch (duration) {
      case DurationTime.basic:
        return Duration(minutes: 30);
      case DurationTime.standard:
        return Duration(minutes: 45);
      case DurationTime.elite:
        return Duration(hours: 1);
    }
  }
}