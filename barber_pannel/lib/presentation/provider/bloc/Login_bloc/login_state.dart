part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {
  final BarberModel barber;

  const LoginSuccess({required this.barber});

  @override
  List<Object> get props => [barber];
}
final class LoginFiled extends LoginState {
  final String error;

  const LoginFiled({required this.error});

  @override 
  List<Object> get props => [error];
}

final class LoginVarified extends LoginState {}
final class LoginNotVerified extends LoginState {}