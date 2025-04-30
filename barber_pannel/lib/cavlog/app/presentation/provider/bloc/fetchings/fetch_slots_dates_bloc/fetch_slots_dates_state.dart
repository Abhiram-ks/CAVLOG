part of 'fetch_slots_dates_bloc.dart';

@immutable
abstract class FetchSlotsDatesState {}

final class FetchSlotsDatesInitial extends FetchSlotsDatesState {}

final class FetchSlotsDateLoading extends FetchSlotsDatesState {}
final class FetchSlotsDatesSuccess extends FetchSlotsDatesState {
  final List<DateModel> dates;
  
  FetchSlotsDatesSuccess(this.dates);
}


final class FetchSlotsDateFailure extends FetchSlotsDatesState {
  final String errorMessage;

   FetchSlotsDateFailure(this.errorMessage);
}
