part of 'reset_password_bloc.dart';
abstract class ResetPasswordEvent{}
final class ResetPasswordRequestEvent extends ResetPasswordEvent {
  final String email;

  ResetPasswordRequestEvent ({required this.email});
}
