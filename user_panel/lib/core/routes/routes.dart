import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_panel/app/presentation/screens/navigation/bottom_navigation_controllers.dart';
import 'package:user_panel/app/presentation/screens/pages/search/detail_screen/booking_screen/booking_screen.dart';
import 'package:user_panel/app/presentation/screens/settings/settings_subscreens/profile_and_edit_screen.dart';
import 'package:user_panel/auth/presentation/screen/location_screen/location_screen.dart';
import 'package:user_panel/auth/presentation/screen/login_screen/login_screen.dart';
import 'package:user_panel/auth/presentation/screen/otp_screen/otp_screen.dart';
import 'package:user_panel/auth/presentation/screen/register_screen/register_credentials_screen.dart';
import 'package:user_panel/auth/presentation/screen/register_screen/register_details_screen.dart';
import 'package:user_panel/auth/presentation/screen/reset_screen/reset_password_screen.dart';
import 'package:user_panel/auth/presentation/screen/splash_screen/splash_screen.dart';
import 'package:user_panel/core/common/custom_lottie_widget.dart';
import 'package:user_panel/core/utils/image/app_images.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login_screen';
  static const String resetPassword = '/reset_password_screen';
  static const String registreDetail= '/register_details_screen';
  static const String locationAccess= '/location_screen';
  static const String registerCredential = '/register_credentials_screen';
  static const String otp = '/otp_screen';
  static const String home = '/bottom_navigation_controllers';
  static const String account = '/profile_and_edit_screen';
  static const String booking = '/booking_screen';

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());
      case resetPassword:
        final args = settings.arguments as bool;
        return CupertinoPageRoute(builder:(_) => ResetPasswordScreen(isWhat: args));
      case registreDetail:
        return CupertinoPageRoute(builder:(_) => RegisterDetailsScreen());
      case locationAccess:
        final args = settings.arguments as TextEditingController;
        return MaterialPageRoute(builder: (_) => LocationMapPage(addressController: args));
      case registerCredential:
        return CupertinoPageRoute(builder:(_) => RegisterCredentialsScreen());
      case otp:
        return CupertinoPageRoute(builder:(_) => OtpScreen());
      case home:
        return MaterialPageRoute(builder: (_) => BottomNavigationControllers());
      case account:
        final args = settings.arguments as bool;
        return CupertinoPageRoute(builder:(_) => ProfileEditDetails(isShow: args));
      case booking:
        final args = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => BookingScreen(shopId:args));
      default: 
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   LottieFilesCommon.load(assetPath: LottieImages.pageNotFound, width: 200, height: 200),
                   Text('Oops!. PAGE NOT FOUOND')
                ],
              ),
            ),
          ));
    }
  }
}