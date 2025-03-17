import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/presentation/screens/AuthenticationScreens/adminRequst/admin_request.dart';
import 'package:flutter/material.dart';


  void navigateToAdminRequest(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, animation, __) => AdminRequest(),
        transitionsBuilder: (_, animation, __, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
               ColoredBox(color: AppPalette.orengeClr),
              ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOutQuad),
                ),
                child: FadeTransition(opacity: animation, child: child),
              ),
            ],
          );
        },
      ),
    );
  }



