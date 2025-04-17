import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../../data/repositories/fetch_barber_service_repo.dart';
part 'barber_service_modeification_event.dart';
part 'barber_service_modeification_state.dart';

class BarberServiceModeificationBloc extends Bloc<BarberServiceModeificationEvent, BarberServiceModeificationState> {
  final FetchBarberServiceRepository repository;

  String _barberUid = '';
  String _serviceKey = '';
  double _serviceValue = 0;

  String get barberUid => _barberUid;
  String get serviceKey => _serviceKey;
  double get serviceValue => _serviceValue;
  BarberServiceModeificationBloc(this.repository) : super(BarberServiceModeificationInitial()) {
    //--------------------------------------------------------\\
    //! Delete Barber service event

    on<FetchBarberServicDeleteRequestEvent>((event, emit) {
      _barberUid = event.barberUid;
      _serviceKey = event.serviceKey;
      emit(FetchBarberServiceDeleteConfirm(event.serviceKey));
    });

    on<FetchBarberServiceDeleteConfirmEvent>((event, emit) async {
      emit(FetchBarberServiceDeleteLoading());
      try {
        final response = await repository.deleteBarberService(barberUid: barberUid, serviceKey: serviceKey);

        if (response) {
          emit(FetchBarberServiceDeleteSuccess());
        }else {
          emit(FetchBarberServiceDeleteErrorState('Unable to delete service!.'));
        }
      } catch (e) {
        emit(FetchBarberServiceDeleteErrorState('Unable to delete service!.'));
      }
    });


     //--------------------------------------------------------\\
    //! Update Barber service event
    on<FetchBarberServiceUpdateRequestEvent>((event, emit) {
      log('message: this is the barber id;');
      _barberUid = event.barberUid;
      _serviceKey = event.serviceKey;
      _serviceValue = event.serviceValue;
      emit(FetchBarberServiceUpdateConfirm(event.oldServiceValue, event.serviceValue));
    });

    on<FetchBarberServiceUpdateConfirmEvent>((event, emit) async{
      emit(FetchBarberServiceUpdateLoading());
      try {
        final response = await repository.updateBarberService(barberUid: barberUid, serviceKey: serviceKey, serviceValue: serviceValue);
        if (response) {
          emit(FetchBarberServiceUpdateSuccess());
        } else {
          emit(FetchBarberServiceUpdateErrorState('Unable to update service!.'));
        }
      } catch (e) {
        emit(FetchBarberServiceUpdateErrorState('Error: occured while updating service! due to $e'));
      }
    });
     
  }
}
