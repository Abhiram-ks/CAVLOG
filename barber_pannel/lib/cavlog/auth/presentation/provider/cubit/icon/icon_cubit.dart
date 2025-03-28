import 'package:barber_pannel/core/themes/colors.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'icon_state.dart';

class IconCubit extends Cubit<IconState> {
  IconCubit() : super(IconInitial());

  void updateIcon(bool isMaxLength,){
    emit(
      ColorUpdated(
        color: isMaxLength ? AppPalette.greenClr : AppPalette.hintClr,)
    );
  }

  void togglePasswordVisibility(bool isVisible){
    emit(PasswordVisibilityUpdated(isVisible: !isVisible));
  }

} 
