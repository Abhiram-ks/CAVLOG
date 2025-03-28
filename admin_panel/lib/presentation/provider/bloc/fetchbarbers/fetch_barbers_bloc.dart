import 'package:admin/data/models/barber_models.dart';
import 'package:bloc/bloc.dart';
import '../../../../data/repositories/barbers_repository.dart';
part 'fetch_barbers_event.dart';
part 'fetch_barbers_state.dart';

class FetchBarbersBloc extends Bloc<FetchBarbersEvent, FetchBarbersState> {
  final BarbersRepository  repository;
  FetchBarbersBloc(this.repository) : super(FetchBarbersInitial()){
  on<FetchBarbersDataEvent>((event, emit) async{
    emit(FetchBarbersInitial());
    await emit.forEach(
      repository.getBarbersStream(),
      onData: (barbers) {
        if (barbers.isEmpty) {
          return BarberEmptyState();
        }
        return BarberLoadedState(barbers);
      },
       onError: (error, stackTrace) {
         return BarberErrorState('Fetching Datas Error: $error');
       },
      );
  });
}
}