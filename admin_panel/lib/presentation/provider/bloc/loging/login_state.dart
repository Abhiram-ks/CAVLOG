part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}
final class LodingState extends LoginState {}
final class LoginSuccess extends LoginState {}
final class LoginFiled extends LoginState{
  final String error;

  const LoginFiled({required this.error});

  @override 
  List<Object> get props => [error];
}