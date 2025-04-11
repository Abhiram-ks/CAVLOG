import 'package:bloc/bloc.dart';
part 'service_select_state.dart';

class ServiceSelectCubit extends Cubit<ServiceSelectState> {
  ServiceSelectCubit() : super(ServiceSelectState());

  void selectService(String name){
    emit(ServiceSelectState(isEnabled: true, selectedServiceName:  name));
  }
}