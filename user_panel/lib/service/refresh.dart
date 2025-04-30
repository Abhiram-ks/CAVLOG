
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_panel/auth/data/datasources/auth_local_datasource.dart';
import 'package:user_panel/auth/data/models/user_model.dart';
import '../app/presentation/provider/bloc/fetching_bloc/fetch_user_bloc/fetch_user_bloc.dart' show FetchCurrentUserRequst, FetchUserBloc;
import 'user_management.dart';

class RefreshHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// LogOut the user and clear session and call all firestore to refresh the data 
  /// 
  /// [context] the build context fo the widget
  Future<bool> logOut() async {
    try {
     await SecureStorageService.clearUserCredentials();
     await _auth.signOut();
     await _googleSignIn.signOut();
     UserManagement().clearUser();
     return true; 
    } catch (e) {
      return false;
    }
  }


  /// Login the user and clear session and call all firestore to refresh the data
  /// ![context] the buid contex of the widget
///? [bloc] The bloc that needs to be refreshed because the data is still cached in the state.
/*The data is not refreshed when another user logs in because Firestore caches it.
The existing data is still shown due to Firestore's cache.
To prevent this, the data must be refreshed when the user logs out and logs in again.*/
  Future<bool> refreshUser(BuildContext context, UserModel user) async {
    try {
      //!Add new data in the session
       final fetchUserBloc = context.read<FetchUserBloc>();
      await SecureStorageService.saveUserCredentials(user.uid);
      UserManagement().setUser(user);
      fetchUserBloc.add(FetchCurrentUserRequst());
      return true;
    } catch (e) {
      return false;
    }
  }
}