part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginActionEvent extends LoginEvent {
  final String email;
  final String password;

  LoginActionEvent({required this.email, required this.password});
}
