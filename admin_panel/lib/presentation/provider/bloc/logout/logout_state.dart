part of 'logout_bloc.dart';

abstract class LogoutState{}

final class LogoutInitial extends LogoutState {}
class ShowLogoutDialogState extends LogoutState{}
class LogoutSuccessState extends LogoutState{}
class LogoutCancelState extends LogoutState{}
class LogoutFailureState extends LogoutState{
  final String  message;

  LogoutFailureState(this.message);
}
