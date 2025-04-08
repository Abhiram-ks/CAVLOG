import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:user_panel/auth/data/repositories/reset_password_repo.dart';
part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordRepo _repository;
  ResetPasswordBloc(this._repository) : super(ResetPasswordInitial()) {
    on<ResetPasswordRequestEvent>((event, emit)  async{
     emit(ResetPasswordLoading());
      try {
        log('message: Email Reset Password: ${event.email}');
        bool isEmailExists = await _repository.isEmailExists(event.email);
        if (isEmailExists) {
          bool isSent = await _repository.sendPasswordResetEmail(event.email);
          if (isSent) {
            emit (ResetPasswordSuccess());
          }else {
            emit(ResetPasswordFailure(errorMessage:  'Failed to send reset email to ${event.email}. Please try again!'));
          }
        }else {
          emit(ResetPasswordFailure(errorMessage: 'Email not found or signed in with Google. Please try again!',));
        }
      } catch (e) {
        emit(ResetPasswordFailure(errorMessage:  'Error occurred while sending reset ${event.email}: $e'));
      }
    });
  }
}
