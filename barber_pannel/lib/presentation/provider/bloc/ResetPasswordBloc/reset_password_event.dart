part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent {
}

class ResetPasswordRequested extends ResetPasswordEvent {
  final String email;
  ResetPasswordRequested({required this.email});
}

