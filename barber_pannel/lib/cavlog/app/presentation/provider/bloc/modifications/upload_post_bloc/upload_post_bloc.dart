import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';

import '../../../../../../../core/cloudinary/cloudinary_service.dart';
import '../../../../../domain/usecases/upload_post_usecase.dart';
part 'upload_post_event.dart';
part 'upload_post_state.dart';

class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {
  String barberId = '';
  String imageUrl = '';
  String description = '';

  final CloudinaryService _cloudinaryService;
  final UploadPostUsecase _uploadPostUsecase;
  UploadPostBloc(this._cloudinaryService, this._uploadPostUsecase)
      : super(UploadPostInitial()) {
    on<UploadPostEventRequst>((event, emit) {
      barberId = event.barberId;
      imageUrl = event.imageUrl;
      description = event.description;
      log('File(ImageUrl) : $imageUrl');
      emit(UploadPostShowAlert());
    });

    on<UploadPostConfirmed>((event, emit) async {
      emit(UploadPostLoading());
      try {
        if (imageUrl.isEmpty) {
          emit(UploadPostFailure(
              errorMessage: 'Error due to: Image not regonized'));
          return;
        }
        
        log('File(ImageUrl) : $imageUrl');
        final response = await _cloudinaryService.uploadImage(File(imageUrl));
        if (response == null) {
          emit(UploadPostFailure(
              errorMessage: 'Error due to: Image upload failed'));
          return;
        }
         imageUrl = response;
        final isSuccess = await _uploadPostUsecase.call(
        barberId: barberId, imageUrl: imageUrl, description: description);

        if (isSuccess) {
          emit(UploadPostSuccess());
        } else {
          emit(UploadPostFailure(errorMessage: 'Error: Post upload failed.'));
        }
      } catch (e) {
        emit(UploadPostFailure(errorMessage: 'Error due to: $e'));
      }
    });
  }
}
