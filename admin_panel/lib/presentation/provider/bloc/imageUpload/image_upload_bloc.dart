import 'dart:io';
import 'package:admin/data/datasources/cloudinary_service/cloudinary_service.dart';
import 'package:admin/data/datasources/cloudinary_service/firestore_image_service.dart';
import 'package:bloc/bloc.dart';

part 'image_upload_event.dart';
part 'image_upload_state.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  final FirestoreImageService _firestoreImageService;
  final CloudinaryService _cloudinaryService;
  ImageUploadBloc(this._firestoreImageService, this._cloudinaryService) : super(ImageUploadInitial()) {
    on<ImageUploadRequested>((event, emit) async{
     emit(ImageUploadLoading());
      try {
        final uploadedUrl = await _cloudinaryService.uploadImage(File(event.imageUrl));
        if (uploadedUrl == null) {
          emit(ImageUploadError('Failed to upload image to Cloudinary'));
          return;
        }
        final success  = await _firestoreImageService.selectionSlot(uploadedUrl, event.index);
        if(success){  
          emit(ImageUploadSuccess());
        }else{
          emit(ImageUploadError('Failed to Upload Image'));
        }
      } catch (e) {
         emit(ImageUploadError('Failed: $e'));
      }
    });
  }
}
