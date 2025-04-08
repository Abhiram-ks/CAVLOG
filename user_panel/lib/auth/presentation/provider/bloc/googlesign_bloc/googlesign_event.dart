part of 'googlesign_bloc.dart';

abstract class GooglesignEvent {}
final class GoogleSignInRequested extends GooglesignEvent {
  final BuildContext context;
  GoogleSignInRequested(this.context);
}
