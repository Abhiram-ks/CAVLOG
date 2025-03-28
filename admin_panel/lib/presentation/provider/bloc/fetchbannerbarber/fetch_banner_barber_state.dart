part of 'fetch_banner_barber_bloc.dart';

abstract class FetchBannerBarberState {}

final class FetchBannerBarberInitial extends FetchBannerBarberState {}
final class FetchBarberBannerLoading extends FetchBannerBarberState {}
final class BarberBannerLoadedState  extends FetchBannerBarberState{
  final BannerModels barberBanner;
  BarberBannerLoadedState(this.barberBanner);
}
final class BarberBannerEmptyState  extends FetchBannerBarberState{}
class FetchingBannerBarberErrorState  extends FetchBannerBarberState{
  final String error;
  FetchingBannerBarberErrorState(this.error);
}