
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/app/presentation/widget/profile_widget/profile_scrollview_widget.dart';
import 'package:user_panel/core/common/custom_loadingscreen_widget.dart';
import 'package:user_panel/core/themes/colors.dart';

import '../../../provider/bloc/fetchuser_bloc/fetch_user_bloc.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(builder: (context, constraints) {
      double screenHeight = constraints.maxHeight;
      double screenWidth = constraints.maxWidth;

      return ColoredBox(
        color: AppPalette.blackClr,
        child: SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: BlocBuilder<FetchUserBloc, FetchUserState>(
                  buildWhen: (previous, current) => current is FetchUserLoaded,
                  builder: (context, state) {
                    if (state is FetchUserLoading) {
                      return LoadingScreen(screenHeight: screenHeight, screenWidth: screenWidth);
                    }
                    else if (state is FetchUserError){
                       return LoadingScreen(screenHeight: screenHeight, screenWidth: screenWidth);
                    }
                    return ProfileScrollviewWidget(
                        screenHeight: screenHeight, screenWidth: screenWidth);
                  },
                ))),
      );
    });
  }
}
