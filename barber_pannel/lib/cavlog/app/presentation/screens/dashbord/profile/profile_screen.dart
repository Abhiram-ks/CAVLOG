import 'package:barber_pannel/cavlog/app/presentation/provider/cubit/profiletab/profiletab_cubit.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/utils/image/app_images.dart';
import 'package:barber_pannel/core/utils/media_quary/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              body: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: AppPalette.blackClr,
                      expandedHeight: screenHeight * 0.35,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
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
                                    child: Image.asset(AppImages.loginImageBelow,
                                        fit: BoxFit.cover))),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.08,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ConstantWidgets.hight30(context),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: AppPalette.whiteClr,
                                            backgroundImage: AssetImage(
                                                AppImages.loginImageAbove),
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
                                                  "Hello, joe Samnta",
                                                  AppPalette.whiteClr),
                                              TextButton(
                                                onPressed: () {},
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      AppPalette.orengeClr,
                                                  minimumSize: const Size(0, 0),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 6.0,
                                                          vertical: 2.0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Edit Profile",
                                                  style: TextStyle(
                                                      color: AppPalette.whiteClr),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      ConstantWidgets.hight30(context),
                                      profileviewWidget(
                                          screenWidth,
                                          context,
                                          Icons.add_business_rounded,
                                          'Cavlog Haircuts',
                                          AppPalette.whiteClr),
                                      profileviewWidget(
                                          screenWidth,
                                          context,
                                          Icons.attach_email,
                                          'abhiramks0001@gmail.com',
                                          AppPalette.hintClr),
                                      profileviewWidget(
                                          screenWidth,
                                          context,
                                          Icons.location_on_rounded,
                                          'Wayanad kerala bathery - india',
                                          AppPalette.whiteClr),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                        pinned: true,
                        delegate: TabBarDelegate(TabBar(
                          automaticIndicatorColorAdjustment: true,
                          indicatorSize: TabBarIndicatorSize.tab, 
                          indicatorColor: AppPalette.orengeClr,
                          labelColor: AppPalette.orengeClr,
                          unselectedLabelColor: AppPalette.greyClr,
                          tabs: const [
                            Tab(
                              icon: Icon(Icons.grid_view_sharp),
                            ),
                            Tab(
                              icon: Icon(Icons.photo_size_select_large_sharp),
                            ),
                            Tab(icon: Icon(Icons.settings),
                            ),
                          ],
                          onTap: (index) {
                            context.read<ProfiletabCubit>().switchTab(index);
                          },
                        ))),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: BlocBuilder<ProfiletabCubit, int>(
                        builder: (context, selectedTab) {
                          return SingleChildScrollView(
                            child: SizedBox(
                              height: screenHeight * 0.8,
                              child: _buildTabContent(selectedTab),
                            ),
                          );
                        },
                      ),
                    )
                  ]),
            ),
          ),
        ),
      );
    });
  }

  SizedBox profileviewWidget(double screenWidth, BuildContext context,
      IconData icons, String heading, Color iconclr) {
    return SizedBox(
      width: screenWidth * 0.55,
      child: Row(children: [
        Icon(
          icons,
          color: iconclr,
        ),
        ConstantWidgets.width20(context),
        Expanded(
          child: Text(
            heading,
            style: TextStyle(
              color: AppPalette.whiteClr,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]),
    );
  }
}

Widget _buildTabContent(int tabIndex) {
  switch (tabIndex) {
    case 0:
      return Center(child: Text("Content for Tab 1"));
    case 1:
      return Center(child: Text("Content for Tab 2"));
    case 2:
      return Center(child: Text("Content for Tab 3"));
    default:
      return Center(child: Text("Unknown Tab"));
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  TabBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppPalette.blackClr,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
