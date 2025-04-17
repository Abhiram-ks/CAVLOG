part of 'button_progress_cubit.dart';

abstract class ButtonProgressState {
  const ButtonProgressState();
}

final class ButtonProgressInitial extends ButtonProgressState {}
final class ButtonProgressLoading extends ButtonProgressState {}
final class ButtonProgressSuccess  extends ButtonProgressState {}


final class BottomSheetButtonLoading extends ButtonProgressState {}
final class BottomSheetButtonSuccess extends ButtonProgressState {}