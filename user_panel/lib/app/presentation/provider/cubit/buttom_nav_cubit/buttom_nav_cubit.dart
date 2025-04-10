import 'package:bloc/bloc.dart';

enum BottomNavItem {home, search, post, chat, profile}

class ButtomNavCubit extends Cubit<BottomNavItem> {
  ButtomNavCubit() : super(BottomNavItem.home);
  
  void selectItem (BottomNavItem item) {
    emit(item);
  }
}
