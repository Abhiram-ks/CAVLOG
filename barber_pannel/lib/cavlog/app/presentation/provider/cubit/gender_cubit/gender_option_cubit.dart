import 'package:bloc/bloc.dart';


enum GenderOption {male, female, unisex}

class GenderOptionCubit extends Cubit<GenderOption> {
  GenderOptionCubit() : super(GenderOption.unisex);

  void selectGenderOption(GenderOption gender) {
    emit(gender);
  }
}
