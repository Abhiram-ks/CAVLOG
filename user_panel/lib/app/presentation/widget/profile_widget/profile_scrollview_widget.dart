import 'package:flutter/material.dart';
import 'package:user_panel/auth/data/models/user_model.dart';
import 'package:user_panel/app/presentation/screens/settings/settings_screen.dart';
import 'package:user_panel/app/presentation/widget/profile_widget/profile_scrollable_section.dart';
import 'package:user_panel/core/common/custom_imageshow_widget.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/utils/constant/constant.dart';
import '../../../../core/utils/image/app_images.dart';


class ProfileScrollviewWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final UserModel user;
  final ScrollController _scrollController = ScrollController();

   ProfileScrollviewWidget(
      {super.key, required this.screenHeight, required this.screenWidth, required this.user});

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: AppPalette.blackClr,
            expandedHeight: screenHeight * 0.32,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                bool isCollapsed = constraints.biggest.height <=
                    kToolbarHeight + MediaQuery.of(context).padding.top;
                      return FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      title: isCollapsed
                          ? Row(
                              children: [
                                ConstantWidgets.width40(context),
                                Text(
                                  user.userName,
                                  style: TextStyle(color: AppPalette.whiteClr),
                                ),
                              ],
                            )
                          : Text(''),
                      titlePadding: EdgeInsets.only(left: screenWidth * .04),
                      background: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.hardEdge,
                        children: [
                         Positioned.fill(
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                AppPalette.greyClr
                                    .withAlpha((0.19 * 270).toInt()),
                                BlendMode.modulate,
                              ),
                              child: Image.asset(
                                AppImages.loginImageBelow,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ConstantWidgets.hight30(context),
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Container(
                                              color: AppPalette.greyClr,
                                              width: 60,
                                              height: 60,
                                              child: (user.image.startsWith('http'))
                                              ? imageshow(imageUrl: user.image, imageAsset: AppImages.loginImageAbove)
                                              :  Image.asset(AppImages.loginImageAbove,fit: BoxFit.cover,)
                                            ),
                                          ),
                                          ConstantWidgets.width40(context),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              profileviewWidget(
                                                screenWidth,
                                                context,
                                                Icons.lock_person_outlined,
                                                "Hello, ${user.userName}",
                                                AppPalette.whiteClr,
                                              ),
                                              TextButton(
                                                onPressed: () =>  Navigator.pushNamed(context, AppRoutes.account,arguments: true),
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      AppPalette.orengeClr,
                                                  minimumSize: const Size(0, 0),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                    horizontal: 6.0,
                                                    vertical: 2.0,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Edit Profile",
                                                  style: TextStyle(
                                                    color: AppPalette.whiteClr,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      ConstantWidgets.hight50(context),
                                      profileviewWidget(
                                        screenWidth,
                                        context,
                                        Icons.attach_email,
                                        user.email,
                                        AppPalette.hintClr,
                                      ),
                                      profileviewWidget(
                                        screenWidth,
                                        context,
                                        user.google ? Icons.g_mobiledata_sharp :
                                        Icons.location_on_rounded,
                                        user.google? 'Signed in via Google'  : user.address,
                                        user.google ? AppPalette.blueClr : AppPalette.whiteClr,
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ],
                      ),
                    );
              },
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: SettingsScreen(
                screenHeight: screenHeight, screenWidth: screenWidth),
          )
        ],
      );
  }
}
