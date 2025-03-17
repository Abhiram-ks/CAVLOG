import 'dart:developer';

import 'package:barber_pannel/data/models/barber_model.dart';
import 'package:barber_pannel/data/repositories/auth_repository_impl.dart';
import 'package:barber_pannel/services/barber_manger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginInitial()) {
    on<LoginActionEvent>((event, emit) async {
     emit(LoginLoading());
     try {
      final authRepository = AuthRepositoryImpl();
      log('Email: ${event.email} Password: ${event.password}');
      BarberModel? barber = await authRepository.login(event.email, event.password);
      log(barber.toString());

      if(barber != null){
        BarberManger().setUser(barber);
        log('Barber is ${barber.toMap()}');
        if(barber.isVerified){
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          emit(LoginVarified());
        }else{
          emit(LoginNotVerified());
        }
      }else{
        log('1');
        emit( LoginFiled(error: 'Authentication Failed'));
      }
     } on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        log('2');
        emit(LoginFiled(error: 'Incorrect Email or Password. Please try again'));
      } else if (e.code == 'too-many-requests'){
        log('3');
        emit(LoginFiled(error:'Too many requests. Please try again later'));
      }else if (e.code == 'network-request-failed'){
        log('4');
        emit(LoginFiled(error: 'Network Error. Please check your internet connection'));
      }else{
        log('5');
        emit(LoginFiled(error: 'An Error Occred: ${e.message} please try again'));
      }
     }  catch (e) {
      log('6');
        emit(LoginFiled(error: 'An Error Occured: ${e.toString()}'));
     }
    });
  }
}
