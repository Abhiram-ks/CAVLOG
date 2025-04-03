import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial());

  
  Timer? _timer;
  static const int _initialTime = 119;

  void startTimer(){
   emit(TimerCubitRunning(_initialTime, _formatTime(_initialTime)));

    _timer?.cancel();
    int timeLeft = _initialTime;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      if (timeLeft > 0) {
         timeLeft--;
         emit(TimerCubitRunning(timeLeft, _formatTime(timeLeft)));
      } else {
        timer.cancel();
        emit(TimerCubitCompleted());
      }
    });
  }

    void resetTimer(){
    _timer?.cancel();
    emit(TimerInitial());
  }

  static String _formatTime(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    return "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
     "${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
  }

   @override
     Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
