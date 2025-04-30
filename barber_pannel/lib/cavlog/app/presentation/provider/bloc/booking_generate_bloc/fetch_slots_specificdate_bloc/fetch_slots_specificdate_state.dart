part of 'fetch_slots_specificdate_bloc.dart';


@immutable
abstract class FetchSlotsSpecificDateState  {}

final class FetchSlotsSpecificDateInitial  extends FetchSlotsSpecificDateState  {}

final class FetchSlotsSpecificDateLoading  extends FetchSlotsSpecificDateState  {}
final class FetchSlotsSpecificDateEmpty    extends FetchSlotsSpecificDateState  {
  final DateTime salectedDate;
  FetchSlotsSpecificDateEmpty(this.salectedDate);
}
final class FetchSlotsSpecificDateLoaded   extends FetchSlotsSpecificDateState  {
  final List<SlotModel> slots;

  FetchSlotsSpecificDateLoaded ({required this.slots});
}

final class FetchSlotsSpecificDateFailure  extends FetchSlotsSpecificDateState  {
  final String errorMessage;

  FetchSlotsSpecificDateFailure (this.errorMessage);
}