import 'package:bloc/bloc.dart';
import '../../../../data/models/banner_models.dart';
import '../../../../data/repositories/banner_repositoty.dart';
part 'fetch_banner_barber_event.dart';
part 'fetch_banner_barber_state.dart';

class FetchBannerBarberBloc extends Bloc<FetchBannerBarberEvent, FetchBannerBarberState> {
  final BannerRepositoty repositoty;
  FetchBannerBarberBloc(this.repositoty) : super(FetchBannerBarberInitial()) {
    on<FetchBarberBannerAction>((event, emit)async {
      try {
         emit(FetchBarberBannerLoading());
         await emit.forEach(
          repositoty.getBarberBannerStream(),
          onData: (barberBanner) => BarberBannerLoadedState(barberBanner),
          onError: (error, stackTrace) {
            return FetchingBannerBarberErrorState('Failed to fetch barber banners: $error');
          });
      } catch (e) {
        emit(FetchingBannerBarberErrorState('Failed to fetch barber banners: $e'));
      }
    });
  }
}
