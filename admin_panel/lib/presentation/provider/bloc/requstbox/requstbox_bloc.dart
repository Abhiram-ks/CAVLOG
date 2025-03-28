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

  String get fullNme => _fullName;
  String get ventureName => _ventureName;
  String get uid => _uid;
  String get email => _email;

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
        emit(RequstboxLoading());
        final result = await RequstRemoteData(FirebaseFirestore.instance).updateBarberVerificationStatus(_uid,_fullName,_ventureName,_email).first;

        if (result) {
          emit(AcceptAlertsuccess());
        } else {
          emit(RequstboxError(error: 'Verification failed. Please try again.'));
        }
      } catch (e) {
         emit(RequstboxError(error: "Requst Failure $e"));
      }
    });

    on<RejectAction>((event, emit) {
      _fullName = event.barbername;
      _uid = event.uid;
      _ventureName = event.ventureName;
      _email = event.email;
      emit(RejectAllowAlertBox());
    });


    on<RejectActionAllowReason>((event, emit) async{
      try {
        emit(RequstboxLoading());
        final result = await RequstRemoteData(FirebaseFirestore.instance).updateRejectBarberVerificationStatus(_uid,_fullName, _ventureName,_email,event.reason).first;
        
        if (result) {
          emit(RejectAlertBoxSuccess());
        } else {
          emit(RequstboxError(error: 'Rejection failed!.'));
        }
      } catch (e) {
        emit(RequstboxError(error: 'Rejection Failure: $e'));
      }
    });
  }
}
