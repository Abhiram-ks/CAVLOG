part of 'splash_bloc.dart';

abstract class SplashState {}

final class SplashInitial extends SplashState {}
class  SplashAnimating  extends SplashState {
  final double animationValue;
  SplashAnimating  (this.animationValue);
}

class SplashAnimationCompleted extends SplashState {}
class GoToHomePage extends SplashState {
  // final BarberModel barberModel;
  // GoToHomePage(this.barberModel);
}

class GoToLoginPage extends SplashState{}