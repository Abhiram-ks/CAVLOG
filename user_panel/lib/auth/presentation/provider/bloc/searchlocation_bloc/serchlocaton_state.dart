part of 'serchlocaton_bloc.dart';

abstract class SerchlocatonState {
}

final class SerchlocatonInitial extends SerchlocatonState {}
class SearchLocationError extends SerchlocatonState{
  final String message;
  SearchLocationError(this.message);
}
class SearchLocationLoaded extends SerchlocatonState{
  final List<dynamic> suggestions;
  SearchLocationLoaded(this.suggestions);
}
class LocationSelected extends SerchlocatonState {
  final double latitude;
  final double longitude;
  final String address;
  LocationSelected(this.latitude, this.longitude, this.address);
}