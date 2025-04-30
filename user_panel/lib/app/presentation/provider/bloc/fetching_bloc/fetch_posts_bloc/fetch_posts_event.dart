part of 'fetch_posts_bloc.dart';

abstract class FetchPostsEvent {}

final class FetchPostRequest extends FetchPostsEvent {
  final String barberId;

  FetchPostRequest({required this.barberId});
}