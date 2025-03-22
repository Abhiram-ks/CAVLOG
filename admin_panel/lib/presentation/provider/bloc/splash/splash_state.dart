part of 'splash_bloc.dart';

@immutable
abstract class SplashState{}

class SplashInitial extends SplashState{}

class  SplashAnimating  extends SplashState {
  final double animationValue;
  SplashAnimating  (this.animationValue);
}

class SplashAnimationCompleted extends SplashState {}
class AdminGoToHome extends SplashState {}