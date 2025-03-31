import 'package:admin/domain/useCase/image_picker_usecase.dart';
import 'package:bloc/bloc.dart';
part 'pick_image_event.dart';
part 'pick_image_state.dart';

class PickImageBloc extends Bloc<PickImageEvent, PickImageState> {
  final PickImageUseCase pickImageUseCase;
  PickImageBloc(this.pickImageUseCase) : super(PickImageInitial()) {
    on<ImagePickerEvent>((event, emit)async {
      emit(ImagePickerLoading());
      try {
        final imagePath = await pickImageUseCase();
        if (imagePath != null) {
          emit(ImagePickerSuccess(imagePath));
        } else {
          emit(ImagePickerError('Select Image'));
        }
      } catch (e) {
        emit(ImagePickerError('An error occured: $e'));
      }
    });
  }
}
