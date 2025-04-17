part of 'fetch_allbarber_bloc.dart';

abstract class FetchAllbarberEvent {}
class FetchAllBarbersRequested extends FetchAllbarberEvent {}
class SearchBarbersRequested extends FetchAllbarberEvent {
  final String searchTerm;

  SearchBarbersRequested(this.searchTerm);
}