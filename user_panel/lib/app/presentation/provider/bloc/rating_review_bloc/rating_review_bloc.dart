import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:user_panel/app/data/repositories/review_upload_repository.dart';
import 'package:user_panel/app/domain/entitiles/review_entity.dart';

import '../../../../../auth/data/datasources/auth_local_datasource.dart';

part 'rating_review_event.dart';
part 'rating_review_state.dart';

class RatingReviewBloc extends Bloc<RatingReviewEvent, RatingReviewState> {
  final ReviewRepository _reviewRepository;
  RatingReviewBloc(this._reviewRepository) : super(RatingReviewInitial()) {

    on<RatingReviewRequest>((event, emit) async{
      emit(RatingReviewLoading());
      try {
          final credentials = await SecureStorageService.getUserCredentials();
          final String? userId = credentials['userId'];
          log('Fetching user id from secure storage: $userId');

          if (userId != null) {
            final review = ReviewEntity(
            userId: userId, 
            starCount: event.starCount, 
            description: event.description, 
            createdAt: DateTime.now());

            final isSuccess = await _reviewRepository.addReview(event.shopId, review);

            if (isSuccess) {
              emit(RatingReviewSuccess());
            } else {
              emit(RatingReviewFailure('Error: Failed to upload review.'));
            }
          }
      } catch (e) {
        emit(RatingReviewFailure('Error: ${e.toString()}'));
      }

    });
  }
}
