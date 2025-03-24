part of 'requstbox_bloc.dart';

abstract class RequstboxEvent {}
class AcceptAction extends RequstboxEvent {
  final String barberName;
  final String uid;
  final String email;
  final String ventureName;

  AcceptAction({required this.barberName, required this.uid, required this.email, required this.ventureName});
}
class AcceptActionAllow extends RequstboxEvent {}

class RejectAction extends RequstboxEvent {
final String barbername;
 final String uid;
 final String email;
 final String ventureName;
 
 RejectAction({required this.barbername, required this.uid, required this.email, required this.ventureName});
}

class RejectActionCancel extends RequstboxEvent {}
class RejectActionAllowReason extends RequstboxEvent {
  final String reason;
  RejectActionAllowReason({required this.reason});
}

