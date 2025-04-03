part of 'location_bloc.dart';

abstract class LocationState {}

final class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState{
  final LatLng position;
  LocationLoaded(this.position);
}

class LocationError extends LocationState{
  final String message;
  LocationError(this.message);
}