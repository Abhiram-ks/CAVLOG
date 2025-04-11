import 'package:flutter_bloc/flutter_bloc.dart';

class EditModeCubit extends Cubit<bool> {
  EditModeCubit() : super(false);

  void toggleEditMode() => emit(!state);
}