import 'package:bloc/bloc.dart';

part 'service_tags_cubit_state.dart';

class ServiceTagsCubitCubit extends Cubit<ServiceTagsCubitState> {
  ServiceTagsCubitCubit() : super(ServiceTagsCubitInitial());
  void toggleActions(bool currentVisibility) {
    if (currentVisibility) {
      emit(ServiceTagsHideActions());
    } else {
      emit(ServiceTagsShowActions());
    }
  }
}