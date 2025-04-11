import 'package:bloc/bloc.dart';

enum BottomNavItem {home, revenue, service, chat, profile}

class ButtomNavCubit extends Cubit<BottomNavItem> {
  ButtomNavCubit() : super(BottomNavItem.home);

  void selectItem(BottomNavItem item){
    emit(item);
  }
}