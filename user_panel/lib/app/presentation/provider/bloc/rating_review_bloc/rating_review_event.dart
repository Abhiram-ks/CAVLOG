part of 'rating_review_bloc.dart';

abstract class RatingReviewEvent {}
final class RatingReviewRequest extends RatingReviewEvent {
  final String shopId;
  final double starCount;
  final String description;
  
  RatingReviewRequest({required this.shopId, required this.description, required this.starCount});
}