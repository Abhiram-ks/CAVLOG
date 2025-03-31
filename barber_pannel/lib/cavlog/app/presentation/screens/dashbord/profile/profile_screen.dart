import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/utils/image/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../../../core/common/lottie_widget.dart';
import '../../../provider/bloc/fetchbarber/fetch_barber_bloc.dart';
import '../../../widgets/profile_widgets/profile_helper_widget/profile_scrollview.dart';

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
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: BlocBuilder<FetchBarberBloc, FetchBarberState>(
                  builder: (context, state) {
                    if (state is FetchBarbeLoading) {
                      return SpinKitFadingFour(
                        color: AppPalette.greyClr,
                        size: 23.0,
                      );
                    }
                    if (state is FetchBarberError) {
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottiefilesCommon(
                              assetPath: LottieImages.emptyData,
                              width: screenWidth * .4,
                              height: screenHeight * .4),
                          Text('${state.message}. Try Again'),
                        ],
                      );
                    }
                    return ProfileScrollView(
                        screenHeight: screenHeight, screenWidth: screenWidth);
                  },
                )),
          ),
        ),
      );
    });
  }
}
