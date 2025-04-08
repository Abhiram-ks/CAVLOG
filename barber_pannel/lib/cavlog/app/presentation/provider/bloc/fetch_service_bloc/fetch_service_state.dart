part of 'fetch_service_bloc.dart';

abstract class FetchServiceState{}

final class FetchServiceInitial extends FetchServiceState {}
final class FetchServiceLoading extends FetchServiceState {}
final class FetchServiceLoaded extends FetchServiceState{
  final List<ServiceModel> service;
  FetchServiceLoaded({required this.service});
}

final class FetchServiceError extends FetchServiceState {
  final String errorMessage;
  FetchServiceError (this.errorMessage);
}
