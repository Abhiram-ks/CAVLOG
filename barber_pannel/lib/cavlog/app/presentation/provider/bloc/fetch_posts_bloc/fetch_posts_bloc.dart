import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barber_pannel/cavlog/app/data/models/post_model.dart';
import 'package:barber_pannel/cavlog/app/data/repositories/fetch_barber_post_repo.dart';
import 'package:bloc/bloc.dart';
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? barberUid = prefs.getString('barberUid');

    if (barberUid != null) {
      await emit.forEach(
        _repository.fetchBarberPostData(barberUid),
        onData: (posts) {
          if (posts.isEmpty) {
            return FetchPostsEmptyState();
          } else {
            return FetchPostSuccessState(posts: posts);
          }
        },
        onError: (_, __) => FetchPostFailureState("Error: Failed to fetch posts"),
      );
    } else {
      emit(FetchPostFailureState('Error: Barber UID not found'));
    }
  } catch (e) {
    emit(FetchPostFailureState('Error: $e'));
  }
}


  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
