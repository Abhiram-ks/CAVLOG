part of 'googlesign_bloc.dart';

abstract class GooglesignState {}

final class GooglesignInitial extends GooglesignState {}
final class GoogleSignLoading extends GooglesignState {}
final class GoogleSignSuccess extends GooglesignState {
  final String uid;
  GoogleSignSuccess(this.uid);
}
final class GoogleSignfailure extends GooglesignState {
  final String error;
  GoogleSignfailure(this.error);
}