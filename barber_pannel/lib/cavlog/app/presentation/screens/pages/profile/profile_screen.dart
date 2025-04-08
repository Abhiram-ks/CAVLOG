import 'package:barber_pannel/core/common/common_loading_widget.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../provider/bloc/fetchbarber/fetch_barber_bloc.dart';
import '../../../widgets/profile_widgets/profile_helper_widget/profile_scrollview.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext conte1xt) {
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
                    if (state is FetchBarbeLoading || state is FetchBarberError) {
                      return LoadingScreen(screenHeight: screenHeight, screenWidth: screenWidth);
                    }
                    return ProfileScrollView(screenHeight: screenHeight, screenWidth: screenWidth);
                  },
                )),
          ),
        ),
      );
    });
  }
}
