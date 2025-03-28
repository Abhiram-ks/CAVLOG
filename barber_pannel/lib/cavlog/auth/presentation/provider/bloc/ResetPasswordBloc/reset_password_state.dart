part of 'reset_password_bloc.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();
  
  @override
  List<Object?> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState{}
class ResetPasswordSuccess extends ResetPasswordState{}
class ResetPasswordFailure extends ResetPasswordState{
  final String error;

 const ResetPasswordFailure(this.error);

  @override
  List<Object?> get props => [error];
}