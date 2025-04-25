part of 'fetch_reviews_bloc.dart';

abstract class FetchReviewsState  {}

final class FetchReviewsInitial extends FetchReviewsState {}

final class FetchReviewsLoadingState extends FetchReviewsState {}
final class FetchReviewsEmptyState extends FetchReviewsState {}
final class FetchReviewsSuccesState extends FetchReviewsState {
  final List<ReviewModel> reviews;

  FetchReviewsSuccesState(this.reviews);
}
final class FetchReviewFailureState extends FetchReviewsState {
  final String error;

  FetchReviewFailureState(this.error);
}