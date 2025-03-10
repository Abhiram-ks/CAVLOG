import 'package:barber_pannel/presentation/screens/login/login_screen.dart';
import 'package:barber_pannel/presentation/screens/register/register_screen.dart';
import 'package:barber_pannel/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login_screen';
  static const String register = '/register_screen';


  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_)=> const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_)=> const LoginScreen());
      case register:
         return MaterialPageRoute(builder: (_)=> const RegisterScreen());
      default:
       return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}