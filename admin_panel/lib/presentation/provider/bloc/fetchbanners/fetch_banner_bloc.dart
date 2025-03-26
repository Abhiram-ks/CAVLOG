import 'package:admin/data/models/banner_models.dart';
import 'package:admin/data/repositories/banner_repositoty.dart';
import 'package:bloc/bloc.dart';

part 'fetch_banner_event.dart';
part 'fetch_banner_state.dart';

class FetchBannerBloc extends Bloc<FetchBannerEvent, FetchBannerState> {
  final BannerRepositoty repositoty;
  FetchBannerBloc(this.repositoty) : super(FetchBannerInitial()) {
    on<FetchBannerEvent>((event, emit) {
     
    });
  }
}
