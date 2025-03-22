part of 'logout_bloc.dart';

abstract class LogoutEvent  {}

class LogoutActionEvent extends LogoutEvent {}
class ConfirmLogoutEvent extends LogoutEvent {}
class CancelLogoutEvent extends LogoutEvent {}
