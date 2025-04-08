import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:user_panel/app/domain/usecases/update_user_profile.dart';
import 'package:user_panel/auth/data/datasources/auth_local_datasource.dart';
import 'package:user_panel/core/cloudinary/cloudinary_service.dart';
part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final CloudinaryService _cloudinaryService;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  String _userName = '';
  String _phoneNumber = '';
  String _address = '';
  String _image = '';
  int _age = 0;

  String get userName => _userName;
  String get phoneNumber => _phoneNumber;
  String get address => _address;
  String get image => _image;
  int get age => _age;



  UpdateProfileBloc(this._cloudinaryService, this._updateUserProfileUseCase) : super(UpdateProfileInitial()) {

    on<UpdateProfileRequest>((event, emit) {
      log('Image Updateing Url or path : ${event.image}');
      _userName = event.userName;
      _phoneNumber = event.phoneNumber;
      _address = event.address;
      _image = event.image;
      _age = event.age;
      emit(ShowConfirmAlertBox());
    });

    on<ConfirmUpdateRequest>((event, emit)async {
      emit(UpdateProfileLoading());
      try {
       String imageUrl = _image;
         if (_image.isEmpty) {
           imageUrl = '';
         }else if (!_image.startsWith('http')) {
          final response = await _cloudinaryService.uploadImage(File(_image));
          if (response == null) {
            emit(UpdateProfileFailure("Image upload failed."));
            return;
          }
          imageUrl = response;
        }
 
        final credentials = await SecureStorageService.getUserCredentials();
        final uid = credentials['userId'];

        if (uid == null || uid.isEmpty) {
          emit(UpdateProfileFailure('Error: User ID not found in Secrure storage.'));
          return;
        }
        final isSuccess = await _updateUserProfileUseCase.updateUSerProfile(uid: uid,
        address: _address,
        userName: _userName,
        phoeNumber: _phoneNumber,
        image: imageUrl,
        age: _age,
        );

        if (isSuccess) {
          emit(UpdateProfileSuccess());
        } else {
          emit(UpdateProfileFailure('Failed to update Profile.'));
        }
      } catch (e) {
        log('Profile updation failed due to $e');
        emit(UpdateProfileFailure('Something went wrong: $e'));
      }
    });
  }
}
