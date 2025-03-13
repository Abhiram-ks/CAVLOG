import 'package:barber_pannel/presentation/screens/login/login_screen.dart';
import 'package:barber_pannel/presentation/screens/register/register_credentials_screen.dart';
import 'package:barber_pannel/presentation/screens/register/register_details_screen.dart';
import 'package:barber_pannel/presentation/screens/splash/splash_screen.dart';
import 'package:barber_pannel/presentation/screens/otp/otp_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login_screen';
  static const String registerDetails  = '/register_details_screen';
  static const String registerCredentials = '/register_credentials_screen';
  static const String otp = '/otp_screen';


  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_)=> const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_)=> const LoginScreen());
      case registerDetails:
        return MaterialPageRoute(builder: (_)=>  RegisterDetailsScreen());
      case registerCredentials:
        return MaterialPageRoute(builder: (_)=>  RegisterCredentialsScreen());
      case otp:
         return MaterialPageRoute(builder:(_) => const OtpScreen());
      default:
       return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}