part of 'login_bloc.dart';

abstract class LoginState {
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {
  final BarberModel barber;

   LoginSuccess({required this.barber});

}
final class LoginFiled extends LoginState {
  final String error;
   LoginFiled({required this.error});
}

final class LoginVarified extends LoginState {}
final class LoginNotVerified extends LoginState {}