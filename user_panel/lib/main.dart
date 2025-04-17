import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_panel/app/data/repositories/fetch_allbarbers_repo.dart';
import 'package:user_panel/app/data/repositories/fetch_barber_details_repo.dart';
import 'package:user_panel/app/data/repositories/fetch_userdata_repo.dart';
import 'package:user_panel/app/domain/usecases/update_user_profile.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetch_allbarber_bloc/fetch_allbarber_bloc.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetch_barber_details_bloc/fetch_barber_details_bloc.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetchuser_bloc/fetch_user_bloc.dart';
import 'package:user_panel/app/presentation/provider/bloc/logout_bloc/logout_bloc.dart';
import 'package:user_panel/app/presentation/provider/bloc/updateprofile_bloc/update_profile_bloc.dart';
import 'package:user_panel/app/presentation/provider/cubit/buttom_nav_cubit/buttom_nav_cubit.dart';
import 'package:user_panel/auth/data/repositories/authlogin_impl_repo.dart';
import 'package:user_panel/auth/data/repositories/reset_password_repo.dart';
import 'package:user_panel/auth/domain/usecases/get_location_usecase.dart';
import 'package:user_panel/auth/presentation/provider/bloc/googlesign_bloc/googlesign_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/location_bloc/location_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/login_bloc/login_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/register_bloc/register_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/searchlocation_bloc/serchlocaton_bloc.dart';
import 'package:user_panel/auth/presentation/provider/bloc/splash_bloc/splash_bloc.dart';
import 'package:user_panel/auth/presentation/provider/cubit/button_progress_cubit/button_progress_cubit.dart';
import 'package:user_panel/auth/presentation/provider/cubit/checkbox_cubit/checkbox_cubit.dart';
import 'package:user_panel/auth/presentation/provider/cubit/icon_cubit/icon_cubit.dart';
import 'package:user_panel/auth/presentation/provider/cubit/timer_cubit/timer_cubit.dart';
import 'package:user_panel/core/cloudinary/cloudinary_config.dart';
import 'package:user_panel/core/cloudinary/cloudinary_service.dart';
import 'package:user_panel/core/routes/routes.dart';
import 'package:user_panel/core/themes/theme_manager.dart';
import 'package:user_panel/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/presentation/provider/bloc/reset_password/reset_password_bloc.dart';

void main() async {
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
        //Auth Bloc
        BlocProvider(create: (context) => SplashBloc()..add(StartSplashEvent())),
        BlocProvider(create: (context) => LocationBloc(GetLocationUseCase())),
        BlocProvider(create: (context) => SerchlocatonBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => LoginBloc(AuthRepositoryImplLogin())),
        BlocProvider(create: (context) => GooglesignBloc()),
        BlocProvider(create: (context) => ResetPasswordBloc(ResetPasswordRepo())),
        //Auth cubit
        BlocProvider(create: (context) => IconCubit()),
        BlocProvider(create: (context) => ButtonProgressCubit()),
        BlocProvider(create: (context) => CheckboxCubit()),
        BlocProvider(create: (context) => TimerCubit()),
        BlocProvider(create: (context) => ButtomNavCubit()),
        //Appcore Bloc
        BlocProvider(create: (context) => LogoutBloc(context.read<ButtomNavCubit>())),
        BlocProvider(create: (context) => FetchUserBloc(FetchUserRepositoryImpl())..add(FetchCurrentUserRequst())),
        BlocProvider(create: (context) => UpdateProfileBloc(CloudinaryService(), UpdateUserProfileUseCase())),
        BlocProvider(create: (context) => FetchAllbarberBloc(FetchBarberRepositoryImpl())..add(FetchAllBarbersRequested())),
        BlocProvider(create: (context) => FetchBarberDetailsBloc(repository: FetchBarberDetailsRepositoryImpl())),
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


