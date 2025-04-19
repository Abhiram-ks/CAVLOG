import 'package:bloc/bloc.dart';


enum GenderOption {male, female, unisex}

class GenderOptionCubit extends Cubit<GenderOption> {
  GenderOptionCubit({required GenderOption initialGender}) : super(initialGender);

  void selectGenderOption(GenderOption gender) {
    emit(gender);
  }
}
