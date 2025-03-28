part of 'register_submition_bloc.dart';

abstract class RegisterSubmitionState  extends Equatable{
    @override
  List<Object?> get props => [];
}

final class RegisterSubmitionInitial extends RegisterSubmitionState {}


class RegisterSuccess  extends RegisterSubmitionState {}

class RegisterFailure extends RegisterSubmitionState {
  final String error;

   RegisterFailure({required this.error});
  @override
  List<Object?> get props => [error];
}

class OtpLoading extends  RegisterSubmitionState {}
class OtpSuccess extends  RegisterSubmitionState{}
class OtpFailure extends RegisterSubmitionState {
  final String error;

  OtpFailure({required this.error});

  @override
   List<Object?> get props => [error];
}


//OTP varification states
class OtpVarifyed extends RegisterSubmitionState{}
class OtpExpired extends RegisterSubmitionState {}
class OtpIncorrect extends RegisterSubmitionState{
  final String error;

  OtpIncorrect({required this.error});

  @override
   List<Object?> get props => [error];
}
