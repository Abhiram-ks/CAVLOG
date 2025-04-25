part of 'fetch_posts_bloc.dart';

abstract class FetchPostsState {}

final class FetchPostsInitial extends FetchPostsState {}

final class FetchPostsLoadingState extends FetchPostsState {}

final class FetchPostsEmptyState extends FetchPostsState {}

final class FetchPostSuccessState extends FetchPostsState {
  final List<PostModel> posts;

  FetchPostSuccessState({required this.posts});
}

final class FetchPostFailureState extends FetchPostsState {
  final String errorMessage;

  FetchPostFailureState(this.errorMessage);
}
