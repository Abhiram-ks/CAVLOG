part of 'register_bloc.dart';

abstract class RegisterEvent{}
final class RegisterPersonalData extends RegisterEvent{
  final String fullName;
  final String phoneNumber;
  final String address;

  RegisterPersonalData({required this.fullName, required this.phoneNumber, required this.address});
}

final class RegisterCredentialsData extends RegisterEvent {
  final String email;
  final String password;

  RegisterCredentialsData({required this.email, required this.password});
}

final class GenerateOTPEvent extends RegisterEvent{}
final class VerifyOTPEvent   extends RegisterEvent{
  final String inputOtp;
  VerifyOTPEvent({required this.inputOtp});
}

class RegisterSubmit extends RegisterEvent {}