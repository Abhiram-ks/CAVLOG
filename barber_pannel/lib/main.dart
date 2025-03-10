import 'package:barber_pannel/core/routes/routes.dart';
import 'package:barber_pannel/core/themes/theme.dart';
import 'package:barber_pannel/firebase_options.dart';
import 'package:barber_pannel/presentation/provider/bloc/splash/splash_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/provider/cubit/icon/icon_cubit.dart';

void main() async{
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
        BlocProvider(create: (context) => SplashBloc()..add(StartSplashEvent()),),
        BlocProvider(
          create: (context) => IconCubit(),
        )
      ],
      child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          ),
    );
  }
}
