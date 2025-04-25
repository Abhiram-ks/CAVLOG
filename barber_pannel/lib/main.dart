import 'package:barber_pannel/cavlog/app/data/repositories/fetch_barber_post_repo.dart';
import 'package:barber_pannel/cavlog/app/data/repositories/fetch_barberdata_repo.dart';
import 'package:barber_pannel/cavlog/app/data/repositories/fetch_servicedata_repo.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/fetchings/fetch_posts_bloc/fetch_posts_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/fetchings/fetch_service_bloc/fetch_service_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/fetchings/fetchbarber/fetch_barber_bloc.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import 'package:barber_pannel/core/cloudinary/cloudinary_config.dart';
import 'package:barber_pannel/core/routes/routes.dart';
import 'package:barber_pannel/core/themes/theme_manager.dart';
import 'package:barber_pannel/firebase_options.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/RegisterSubmition/register_submition_bloc.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/splash/splash_bloc.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/timerCubit/timer_cubit_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'cavlog/auth/presentation/provider/cubit/Checkbox/checkbox_cubit.dart';
import 'cavlog/auth/presentation/provider/cubit/icon_cubit/icon_cubit.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  CloudinaryConfig.initialize();
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
        BlocProvider(create: (context) => SplashBloc(FirebaseFirestore.instance)..add(StartSplashEvent())),
        BlocProvider(create: (context) => RegisterSubmitionBloc()),
        BlocProvider(create: (context) => FetchBarberBloc(FetchBarberRepositoryImpl())),
        BlocProvider(create: (context) => IconCubit()),
        BlocProvider(create: (context) => ButtonProgressCubit()),
        BlocProvider(create: (context) => TimerCubitCubit()),
        BlocProvider(create: (context) => CheckboxCubit()),
        BlocProvider(create: (context) => FetchServiceBloc(ServiceRepositoryImpl())..add(FetchServiceRequst())),
      ],
      child: MaterialApp(
          title: 'Cavlog-Business',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          ), 
    );
  }
}


