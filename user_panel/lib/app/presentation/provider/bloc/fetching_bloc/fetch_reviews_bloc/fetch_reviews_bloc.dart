import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:user_panel/app/data/models/review_model.dart';
import 'package:user_panel/app/data/repositories/fetch_reviews_details_repo.dart';
part 'fetch_reviews_event.dart';
part 'fetch_reviews_state.dart';

class FetchReviewsBloc extends Bloc<FetchReviewsEvent, FetchReviewsState> {
  final FetchReviewsDetailsRepository _repository;
  FetchReviewsBloc(this._repository) : super(FetchReviewsInitial()) {
    on<FetchReviewRequest>(_onFetchReviewRequest);
  }

  Future<void> _onFetchReviewRequest (
    FetchReviewRequest event, Emitter<FetchReviewsState> emit,
  ) async {
    emit(FetchReviewsLoadingState());

    try {
      await emit.forEach<List<ReviewModel>>(
        _repository.streamReviewsWithUser(event.shopId), 
        onData: (reviews) {
          if (reviews.isEmpty) {
            return FetchReviewsEmptyState();
          } else {
            return FetchReviewsSuccesState(reviews);
          }
        },
         onError: (_, __) => FetchReviewFailureState('Failed to fetch reviews'),
        );
    } catch (e) {
      log('Unexpecte error occured: $e');
      emit(FetchReviewFailureState('Error ocuured: $e'));
    }
  }
}
