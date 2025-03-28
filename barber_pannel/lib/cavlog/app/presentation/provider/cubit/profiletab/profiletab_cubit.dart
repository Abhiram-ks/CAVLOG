import 'package:bloc/bloc.dart';

class ProfiletabCubit extends Cubit<int> {
  ProfiletabCubit() : super(0);

  void switchTab(int index) => emit(index);
}
