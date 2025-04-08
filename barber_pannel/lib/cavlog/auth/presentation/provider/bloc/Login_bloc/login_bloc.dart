import 'package:barber_pannel/cavlog/auth/data/repositories/auth_repository_impl.dart';
import 'package:barber_pannel/core/refresh/refresh.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_event.dart';
part 'login_state.dart';
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<LoginActionEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await for (final barber in _authRepository.login(event.email, event.password)) {
          if (barber != null) {
            if (barber.isblok) {
              emit(LoginBlocked());
            } else if (barber.isVerified) {
              bool response = await RefreshHelper().refreshDatas(event.context, barber);
              if (response) {
                emit(LoginVarified());
              } else {
                emit(LoginFiled(error: 'An Error Occurred: Database Error'));
              }
            } else {
              emit(LoginNotVerified());
            }
          } else {
            emit(LoginFiled(error: 'Authentication Failed'));
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          emit(LoginFiled(error: 'Incorrect Email or Password. Please try again'));
        } else if (e.code == 'too-many-requests') {
          emit(LoginFiled(error: 'Too many requests. Please try again later'));
        } else if (e.code == 'network-request-failed') {
          emit(LoginFiled(error: 'Network Error. Please check your internet connection'));
        } else {
          emit(LoginFiled(error: 'An Error Occurred: ${e.message}'));
        }
      } catch (e) {
        emit(LoginFiled(error: 'An Error Occurred: ${e.toString()}'));
      }
    });
  }
}
