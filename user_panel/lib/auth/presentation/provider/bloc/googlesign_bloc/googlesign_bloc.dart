import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_panel/auth/data/datasources/auth_remote_datasource.dart';
import 'package:user_panel/core/error/firebase_exceptions.dart';
import 'package:user_panel/service/refresh.dart';
part 'googlesign_event.dart';
part 'googlesign_state.dart';

class GooglesignBloc extends Bloc<GooglesignEvent, GooglesignState> {
  GooglesignBloc() : super(GooglesignInitial()) {
    on<GoogleSignInRequested>((event, emit) async{
      emit(GoogleSignLoading());
      try {
        log('working progress');
        AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
        final user = await authRemoteDataSource.signInWithGoogle();
        if(user != null){
          if (event.context.mounted) {
           bool response = await RefreshHelper().refreshUser(event.context,user);
           if(response){
            emit(GoogleSignSuccess(user.uid));
           }else {
            emit(GoogleSignfailure('Authentication Failed'));
          }
          }
        }else {
          emit(GoogleSignfailure('Authentication Failed due to cancel!'));
        }
      } on FirebaseAuthException catch(e){
         List<String> errorMessage = FirebaseErrorHandler.handleFirebaseAuthError(e);
         emit(GoogleSignfailure('error: ${errorMessage.join(',')}'));
         log('message: google error ${errorMessage.join(',')}');
      }
      catch (e) {
        log('message: google error catch ${e.toString()}');
        emit(GoogleSignfailure('An Error Occured: ${e.toString()}'));
      }
    });
  }
}
