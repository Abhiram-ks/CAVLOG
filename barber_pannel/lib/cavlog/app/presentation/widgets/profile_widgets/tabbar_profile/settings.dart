import 'package:barber_pannel/cavlog/app/presentation/provider/bloc/logout/logout_bloc.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/profile_widgets/settings_widget/logout_widget/logout_state_handle.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/profile_widgets/settings_widget/settings_filed_widget/settings_custom_widget.dart';
import 'package:barber_pannel/core/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/constant/constant.dart';

class TabbarSettings extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  const TabbarSettings({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
      child: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstantWidgets.hight20(context),
            Text('Settings & privacy',
                style: TextStyle(
                  color: AppPalette.blackClr,
                )),
            Text('Your account',
                style: TextStyle(
                  color: AppPalette.greyClr,
                )),
            settingsWidget(
                context: context,
                screenHeight: screenHeight,
                icon: CupertinoIcons.profile_circled,
                title: 'Profile details',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.accountScreen,arguments: false);
                }),
            settingsWidget(
                context: context,
                screenHeight: screenHeight,
                icon: CupertinoIcons.square_pencil,
                title: 'Edit Profile',
                onTap: () {
                   Navigator.pushNamed(context, AppRoutes.accountScreen,arguments: true);
                }),
            settingsWidget(
                context: context,
                screenHeight: screenHeight,
                icon: CupertinoIcons.lock,
                title: 'Change Password',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.chengePassword);
                }),
            Divider(
              color: AppPalette.hintClr,
            ),
            ConstantWidgets.hight10(context),
            Text('Community support',
                style: TextStyle(
                  color: AppPalette.greyClr,
                )),
            settingsWidget(
                context: context,
                screenHeight: screenHeight,
                icon: CupertinoIcons.question_circle,
                title: 'Help',
                onTap: () {}),
            settingsWidget(
                context: context,
                screenHeight: screenHeight,
                icon: CupertinoIcons.bubble_left,
                title: 'Feedback',
                onTap: () {}),
            settingsWidget(
                context: context,
                screenHeight: screenHeight,
                icon: CupertinoIcons.star,
                title: 'Rate app',
                onTap: () {}),
            Divider(
              color: AppPalette.hintClr,
            ),
            ConstantWidgets.hight10(context),
            Text('Legal policies',
                style: TextStyle(
                  color: AppPalette.greyClr,
                )),
            settingsWidget(
                context: context,
                screenHeight: screenHeight,
                icon: CupertinoIcons.doc,
                title: 'Terms & Conditions',
                onTap: () {}),
            settingsWidget(
                context: context,
                screenHeight: screenHeight,
                icon: CupertinoIcons.shield,
                title: 'Privacy Policy',
                onTap: () {}),
            settingsWidget(
                context: context,
                screenHeight: screenHeight,
                icon: Icons.compare_arrows,
                title: 'Cookies Policy',
                onTap: () {}),
            settingsWidget(
                context: context,
                screenHeight: screenHeight,
                icon: CupertinoIcons.info,
                title: 'About',
                onTap: () {}),
            Divider(
              color: AppPalette.hintClr,
            ),
            ConstantWidgets.hight10(context),
            Text('Login',
                style: TextStyle(
                  color: AppPalette.greyClr,
                )),
            ConstantWidgets.hight20(context),
            BlocListener<LogoutBloc, LogoutState>(
              listener: (context, state) {
                handleLogOutState(context, state);
              },
              child: InkWell(
                onTap: () {
                   BlocProvider.of<LogoutBloc>(context).add(LogoutActionEvent());
                },
                splashColor: AppPalette.trasprentClr,
                child: Text(
                  'Log out',
                  style: TextStyle(color: AppPalette.logoutClr, fontSize: 17),
                ),
              ),
            ),
            ConstantWidgets.hight50(context)
          ],
        ),
      ),
    );
  }
}
