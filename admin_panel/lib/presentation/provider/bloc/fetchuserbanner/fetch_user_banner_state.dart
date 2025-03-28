part of 'fetch_user_banner_bloc.dart';

abstract class FetchUserBannerState {}

final class FetchUserBannerInitial extends FetchUserBannerState{}
final class FetchUserBannerLoading extends FetchUserBannerState {}
final class UserBannerLoadedState extends FetchUserBannerState {
  final BannerModels userBanner;
  UserBannerLoadedState(this.userBanner);
}
class FetchingBannerUserErrorState  extends FetchUserBannerState{
  final String error;
  FetchingBannerUserErrorState(this.error);
}
