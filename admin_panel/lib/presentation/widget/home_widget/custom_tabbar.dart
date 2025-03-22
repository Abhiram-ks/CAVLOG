import 'package:admin/core/themes/colors.dart';
import 'package:admin/presentation/provider/bloc/logout/logout_bloc.dart';
import 'package:admin/presentation/widget/home_widget/handle_logoutstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/images/app_images.dart';

class TabBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const TabBarCustom({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppPalette.whiteClr,
      title: Row(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image.asset(
              AppImages.dashbordImage,
              width: 70,
              height: 70,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            'CΛVLOG',
            style: GoogleFonts.bellefair(
              color: AppPalette.blackClr,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: screenWidth * .04),
          child: BlocListener<LogoutBloc, LogoutState>(
            listener: (context, state) {
              handleLogoutState(context, state);
            },
            child: IconButton(
              onPressed: () {
                BlocProvider.of<LogoutBloc>(context).add(LogoutActionEvent());

              },
              icon: Icon(
                CupertinoIcons.power,
              ),
            ),
          ),
        ),
      ],
      bottom: TabBar(
        tabAlignment: TabAlignment.fill,
        dividerColor: AppPalette.trasprentClr,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 3.0, color: AppPalette.blackClr),
        ),
        labelColor: AppPalette.blackClr,
        unselectedLabelColor: AppPalette.hintClr,
        tabs: [
          Tab(text: 'Administration'),
          Tab(text: 'Services'),
          Tab(text: 'Banner Control'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
