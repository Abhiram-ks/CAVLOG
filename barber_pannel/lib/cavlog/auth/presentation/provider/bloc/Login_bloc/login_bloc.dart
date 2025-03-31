import 'dart:developer';
import 'package:barber_pannel/cavlog/auth/data/models/barber_model.dart';
import 'package:barber_pannel/cavlog/auth/data/repositories/auth_repository_impl.dart';
import 'package:barber_pannel/services/barber_manger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../app/presentation/provider/bloc/fetchbarber/fetch_barber_bloc.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<LoginActionEvent>((event, emit) async {
     emit(LoginLoading());
     try {
      await emit.forEach<BarberModel?>(
        _authRepository.login(event.email, event.password), 
        onData: (barber) {
          if (barber != null) {
            BarberManger().setUser(barber);
              if (barber.isblok) {
                return LoginBlocked();
              }else if(barber.isVerified) {
                _handleVerifiedBarber(barber, event.context);
                return LoginVarified();
              }else {
                 return LoginNotVerified();
              }
          }else {
             return LoginFiled(error: 'Authentication Failed');
          }
        });
     }  on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          log('FirebaseAuthException: Incorrect Email or Password');
          emit(LoginFiled(error: 'Incorrect Email or Password. Please try again'));
        } else if (e.code == 'too-many-requests') {
          log('FirebaseAuthException: Too Many Requests');
          emit(LoginFiled(error: 'Too many requests. Please try again later'));
        } else if (e.code == 'network-request-failed') {
          log('FirebaseAuthException: Network Error');
          emit(LoginFiled(error: 'Network Error. Please check your internet connection'));
        } else {
          log('FirebaseAuthException: ${e.message}');
          emit(LoginFiled(error: 'An Error Occurred: ${e.message}'));
        }
     }catch (e) {
      log('6');
        emit(LoginFiled(error: 'An Error Occured: ${e.toString()}'));
     }
    });
  }

  Future<void> _handleVerifiedBarber(BarberModel barber, BuildContext context) async{
    try {
      final SharedPreferences prefsBarber = await SharedPreferences.getInstance();
      await prefsBarber.setBool('isLoggedIn', true);
      log('Barber login BarberId: ${barber.uid}');
      await prefsBarber.setString('barberUid', barber.uid);
      if (!context.mounted) return;
      context.read<FetchBarberBloc>().add(FetchCurrentBarber());
      log("Barber varified and saved to sharedPreference!>");
    } catch (e) {
      log('Error saving barber data: ${e.toString()}');
    }
  }
}
