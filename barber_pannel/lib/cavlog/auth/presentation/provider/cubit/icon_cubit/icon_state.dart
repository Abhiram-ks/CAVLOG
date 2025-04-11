part of 'icon_cubit.dart';

sealed class IconState extends Equatable {

  
  const IconState();

  @override
  List<Object> get props => [];
}

final class IconInitial extends IconState {}

class ColorUpdated extends IconState {
  final Color color;

  const ColorUpdated({required this.color});

  @override
  List<Object> get props => [ color];
}


class PasswordVisibilityUpdated extends IconState {
  final bool isVisible;

  const PasswordVisibilityUpdated({required this.isVisible});
  
  @override
  List<Object> get props => [isVisible];
}