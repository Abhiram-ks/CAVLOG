import 'package:barber_pannel/presentation/screens/AuthenticationScreens/adminRequst/admin_request.dart';
import 'package:barber_pannel/presentation/screens/AuthenticationScreens/login/login_screen.dart';
import 'package:barber_pannel/presentation/screens/AuthenticationScreens/register/register_credentials_screen.dart';
import 'package:barber_pannel/presentation/screens/AuthenticationScreens/register/register_details_screen.dart';
import 'package:barber_pannel/presentation/screens/AuthenticationScreens/resetPassword/reset_password_screen.dart';
import 'package:barber_pannel/presentation/screens/coreAppScreens/home/home_screen.dart';
import 'package:barber_pannel/presentation/screens/splash/splash_screen.dart';
import 'package:barber_pannel/presentation/screens/AuthenticationScreens/otp/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login_screen';
  static const String registerDetails  = '/register_details_screen';
  static const String registerCredentials = '/register_credentials_screen';
  static const String otp = '/otp_screen';
  static const String adminRequest = '/admin_request';
  static const String home = '/home_screen';
  static const String resetPassword = '/reset_password_screen';


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
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case resetPassword:
        return CupertinoPageRoute(builder: (_) =>  ResetPasswordScreen());
      default:
       return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}