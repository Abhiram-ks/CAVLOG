part of 'register_submition_bloc.dart';

abstract class RegisterSubmitionEvent{
}

class UpdatePersonalDetails extends RegisterSubmitionEvent {
  final String fullName;
  final String ventureName;
  final String phoneNumber;
  final String address;

  UpdatePersonalDetails ({required this.fullName,required this.ventureName,required this.phoneNumber,required this.address});
}

class UpdateCredentials  extends RegisterSubmitionEvent {
  final String email;
  final bool isVerified;
  final bool isBloc;
  final String password;

  UpdateCredentials ({required this.email, required this.isVerified, required this.password, required this.isBloc});
}

class SubmitRegistration extends RegisterSubmitionEvent {
  
}