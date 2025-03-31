import 'package:barber_pannel/cavlog/app/domain/usecases/image_picker_usecase.dart';
import 'package:bloc/bloc.dart';
part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final PickImageUseCase pickImageUseCase;
  ImagePickerBloc(this.pickImageUseCase) : super(ImagePickerInitial()) {
    on<PickImageAction>((event, emit) async{
       emit(ImagePickerLoading());
      try { 
        final imagePath = await pickImageUseCase();
        if (imagePath != null) {
          emit(ImagePickerSuccess(imagePath));
        }else{
          emit(ImagePickerError('Error due to: Select image'));
        }
      } catch (e) {
        emit(ImagePickerError("An Error occured:"));
      }
    });
  }
}
