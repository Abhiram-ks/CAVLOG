import 'package:bloc/bloc.dart';

class TabCubit extends Cubit<int> {
  TabCubit() : super(2);

  void changeTab(int index) => emit(index);
}