part of 'logout_bloc.dart';

abstract class LogoutEvent{}
final class LogoutActionEvent extends LogoutEvent {
}
final class LogoutConfirmationEvent extends LogoutEvent{}
