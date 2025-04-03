part of 'serchlocaton_bloc.dart';

abstract class SerchlocatonEvent  {}
class SearchLocationEvent extends SerchlocatonEvent {
  final String query;
  SearchLocationEvent(this.query);
}

class SelectLocationEvent extends SerchlocatonEvent {
  final double latitude;
  final double longitude;
  final String address;
  SelectLocationEvent(this.latitude, this.longitude, this.address);
}
