
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_panel/app/presentation/widget/profile_widget/profile_scrollview_widget.dart';
import 'package:user_panel/auth/data/models/user_model.dart';
import 'package:user_panel/core/themes/colors.dart';
import 'package:user_panel/core/utils/image/app_images.dart';

import '../../../provider/bloc/fetching_bloc/fetch_user_bloc/fetch_user_bloc.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(builder: (context, constraints) {
      double screenHeight = constraints.maxHeight;
      double screenWidth = constraints.maxWidth;

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: ColoredBox(
          color:AppPalette.blackClr,
          child: SafeArea(
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: BlocBuilder<FetchUserBloc, FetchUserState>(
                    buildWhen: (previous, current) => current is FetchUserLoaded,
                    builder: (context, state) {
                      if (state is FetchUserLoading || state is FetchUserError) {
                        return profilepageloading(screenHeight, screenWidth);
                      }
                      else if (state is FetchUserLoaded){
                         return ProfileScrollviewWidget(
                          screenHeight: screenHeight, screenWidth: screenWidth, user: state.user);
                      }
                      return  profilepageloading(screenHeight, screenWidth);
                    },
                  ))),
        ),
      );
    });
  }

  Shimmer profilepageloading(double screenHeight, double screenWidth) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300] ?? AppPalette.greyClr,
      highlightColor: AppPalette.whiteClr,
      child: ProfileScrollviewWidget( screenHeight: screenHeight, screenWidth: screenWidth, user: UserModel(uid: '', userName: 'loading....', phoneNumber: '12456789', address: '', email: 'cavlogenoia@gmail.com', image: AppImages.barberEmpty, age: 20, createdAt: DateTime.now(), google: true)),
     );
  }
}
