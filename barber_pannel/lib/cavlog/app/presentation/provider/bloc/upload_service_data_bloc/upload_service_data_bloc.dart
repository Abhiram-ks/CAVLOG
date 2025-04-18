import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/gender_cubit/gender_option_cubit.dart';
import 'package:bloc/bloc.dart';
part 'upload_service_data_event.dart';
part 'upload_service_data_state.dart';

class UploadServiceDataBloc extends Bloc<UploadServiceDataEvent, UploadServiceDataState> {
  String? imagePath;
  GenderOption? genderOption;
  
  UploadServiceDataBloc() : super(UploadServiceDataInitial()) {
    on<UploadServiceDataRequest>((event, emit) {
     imagePath = event.imagePath;
     genderOption = event.genderOption;
     emit(UploadServiceDialogBox());
    });
  }
}
