import 'package:admin/core/themes/themes_manager.dart';
import 'package:admin/data/repositories/auth_repository.dart';
import 'package:admin/data/repositories/barbers_repository.dart';
import 'package:admin/domain/useCase/login_usecase.dart';
import 'package:admin/firebase_options.dart';
import 'package:admin/presentation/provider/bloc/fetchbarbers/fetch_barbers_bloc.dart';
import 'package:admin/presentation/provider/bloc/loging/login_bloc.dart';
import 'package:admin/presentation/provider/bloc/logout/logout_bloc.dart';
import 'package:admin/presentation/provider/bloc/requstbox/requstbox_bloc.dart';
import 'package:admin/presentation/provider/bloc/splash/splash_bloc.dart';
import 'package:admin/presentation/provider/bloc/toggleview/toggleview_bloc.dart';
import 'package:admin/presentation/provider/cubit/Icon/icon_cubit.dart';
import 'package:admin/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          BlocProvider(create: (context) => SplashBloc()..add(StartSplashEvent())),
          BlocProvider(create: (context) => IconCubit()),
          BlocProvider(create: (context) => ButtonProgressCubit()),
          BlocProvider(create: (context) => LogoutBloc()),
          BlocProvider(create: (context) => ToggleviewBloc()),
          BlocProvider(create: (context) => LoginBloc(LoginUsecase(authRepository: AuthnticationProcess()))),
          BlocProvider(create: (context) => FetchBarbersBloc(BarbersRepository(FirebaseFirestore.instance))..add(FetchBarbersDataEvent())),
          BlocProvider(create: (context) => RequstboxBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
    );
  }
}
