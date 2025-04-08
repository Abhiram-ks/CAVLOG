abstract class ImagePickerRepository {
  Future<String?> pickImage();
}

class PickImageUseCase {
  final ImagePickerRepository repository;

  PickImageUseCase(this.repository);

  Future<String?> call() async{
    return await repository.pickImage();
  }
}