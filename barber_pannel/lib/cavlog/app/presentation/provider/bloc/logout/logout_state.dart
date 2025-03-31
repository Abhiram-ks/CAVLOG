part of 'logout_bloc.dart';

abstract class LogoutState {}

final class LogoutInitial extends LogoutState {}
final class ShowLogoutAlertState extends LogoutState {}
final class LogoutSuccessState extends LogoutState{}
final class LogoutErrorState extends LogoutState {
 final String message;
 LogoutErrorState(this.message);
}
