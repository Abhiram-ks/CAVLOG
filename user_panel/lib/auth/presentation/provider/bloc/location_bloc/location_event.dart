part of 'location_bloc.dart';

abstract class LocationEvent{}
class GetCurrentLocationEvent extends LocationEvent {}
class UpdateLocationEvent extends LocationEvent {
  final LatLng newPosition;
  UpdateLocationEvent(this.newPosition);
}
