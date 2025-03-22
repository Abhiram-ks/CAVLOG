import 'package:admin/core/common/lottie_widget.dart';
import 'package:admin/core/utils/images/app_images.dart';
import 'package:admin/presentation/screen/home/home_screen.dart';
import 'package:admin/presentation/screen/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/screen/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login_screen';
  static const String home  = '/home_screen';

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_)=> const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return CupertinoPageRoute(builder:(_) => const HomeScreen());
      default:
       return MaterialPageRoute(
          builder: (_) =>  Scaffold(
            body: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LottiefilesCommon(assetPath: AppLottieImages.pageNotFound, width: 200, height: 200),
                Text('Oops!. PAGE NOT FOUND')
              ],
            )),
          ),
        );
    }
  }
}