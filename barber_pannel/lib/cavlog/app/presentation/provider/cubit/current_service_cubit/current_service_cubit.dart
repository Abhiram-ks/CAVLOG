import 'package:flutter_bloc/flutter_bloc.dart';

enum CurrentServicePage {pageOne, pageTwo}

class ServicePageCubit extends Cubit<CurrentServicePage> {
  ServicePageCubit() : super(CurrentServicePage.pageOne);

  void goToPageOne() => emit(CurrentServicePage.pageOne);
  void goToPageTwo() => emit(CurrentServicePage.pageTwo);
}