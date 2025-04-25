part of 'upload_post_bloc.dart';

abstract class UploadPostEvent {}

final class UploadPostEventRequst extends UploadPostEvent {
  final String barberId;
  final String imageUrl;
  final String description;

  UploadPostEventRequst({
    required this.barberId,
    required this.imageUrl,
    required this.description,
  });
}

final class UploadPostConfirmed extends UploadPostEvent {}
