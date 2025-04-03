import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_panel/auth/domain/usecases/get_location_usecase.dart';
import 'package:user_panel/auth/presentation/provider/bloc/location_bloc/location_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/register_bloc/register_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/searchlocation_bloc/serchlocaton_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/splash_bloc/splash_bloc.dart';
import 'package:user_panel/auth/presentation/provider/cubit/button_progress_cubit/button_progress_cubit.dart';
import 'package:user_panel/auth/presentation/provider/cubit/checkbox_cubit/checkbox_cubit.dart';
import 'package:user_panel/auth/presentation/provider/cubit/icon_cubit/icon_cubit.dart';
import 'package:user_panel/auth/presentation/provider/cubit/timer_cubit/timer_cubit.dart';
import 'package:user_panel/core/routes/routes.dart';
import 'package:user_panel/core/themes/theme_manager.dart';
import 'package:user_panel/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //Auth Bloc
        BlocProvider(create: (context) => SplashBloc()..add(StartSplashEvent())),
        BlocProvider(create: (context) => LocationBloc(GetLocationUseCase())),
        BlocProvider(create: (context) => SerchlocatonBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        //Auth cubit
        BlocProvider(create: (context) => IconCubit()),
        BlocProvider(create: (context) => ButtonProgressCubit()),
        BlocProvider(create: (context) => CheckboxCubit()),
        BlocProvider(create: (context) => TimerCubit()),
      ],
    child: MaterialApp(
     title: 'Cavlog',
     debugShowCheckedModeBanner: false,
     theme: AppTheme.lightTheme,
     initialRoute: AppRoutes.splash,
     onGenerateRoute: AppRoutes.generateRoute,
     )
    );
  }
}


