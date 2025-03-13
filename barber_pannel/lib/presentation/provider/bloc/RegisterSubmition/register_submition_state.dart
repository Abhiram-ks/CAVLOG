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