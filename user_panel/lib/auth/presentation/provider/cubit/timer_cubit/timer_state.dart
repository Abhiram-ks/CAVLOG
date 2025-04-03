part of 'timer_cubit.dart';

sealed class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

final class TimerInitial extends TimerState {}

final class TimerCubitRunning  extends TimerState {
  final String formattedTime;
  final int secondsRemaining;
  const TimerCubitRunning(this.secondsRemaining, this.formattedTime);

 @override
  List<Object> get props => [formattedTime,  secondsRemaining];
}


final class TimerCubitCompleted extends TimerState {}
