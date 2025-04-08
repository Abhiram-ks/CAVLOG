part of 'login_bloc.dart';

sealed class LoginState{}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {}

final class LoginFiled extends LoginState {
  final String error;
  LoginFiled({required this.error});
}   

