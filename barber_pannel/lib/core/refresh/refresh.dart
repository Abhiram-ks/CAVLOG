import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/fetchbarber/fetch_barber_bloc.dart';
import 'package:barber_pannel/cavlog/auth/data/models/barber_model.dart';
import 'package:barber_pannel/services/barber_manger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefreshHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  

  /// LogOut the user and clear session and call all firestore to refresh the data 
  /// 
  /// [context] the build context fo the widget
  Future<bool> logOut() async{
    try {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await _auth.signOut();
    await _googleSignIn.signOut();
    await preferences.setBool('isLoggedIn', false);
    await preferences.remove('barberUid');
    BarberManger().clearUser();
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

  Future<bool> refreshDatas(BuildContext context, BarberModel barber) async {
    try {
      //! Add new data in shared preference!
    final fetchBarberBloc = context.read<FetchBarberBloc>();
    final SharedPreferences prefsBarber = await SharedPreferences.getInstance();
    await prefsBarber.setBool('isLoggedIn', true);
    await prefsBarber.setString('barberUid', barber.uid);
    //? after the id store the data in the shared preference then call the fetch bloc
    fetchBarberBloc.add(FetchCurrentBarber());
    BarberManger().setUser(barber);
    await FirebaseFirestore.instance.clearPersistence();
    return true;
    } catch (e) {
      return false;
    }
  }
}
