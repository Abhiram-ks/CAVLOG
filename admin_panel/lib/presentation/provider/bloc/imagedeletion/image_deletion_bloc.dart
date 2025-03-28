import 'package:admin/domain/useCase/delete_image_url_usecase.dart';
import 'package:bloc/bloc.dart';
part 'image_deletion_event.dart';
part 'image_deletion_state.dart';

class ImageDeletionBloc extends Bloc<ImageDeletionEvent, ImageDeletionState> {
  final FirestoreImageServiceDeletion firestoreService;
  String _imageUrl = '';
  int _index = 0;
  int _imageIndex = 0;

  String get imageUrlId => _imageUrl;
  int get indexId => _index;
  int get imageIndexId => _imageIndex;

  ImageDeletionBloc(this.firestoreService) : super(ImageDeletionInitial()) {
    on<ImageDeletionAction>((event, emit) {
      _imageUrl = event.imageUrl;
      _index = event.index;
      _imageIndex = event.imageIndex;
      emit(ShowAlertConfirmation());
    });


    on<ImageDeletionConfirm>((event, emit) async{
      emit(ImageDeletionProcess());
      try {
         bool isDeleted = await firestoreService.deleteImageUrl(imageUrl: _imageUrl, index: _index, imageIndex: _imageIndex);

         if (isDeleted) {
           emit(ImageDeletionSuccess());
         } else {            
           emit(ImageDeletionFailure("Failed to delete the Image."));
         }
      } catch (e) {
        emit(ImageDeletionFailure("An error occurred $e"));
      }
    });
  }
}
