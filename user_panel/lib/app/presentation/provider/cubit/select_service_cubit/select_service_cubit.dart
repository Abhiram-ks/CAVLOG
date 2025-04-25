

import 'package:bloc/bloc.dart';

class SelectServiceCubit extends Cubit<Set<String>> {
  SelectServiceCubit() : super({});

  void toggleService(String serviceName) {
    final updatedSet = Set<String>.from(state);

    if (updatedSet.contains(serviceName)) {
      updatedSet.remove(serviceName);
    }else {
      updatedSet.add(serviceName);
    }
    emit(updatedSet);
  }
  void clearAll() => emit({});
  
}