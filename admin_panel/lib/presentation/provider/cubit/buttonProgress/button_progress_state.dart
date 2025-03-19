part of 'button_progress_cubit.dart';

sealed class ButtonProgressState extends Equatable {
  const ButtonProgressState();

  @override
  List<Object> get props => [];
}

final class ButtonProgressInitial extends ButtonProgressState {}
final class ButtonProgressLoading extends ButtonProgressState {}
final class ButtonProgressSuccess  extends ButtonProgressState {}
