part of 'fetch_slots_dates_bloc.dart';

@immutable
abstract class FetchSlotsDatesEvent{}
final class FetchSlotsDateRequest extends FetchSlotsDatesEvent{
  final String barberId;

  FetchSlotsDateRequest({required this.barberId});
}
