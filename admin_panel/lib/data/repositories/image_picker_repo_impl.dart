import 'package:admin/domain/useCase/image_picker_usecase.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerRepositoryImpl implements ImagePickerRepository{
  final ImagePicker _imagePicker;
  
  ImagePickerRepositoryImpl(this._imagePicker);

  @override
  Future<String?> pickImage() async{
  final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
  return image?.path;                                                                      
  }
}

