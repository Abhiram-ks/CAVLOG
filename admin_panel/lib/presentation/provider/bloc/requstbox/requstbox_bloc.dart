import 'dart:developer';

import 'package:admin/data/datasources/requstsResponse/accept_req_remote_data.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'requstbox_event.dart';
part 'requstbox_state.dart';

class RequstboxBloc extends Bloc<RequstboxEvent, RequstboxState> {
  String _fullName = '';
  String _ventureName = '';
  String _uid = ''; 
  String _email = '';
  String _reason = '';

  String get fullNme => _fullName;
  String get ventureName => _ventureName;
  String get uid => _uid;
  String get email => _email;
  String get reason => _reason;

  RequstboxBloc() : super(RequstboxInitial()) {
    on<AcceptAction>((event, emit) {
      _fullName = event.barberName;
      _ventureName = event.ventureName;
      _uid = event.uid;
      _email = event.email;
      emit(AcceptAllertbox());
    });

    on<AcceptActionAllow>((event, emit)async {
      try {
        log('Registration Accept: $_email<$_fullName');
        emit(RequstboxLoading());
        final result = await AcceptReqRemoteData(FirebaseFirestore.instance).updateBarberVerificationStatus(_uid,_fullName,_ventureName,_email).first;

        if (result) {
          emit(AcceptAlertsuccess());
        } else {
          emit(RequstboxError(error: 'Verification failed. Please try again.'));
        }
      } catch (e) {
         emit(RequstboxError(error: "Requst Failure $e"));
      }
    });

    on<AcceptActionACancel>((event, emit) {
      emit(AcceptAlertDismiss());
    });
  }
}
