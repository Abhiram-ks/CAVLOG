import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../../../../data/models/post_model.dart';
import '../../../../../data/repositories/fetch_barber_post.dart';
part 'fetch_posts_event.dart';
part 'fetch_posts_state.dart';


class FetchPostsBloc extends Bloc<FetchPostsEvent, FetchPostsState> {
  final FetchBarberPostRepository _repository;
  StreamSubscription<List<PostModel>>? _subscription;

  FetchPostsBloc(this._repository) : super(FetchPostsInitial()) {
    on<FetchPostRequest>(_onFetchPostsRequested);
  }

  Future<void> _onFetchPostsRequested(
  FetchPostRequest event,
  Emitter<FetchPostsState> emit,
) async {
  emit(FetchPostsLoadingState());

  try {
    
      await emit.forEach(
        _repository.fetchBarberPostData(event.barberId),
        onData: (posts) {
          if (posts.isEmpty) {
            return FetchPostsEmptyState();
          } else {
            return FetchPostSuccessState(posts: posts);
          }
        },
        onError: (_, __) => FetchPostFailureState("Error: Failed to fetch posts"),
      );
    
  } catch (e) {
    log('Error due to Post: $e');
    emit(FetchPostFailureState('Error: $e'));
  }
}


  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
