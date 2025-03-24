part of 'fetching_service_bloc.dart';

abstract class FetchingServiceState  {}

final class FetchingServiceInitial extends FetchingServiceState {}

class ServiceEmptyState extends FetchingServiceState{}
class ServiceLoadedState extends FetchingServiceState{
  final List<ServiceModels> services;
  ServiceLoadedState(this.services);
}


class ServiceFechingErrorState extends FetchingServiceState {
  final String error;
  ServiceFechingErrorState(this.error);
}


