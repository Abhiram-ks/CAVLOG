part of 'logout_bloc.dart';

abstract class LogoutState {}
final class LogoutInitial extends LogoutState {}
final class ShowLogoutDialog extends LogoutState {}
final class LogoutLoading extends LogoutState {}
final class LogoutSuccessState extends LogoutState {}
final class LogoutErrorState extends LogoutState {
  final String errorMessage;

  LogoutErrorState ({required this.errorMessage});
}
