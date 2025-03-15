part of 'timer_cubit_cubit.dart';

sealed class TimerCubitState extends Equatable {
  const TimerCubitState();

  @override
  List<Object> get props => [];
}

final class TimerCubitInitial extends TimerCubitState {}

final class TimerCubitRunning  extends TimerCubitState {
  final String formattedTime;
  final int secondsRemaining;
  const TimerCubitRunning(this.secondsRemaining, this.formattedTime);

 @override
  List<Object> get props => [formattedTime,  secondsRemaining];
}

final class TimerCubitCompleted extends TimerCubitState {}
