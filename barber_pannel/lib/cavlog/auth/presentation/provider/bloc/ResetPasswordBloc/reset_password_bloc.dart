import 'dart:developer';

import 'package:barber_pannel/cavlog/auth/data/repositories/reset_password_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordRepository _repository;
  ResetPasswordBloc(this._repository) : super(ResetPasswordInitial()) {
     on<ResetPasswordRequested>(_onResetPasswordRequested);
    }

    Future<void> _onResetPasswordRequested(ResetPasswordRequested event, Emitter<ResetPasswordState> emit) async{
      emit(ResetPasswordLoading());

      try {
        log('Email Reset Password Email ID: ${event.email}');
        bool emailExists = await _repository.isEmailExists(event.email);
        if (emailExists) {
          await _repository.sendPasswordResetEmail(email: event.email);
          emit(ResetPasswordSuccess());
        }else{
          emit(ResetPasswordFailure('Email not found, Please enter a valid email.'));
        }
      } catch (e) {     
        log('Error in Reset Password: ${e.toString()}');
        if(e is FirebaseAuthException){
          emit(ResetPasswordFailure("Databse Error: ${e.message}"));
        }else{

          emit(ResetPasswordFailure("Failed to reset Password: ${e.toString()}"));
        }
      }
    }
  }

