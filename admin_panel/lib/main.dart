import 'package:admin/core/cloudinary/cloudinary_config.dart';
import 'package:admin/core/themes/themes_manager.dart';
import 'package:admin/core/cloudinary/cloudinary_service.dart';
import 'package:admin/data/datasources/store_imageservice/firestore_image_service.dart';
import 'package:admin/data/repositories/auth_repository.dart';
import 'package:admin/data/repositories/banner_repositoty.dart';
import 'package:admin/data/repositories/barbers_repository.dart';
import 'package:admin/data/repositories/image_picker_repo_impl.dart';
import 'package:admin/data/repositories/service_repository.dart';
import 'package:admin/domain/useCase/delete_image_url_usecase.dart';
import 'package:admin/domain/useCase/image_picker_usecase.dart';
import 'package:admin/domain/useCase/login_usecase.dart';
import 'package:admin/domain/useCase/upload_service_usecase.dart';
import 'package:admin/firebase_options.dart';
import 'package:admin/presentation/provider/bloc/barber_status/barberstatus_bloc.dart';
import 'package:admin/presentation/provider/bloc/fetchbannerbarber/fetch_banner_barber_bloc.dart';
import 'package:admin/presentation/provider/bloc/fetchbarbers/fetch_barbers_bloc.dart';
import 'package:admin/presentation/provider/bloc/fetching_service/fetching_service_bloc.dart';
import 'package:admin/presentation/provider/bloc/fetchuserbanner/fetch_user_banner_bloc.dart';
import 'package:admin/presentation/provider/bloc/imageUpload/image_upload_bloc.dart';
import 'package:admin/presentation/provider/bloc/imagedeletion/image_deletion_bloc.dart';
import 'package:admin/presentation/provider/bloc/loging/login_bloc.dart';
import 'package:admin/presentation/provider/bloc/logout/logout_bloc.dart';
import 'package:admin/presentation/provider/bloc/pick_image/pick_image_bloc.dart';
import 'package:admin/presentation/provider/bloc/requstbox/requstbox_bloc.dart';
import 'package:admin/presentation/provider/bloc/service_management/service_mangement_bloc.dart';
import 'package:admin/presentation/provider/bloc/splash/splash_bloc.dart';
import 'package:admin/presentation/provider/bloc/toggleview/toggleview_bloc.dart';
import 'package:admin/presentation/provider/cubit/Icon/icon_cubit.dart';
import 'package:admin/presentation/provider/cubit/buttonProgress/button_progress_cubit.dart';
import 'package:admin/presentation/provider/cubit/radio_button/radio_cubit.dart';
import 'package:admin/presentation/provider/cubit/serviceTages/service_tags_cubit_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'core/routes/routes.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  CloudinaryConfig.initialize();
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
          BlocProvider(create: (context) => RadioCubit()),
          BlocProvider(create: (context) => LogoutBloc()),
          BlocProvider(create: (context) => RequstboxBloc()),
          BlocProvider(create: (context) => ToggleviewBloc()),
          BlocProvider(create: (context) => BarberstatusBloc()),
          BlocProvider(create: (context) => ButtonProgressCubit()),
          BlocProvider(create: (context) => ServiceTagsCubitCubit()),
          BlocProvider(create: (context) => ImageDeletionBloc(FirestoreImageServiceDeletion())),
          BlocProvider(create: (context) => ImageUploadBloc(FirestoreImageService(), CloudinaryService())),
          BlocProvider(create: (context) => LoginBloc(LoginUsecase(authRepository: AuthnticationProcess()))),
          BlocProvider(create: (context) => PickImageBloc(PickImageUseCase(ImagePickerRepositoryImpl(ImagePicker())))),
          BlocProvider(create: (context) => ServiceMangementBloc(FirebaseServiceRepository(FirebaseFirestore.instance))),
          BlocProvider(create: (context) => FetchingServiceBloc(ServiceRepository(FirebaseFirestore.instance))..add(FetchServiceDataEvent())),
          BlocProvider(create: (context) => FetchBarbersBloc(BarbersRepository(FirebaseFirestore.instance))..add(FetchBarbersDataEvent())),
          BlocProvider(create: (context) => FetchUserBannerBloc(BannerRepositoty(FirebaseFirestore.instance))..add(FetchUserBannerAction())),
          BlocProvider(create: (context) => FetchBannerBarberBloc(BannerRepositoty(FirebaseFirestore.instance))..add(FetchBarberBannerAction()))
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

