part of 'register_bloc.dart';

abstract class RegisterState {}
final class RegisterInitial extends RegisterState {}

final class RegisterSuccess extends RegisterState {}
final class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}

//otp generat states
final class OtpLoading extends RegisterState {}
final class OtpSuccess extends RegisterState {}
final class OtpFailure extends RegisterState {
  final String error;
  OtpFailure(this.error);
}

//otp varification states
final class OtpVarifyed extends RegisterState{}
final class OtpExpired extends RegisterState {}
final class OtpIncorrect extends RegisterState {
  final String error;
  OtpIncorrect(this.error);
}
