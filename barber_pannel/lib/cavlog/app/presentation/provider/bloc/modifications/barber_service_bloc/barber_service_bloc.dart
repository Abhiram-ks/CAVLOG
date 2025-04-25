import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/datasources/firestore_barber_service.dart';
part 'barber_service_event.dart';
part 'barber_service_state.dart';

class BarberServiceBloc extends Bloc<BarberServiceEvent, BarberServiceState> {
  String _serviceName = '';
  double _amount = 0.0;

  String get serviceName => _serviceName;
  double get amount => _amount;
  final FirestoreBarberService _firestoreService = FirestoreBarberService();
  BarberServiceBloc() : super(BarberServiceInitial()) {
    on<AddSingleBarberServiceEvent>((event, emit) {
     _serviceName = event.serviceName;
     _amount = event.amount;
     emit(ConfirmationAlertState(event.serviceName, event.amount));
    });

    on<ConfirmationBarberServiceEvent>(_onUploadBarberService);
  }

  Future<void> _onUploadBarberService(
    ConfirmationBarberServiceEvent event, Emitter<BarberServiceState> emit) async {
    emit(BarberServiceLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? barberId = prefs.getString('barberUid');
      if (barberId == null || barberId.isEmpty) {
        return;
      }
      
      final success = await _firestoreService.uploadNewBarberService(barberID: barberId, services: _serviceName,serviceRate: _amount);

      if (success == null) {
         emit(BarberServiceSuccess());
      }else {
        emit(BarberServiceFailure('Error occurred: $success'));
      }
    } catch (e) {
      emit(BarberServiceFailure('Unexpected error occurred. $e'));
    }
    }
}
