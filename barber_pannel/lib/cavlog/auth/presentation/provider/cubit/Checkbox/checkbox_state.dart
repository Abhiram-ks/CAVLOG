part of 'checkbox_cubit.dart';

sealed class CheckboxState extends Equatable {
  const CheckboxState();

  @override
  List<Object> get props => [];
}

final class CheckboxUnchecked   extends CheckboxState {}
final class CheckboxChecked  extends CheckboxState {}