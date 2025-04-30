part of 'fetch_user_bloc.dart';

abstract class FetchUserState{}

final class FetchUserInitial extends FetchUserState {}
final class FetchUserLoading extends FetchUserState {}
final class FetchUserLoaded  extends FetchUserState {
  final UserModel user;
  FetchUserLoaded({required this.user});
}

final class FetchUserError extends FetchUserState {
  final String errorMessage;
  FetchUserError (this.errorMessage);
}
