part of 'fetch_banner_bloc.dart';

abstract class FetchBannerState{}

final class FetchBannerInitial extends FetchBannerState {}
final class FetchBannerLoading extends FetchBannerState {}
final class UserBannerLoadedState extends FetchBannerState {
  final BannerModels userBanner;
  UserBannerLoadedState(this.userBanner);
}

final class BarberBannerLoadedState  extends FetchBannerState{
  final BannerModels barberBanner;
  BarberBannerLoadedState(this.barberBanner);
}

class FetchingBannerErrorState  extends FetchBannerState{
  final String error;
  FetchingBannerErrorState(this.error);
}

