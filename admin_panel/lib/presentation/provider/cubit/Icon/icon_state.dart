part of 'icon_cubit.dart';

sealed class IconState extends Equatable {

  
  const IconState();

  @override
  List<Object> get props => [];
}

final class IconInitial extends IconState {}

class PasswordVisibilityUpdated extends IconState {
  final bool isVisible;

  const PasswordVisibilityUpdated({required this.isVisible});
  
  @override
  List<Object> get props => [isVisible];
}