part of 'requstbox_bloc.dart';

abstract class RequstboxState{}

final class RequstboxInitial extends RequstboxState {}
final class AcceptAllertbox extends RequstboxState {}
final class AcceptAlertsuccess extends RequstboxState {}


final class RejectAllowAlertBox extends RequstboxState {}
final class RejectAlertBoxSuccess extends RequstboxState {}
final class RequstboxError extends RequstboxState{
  final String error;

  RequstboxError({required this.error});
}

final class RequstboxLoading extends RequstboxState{}