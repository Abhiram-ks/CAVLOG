part of 'slot_delete_privious_cubit.dart';


@immutable
abstract class SlotDeletePriviousState {}

final class SlotDeletePriviousInitial extends SlotDeletePriviousState {}
final class SlotDeletePriviousDeleted extends SlotDeletePriviousState {}
final class SlotDeletePriviousError   extends SlotDeletePriviousState {
  final String errorMessage;

  SlotDeletePriviousError(this.errorMessage);
}
