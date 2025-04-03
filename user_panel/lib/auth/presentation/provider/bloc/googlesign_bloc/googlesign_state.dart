part of 'googlesign_bloc.dart';

sealed class GooglesignState extends Equatable {
  const GooglesignState();
  
  @override
  List<Object> get props => [];
}

final class GooglesignInitial extends GooglesignState {}
