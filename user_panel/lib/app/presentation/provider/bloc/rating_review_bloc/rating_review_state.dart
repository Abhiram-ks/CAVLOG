part of 'rating_review_bloc.dart';

abstract class RatingReviewState {}

final class RatingReviewInitial extends RatingReviewState {}

final class RatingReviewLoading extends RatingReviewState {}
final class RatingReviewSuccess extends RatingReviewState {}
final class RatingReviewFailure extends RatingReviewState {
  final String errorMessage;

  RatingReviewFailure(this.errorMessage);
}