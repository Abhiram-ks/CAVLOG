part of 'login_bloc.dart';

abstract class LoginEvent{}
class LoginActionEvent extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context;

  LoginActionEvent(this.context, {required this.email, required this.password});
}