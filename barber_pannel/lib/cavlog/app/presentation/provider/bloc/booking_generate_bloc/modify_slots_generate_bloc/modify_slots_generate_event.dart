part of 'modify_slots_generate_bloc.dart';


@immutable
abstract class ModifySlotsGenerateEvent{}

final class ChangeSlotStatusEvent extends ModifySlotsGenerateEvent {
  final String shopId;
  final String docId;
  final String subDocId;
  final bool status;

  ChangeSlotStatusEvent({
    required this.shopId,
    required this.docId,
    required this.subDocId,
    required this.status,
  });
}


final class RequestDeleteGeneratedSlotEvent extends ModifySlotsGenerateEvent {
  final String shopId;
  final String docId;
  final String subDocId;
  final String time;

  RequestDeleteGeneratedSlotEvent({
    required this.shopId,
    required this.docId,
    required this.subDocId,
    required this.time,
  });
}

final class ConfirmDeleteGeneratedSlotEvent extends ModifySlotsGenerateEvent {}
