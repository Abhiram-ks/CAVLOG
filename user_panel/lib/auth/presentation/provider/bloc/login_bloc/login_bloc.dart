import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_panel/auth/data/repositories/authlogin_impl_repo.dart';
import 'package:user_panel/service/refresh.dart';
import '../../../../../core/error/firebase_exceptions.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositoryLogin _authRepository;
  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<LoginActionEvent>((event, emit)async {
     emit(LoginLoading());
     try {
      await for (final user in _authRepository.login(event.email, event.password)){
        if(user != null){
          log('message: done done done done ');
          bool response = await  RefreshHelper().refreshUser(event.context, user);
          if(response){
            emit(LoginSuccess());
          }else {
            emit(LoginFiled(error: 'Authentication Failed'));
          }
        }
      }
     }  on FirebaseAuthException catch (e) {
        List<String> errorMessage =FirebaseErrorHandler.handleFirebaseAuthError(e);
        emit(LoginFiled(error: errorMessage.join(', ')));
     } catch (e){
      emit(LoginFiled(error: 'An Error occured: ${e.toString()}'));
     }
    });
  }
}
