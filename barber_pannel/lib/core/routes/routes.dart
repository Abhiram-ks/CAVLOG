import 'package:barber_pannel/cavlog/app/presentation/screens/navigation/bottom_navigation_controllers.dart';
import 'package:barber_pannel/cavlog/app/presentation/screens/settings/chenge_password.dart';
import 'package:barber_pannel/cavlog/app/presentation/screens/settings/profile_edit_details.dart';
import 'package:barber_pannel/cavlog/auth/presentation/screens/adminRequst/admin_request.dart';
import 'package:barber_pannel/cavlog/auth/presentation/screens/blocked/blocked_screen.dart';
import 'package:barber_pannel/cavlog/auth/presentation/screens/login/login_screen.dart';
import 'package:barber_pannel/cavlog/auth/presentation/screens/register/register_credentials_screen.dart';
import 'package:barber_pannel/cavlog/auth/presentation/screens/register/register_details_screen.dart';
import 'package:barber_pannel/cavlog/auth/presentation/screens/resetPassword/reset_password_screen.dart';
import 'package:barber_pannel/cavlog/auth/presentation/screens/splash/splash_screen.dart';
import 'package:barber_pannel/cavlog/auth/presentation/screens/otp/otp_screen.dart';
import 'package:barber_pannel/core/common/lottie_widget.dart';
import 'package:barber_pannel/core/utils/image/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login_screen';
  static const String registerDetails  = '/register_details_screen';
  static const String registerCredentials = '/register_credentials_screen';
  static const String otp = '/otp_screen';
  static const String adminRequest = '/admin_request';
  static const String home = '/bottom_navigation_controllers';
  static const String resetPassword = '/reset_password_screen';
  static const String blocked = '/blocked_screen';
  static const String chengePassword = '/chenge_password'; 
  static const String accountScreen = '/profile_edit_details';


  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_)=> const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_)=> LoginScreen());
      case registerDetails:
        return CupertinoPageRoute(builder: (_)=>  RegisterDetailsScreen());
      case registerCredentials:
        return MaterialPageRoute(builder: (_)=>  RegisterCredentialsScreen());
      case otp:
         return MaterialPageRoute(builder:(_) => const OtpScreen());
      case adminRequest:
        return MaterialPageRoute(builder: (_) => const AdminRequest());
      case home:
        return MaterialPageRoute(builder: (_) =>  BottomNavigationControllers());
      case resetPassword:
        return CupertinoPageRoute(builder: (_) =>  ResetPasswordScreen());
      case blocked:
        return CupertinoPageRoute(builder: (_) => BlockedScreen());
      case chengePassword:
        return CupertinoPageRoute(builder: (_) => ChengePassword());
      case accountScreen:
        final args = settings.arguments as bool;
        return CupertinoPageRoute(builder: (_) => ProfileEditDetails(isShow: args));
      default:
       return MaterialPageRoute(
          builder: (_) =>  Scaffold(
            body: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LottiefilesCommon(assetPath: LottieImages.pageNotFound, width: 200, height: 200),
                Text('Oops!. PAGE NOT FOUND')
              ],
            )),
          ),
        );
    }
  }
}