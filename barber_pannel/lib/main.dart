import 'package:barber_pannel/cavlog/app/data/repositories/fetch_barber_service_repo.dart';
import 'package:barber_pannel/cavlog/app/data/repositories/fetch_barberdata_repo.dart';
import 'package:barber_pannel/cavlog/app/data/repositories/fetch_servicedata_repo.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/barber_service_bloc/barber_service_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/fetch_service_bloc/fetch_service_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/fetchbarber/fetch_barber_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/logout/logout_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/buttomnav/buttom_nav_cubit.dart';
import 'package:barber_pannel/core/cloudinary/cloudinary_config.dart';
import 'package:barber_pannel/core/routes/routes.dart';
import 'package:barber_pannel/core/themes/theme_manager.dart';
import 'package:barber_pannel/cavlog/auth/data/repositories/auth_repository_impl.dart';
import 'package:barber_pannel/cavlog/auth/data/repositories/reset_password_repo.dart';
import 'package:barber_pannel/firebase_options.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/Login_bloc/login_bloc.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/RegisterSubmition/register_submition_bloc.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/ResetPasswordBloc/reset_password_bloc.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/bloc/splash/splash_bloc.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/Checkbox/checkbox_cubit.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import 'package:barber_pannel/cavlog/auth/presentation/provider/cubit/timerCubit/timer_cubit_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'cavlog/app/presentation/provider/bloc/fetch_barber_service_bloc/fetch_barber_service_bloc.dart';
import 'cavlog/app/presentation/provider/cubit/profiletab/profiletab_cubit.dart';
import 'cavlog/auth/presentation/provider/cubit/icon/icon_cubit.dart';

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
        //Bloc section
        BlocProvider(create: (context) => SplashBloc(FirebaseFirestore.instance)..add(StartSplashEvent())),
        BlocProvider(create: (context) => ResetPasswordBloc(ResetPasswordRepository())),
        BlocProvider(create: (context) => RegisterSubmitionBloc()),
        BlocProvider(create: (context) => LoginBloc(AuthRepositoryImpl())),
        //Appcore Bloc
        BlocProvider(create: (context) => FetchBarberBloc(FetchBarberRepositoryImpl())..add(FetchCurrentBarber())),
        //Cubit section
        BlocProvider(create: (context) => IconCubit()),
        BlocProvider(create: (context) => CheckboxCubit()),
        BlocProvider(create: (context) => ButtonProgressCubit()),
        BlocProvider(create: (context) => TimerCubitCubit()),
        //Appcore Bloc
        BlocProvider(create: (context) => ButtomNavCubit()),
        BlocProvider(create: (context) => FetchBarberServiceBloc(repository: FetchBarberServiceRepositoryImpl())),
        BlocProvider(create: (context) => ProfiletabCubit()),
        BlocProvider(create: (context) => LogoutBloc(context.read<ButtomNavCubit>())),
        BlocProvider(create: (context) => FetchServiceBloc(ServiceRepositoryImpl())..add(FetchServiceRequst())),
        BlocProvider(create: (context) => BarberServiceBloc()),
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


