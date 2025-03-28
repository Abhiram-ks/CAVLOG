import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
      on<StartSplashEvent>(_onStartSplash);
  }
   Future<void> _onStartSplash(StartSplashEvent event, Emitter<SplashState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isAdminLog = prefs.getBool('isAdminLog') ?? false;
    const duration =  Duration(seconds: 3);
    final stopwatch = Stopwatch()..start();

    while (stopwatch.elapsed < duration) {
    for (double progress = 0.0; progress <= 1.0; progress += 0.03) {
        emit(SplashAnimating(progress));
        await Future.delayed(const Duration(milliseconds: 30));
      }
   }

   if (isAdminLog) {
     emit(AdminGoToHome());
   } else {
     emit (SplashAnimationCompleted());
   }
  }
}

