part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent {}

final class UpdateProfileRequest extends UpdateProfileEvent {
  final String image;
  final String userName;
  final String phoneNumber;
  final String address;
  final int age;

  UpdateProfileRequest({
    required this.image,
    required this.userName,
    required this.phoneNumber,
    required this.address,
    required this.age,
  });
}

final class ConfirmUpdateRequest extends UpdateProfileEvent {}