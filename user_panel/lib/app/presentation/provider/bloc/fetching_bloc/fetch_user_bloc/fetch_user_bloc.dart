import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:user_panel/app/data/repositories/fetch_userdata_repo.dart';
import 'package:user_panel/auth/data/datasources/auth_local_datasource.dart';
import 'package:user_panel/auth/data/models/user_model.dart';

part 'fetch_user_event.dart';
part 'fetch_user_state.dart';

class FetchUserBloc extends Bloc<FetchUserEvent, FetchUserState> {
  final FetchUserRepository _repository;
  FetchUserBloc(this._repository) : super(FetchUserInitial()) {
    on<FetchCurrentUserRequst>(_onFetchCurrentUser);
  }

  Future<void> _onFetchCurrentUser(FetchCurrentUserRequst event, Emitter<FetchUserState> emit) async {
    emit(FetchUserLoading());
    try {
      final credentials = await SecureStorageService.getUserCredentials();
      final String? userId = credentials['userId'];
     log('Fetching user id from secure storage: $userId');

      if (userId != null) {
        await emit.forEach<UserModel?>(
          _repository.streamUserData(userId), 
          onData: (user) => user != null 
          ? FetchUserLoaded(user: user)
          : FetchUserError("Error due to: User not found")
        );
      } else {
        emit(FetchUserInitial());
      }
    } catch (e) {
      log('Fetching user error due to : $e');
      emit(FetchUserError('errorMessage: due to $e'));
    }
  }
}
