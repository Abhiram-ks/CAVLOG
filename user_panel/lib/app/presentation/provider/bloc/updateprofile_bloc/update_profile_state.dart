part of 'update_profile_bloc.dart';

abstract class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}

final class ShowConfirmAlertBox extends UpdateProfileState {}

final class UpdateProfileLoading extends UpdateProfileState {}

final class UpdateProfileSuccess extends UpdateProfileState {}

final class UpdateProfileFailure extends UpdateProfileState {
  final String errorMessage;

  UpdateProfileFailure(this.errorMessage);
}
