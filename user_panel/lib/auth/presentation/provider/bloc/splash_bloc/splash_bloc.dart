import 'dart:isolate';

import 'package:bloc/bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplashEvent>(_onStartSplash);
  }

  Future<void> _onStartSplash(StartSplashEvent event, Emitter<SplashState> emit) async {
    try {  
       final ReceivePort receivePort = ReceivePort();
       await Isolate.spawn(_runAnimation, receivePort.sendPort);
       await for(final double progress in receivePort) {
        if (progress >= 1.0) {
          receivePort.close();
          emit(GoToLoginPage());
          break;
        } else {  
          emit(SplashAnimating(progress));
        }
       }
    } catch (e) { 
       emit(GoToLoginPage());
    } finally {
       emit (GoToLoginPage());
    }
  }
}


void _runAnimation(SendPort sendPort) async{
  const Duration duration = Duration(milliseconds: 3000);
  final Stopwatch stopwatch = Stopwatch()..start();

  while (stopwatch.elapsed < duration) {
     for (double progress = 0.0; progress <= 1.0; progress += 0.03) {
      sendPort.send(progress);
      await Future.delayed(const Duration(milliseconds: 30));
    }
  }
   sendPort.send(1.0);
}