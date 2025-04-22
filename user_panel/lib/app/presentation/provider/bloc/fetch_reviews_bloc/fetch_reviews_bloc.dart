import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_reviews_event.dart';
part 'fetch_reviews_state.dart';

class FetchReviewsBloc extends Bloc<FetchReviewsEvent, FetchReviewsState> {
  FetchReviewsBloc() : super(FetchReviewsInitial()) {
    on<FetchReviewsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
