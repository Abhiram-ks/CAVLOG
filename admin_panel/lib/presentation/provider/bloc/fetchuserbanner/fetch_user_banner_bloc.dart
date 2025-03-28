import 'package:admin/data/models/banner_models.dart';
import 'package:bloc/bloc.dart';
import '../../../../data/repositories/banner_repositoty.dart';
part 'fetch_user_banner_event.dart';
part 'fetch_user_banner_state.dart';

class FetchUserBannerBloc extends Bloc<FetchUserBannerEvent, FetchUserBannerState> {
  final BannerRepositoty repositoty;

  FetchUserBannerBloc(this.repositoty) : super(FetchUserBannerInitial()) {
    on<FetchUserBannerAction>((event, emit) async {
      try {
        emit(FetchUserBannerLoading());
        await emit.forEach(
          repositoty.getUserBannerStream(),
          onData: (userBanner) => UserBannerLoadedState(userBanner),
          onError: (error, stackTrace) {
            return FetchingBannerUserErrorState('Failed to fetch user banner: $error');
          },
        );
      } catch (e) {
        emit(FetchingBannerUserErrorState('Failed to fetch user banners: $e'));
      }
    });
  }
}
