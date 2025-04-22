part of 'fetch_reviews_bloc.dart';

abstract class FetchReviewsEvent {}

final class FetchReviewRequst extends FetchReviewsEvent {
  final String shopId;

  FetchReviewRequst({required this.shopId});
}
