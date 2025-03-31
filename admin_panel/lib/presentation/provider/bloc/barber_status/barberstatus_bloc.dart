import 'package:admin/data/datasources/blockandunblock/block_unblock_remote_data.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'barberstatus_event.dart';
part 'barberstatus_state.dart';

class BarberstatusBloc extends Bloc<BarberstatusEvent, BarberstatusState> {
  String _uid = '';
  String get uid => _uid;

  BarberstatusBloc() : super(BarberstatusInitial()) {
    on<ShowBlockAlert>((event, emit) {
      _uid = event.uid;
      emit(ShowBlockAlertState());
    });

    on<ConfirmBlock>((event, emit) async{
      try {
        final response = await StatusBarberRemoteData(FirebaseFirestore.instance).updateBarberStatusBlockORUnblock(_uid, true).first;

        if (response) {
          emit(BlockSuccessState());
        }else {
          emit(StatusErrorState('Error: Block operation failed due to unknown issues.'));
        }
      } catch (e) {
        emit(StatusErrorState('Error: Block operation failed due to $e'));
      }
    });

     on<ShowUnblockAlert>((event, emit) {
      _uid = event.uid;
      emit(ShowUnblockAlertState());
    });

    on<ConfirmUnblock>((event, emit) async {
      try {
        final response = await StatusBarberRemoteData(FirebaseFirestore.instance).updateBarberStatusBlockORUnblock(_uid, false).first;

       if (response) {
        emit(UnBlockSuccessState());
       } else {
         emit(StatusErrorState('Error: UnBlock operation failed due to unknown issues.'));
       }
      } catch (e) {
        emit(StatusErrorState('Error: UnBlock operation failed due to $e'));
      }
    });
  }
}
