part of 'fetch_reviews_bloc.dart';

abstract class FetchReviewsEvent {}

final class FetchReviewRequest extends FetchReviewsEvent {
  final String shopId;

  FetchReviewRequest({required this.shopId});
}
