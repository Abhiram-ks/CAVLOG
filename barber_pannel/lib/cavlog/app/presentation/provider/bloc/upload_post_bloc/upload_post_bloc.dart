import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_post_event.dart';
part 'upload_post_state.dart';

class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {
  final String barberId = '';
  final String imageUrl = '';
  final String description = '';


  UploadPostBloc() : super(UploadPostInitial()) {
    on<UploadPostEventRequst>((event, emit) {
      
    });
  }
}
