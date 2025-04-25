part of 'adimin_service_bloc.dart';

abstract class AdiminServiceState {
}

final class AdiminServiceInitial extends AdiminServiceState {}

final class FetchServiceLoading extends AdiminServiceState {}
final class FetchServiceLoaded extends AdiminServiceState{
  final List<AdminServiceModel> service;
  FetchServiceLoaded({required this.service});
}

final class FetchServiceError extends AdiminServiceState {
  final String errorMessage;
  FetchServiceError (this.errorMessage);
}
