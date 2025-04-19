import 'dart:developer';
import 'dart:io';

import 'package:barber_pannel/cavlog/app/data/datasources/firestore_barber_service.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/gender_cubit/gender_option_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/cloudinary/cloudinary_service.dart';
part 'upload_service_data_event.dart';
part 'upload_service_data_state.dart';

class UploadServiceDataBloc extends Bloc<UploadServiceDataEvent, UploadServiceDataState> {
  final CloudinaryService _cloudinaryService;
  final FirestoreBarberService _firestoreBarberService;
  String imagePath = '';
  GenderOption genderOption = GenderOption.unisex;
  
  UploadServiceDataBloc(this._firestoreBarberService, this._cloudinaryService) : super(UploadServiceDataInitial()) {
    on<UploadServiceDataRequest>((event, emit) {
     imagePath = event.imagePath;
     genderOption = event.genderOption;
     emit(UploadServiceDialogBox());
    });
    
    on<UploadServiceConfirmed>((event, emit) async{
      emit(UploadServiceLoadingState());
      try {
        String imageUrl = imagePath;

        if (!imagePath.startsWith('http')) {
          final response = await _cloudinaryService.uploadImage(File(imagePath));

          if (response == null) {
            emit(UploadServiceFailureState('Error due to: Image upload failed'));
            return;
          }
          imageUrl = response;
        }
         final SharedPreferences prefs = await SharedPreferences.getInstance();
         final String? barberUId = prefs.getString('barberUid');
         if (barberUId == null || barberUId.isEmpty) {
          emit(UploadServiceFailureState('Error due to: Barber uid not found'));
          return;
         }

          final String gender = genderOption.name;
          log('Uploadin new barber fileds: barberID : $barberUId, imageUrl: $imageUrl, Gender: $gender');
          final isSuccess = await _firestoreBarberService.uploadNewFirebaseBarberFileds(barberID: barberUId, imageUrl: imageUrl, gender: gender);
          if (isSuccess) {
            emit(UploadServiceSuccessState());
          } else {
            emit(UploadServiceFailureState('Error due to: Failed to update barber fileds'));
          }

      } catch (e) {  
        log('Error in upload service data: $e');
        emit(UploadServiceFailureState('Error due to: $e'));
      }
     
    });
  }
}
