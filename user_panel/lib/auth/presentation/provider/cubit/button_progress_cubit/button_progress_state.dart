part of 'button_progress_cubit.dart';

abstract class ButtonProgressState{}

final class ButtonProgressInitial extends ButtonProgressState {}
final class ButtonProgressLoading extends ButtonProgressState {}
final class ButtonProgressSuccess  extends ButtonProgressState {}

final class GoogleSignInLoadingButton extends ButtonProgressState {}
final class GoogleSignInSuccessButton extends ButtonProgressState {}

final class BottomSheetButtonLoading extends ButtonProgressState {}
final class BottomSheetButtonSuccess extends ButtonProgressState {}