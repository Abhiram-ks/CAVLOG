import 'package:barber_pannel/cavlog/app/data/repositories/post_uploading_repo.dart';
import 'package:barber_pannel/cavlog/app/domain/usecases/upload_post_usecase.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/profile_widgets/profile_helper_widget/profile_tabbar_widget.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/profile_widgets/tabbar_profile/posts.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/profile_widgets/tabbar_profile/tabbar_post/post_upload.dart';
import 'package:barber_pannel/cavlog/app/presentation/widgets/profile_widgets/tabbar_profile/settings.dart';
import 'package:barber_pannel/cavlog/app/data/models/barber_model.dart';
import 'package:barber_pannel/core/cloudinary/cloudinary_service.dart';
import 'package:barber_pannel/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/common/common_imageshow.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/image/app_images.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../data/repositories/image_picker_repo.dart';
import '../../../../domain/usecases/image_picker_usecase.dart';
import '../../../provider/bloc/image_picker/image_picker_bloc.dart';
import '../../../provider/bloc/modifications/upload_post_bloc/upload_post_bloc.dart';
import '../../../provider/cubit/profiletab/profiletab_cubit.dart';

class ProfileScrollView extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final BarberModel barber;

  const ProfileScrollView({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.barber,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       //.BlocProvider(create: (_) => FetchPostsBloc(FetchBarberPostRepositoryImpl())..add(FetchPostRequest())),
        BlocProvider(create: (_) => ProfiletabCubit()),
        BlocProvider(create: (_) => UploadPostBloc(CloudinaryService(),UploadPostUsecase(PostUploadingRepo()))), 
        BlocProvider(create: (context) => ImagePickerBloc(PickImageUseCase(ImagePickerRepositoryImpl(ImagePicker())))),
      ],
      child: Builder(builder: (context) {
        final ScrollController scrollController = ScrollController();

        return CustomScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: AppPalette.blackClr,
              expandedHeight: screenHeight * 0.35,
              pinned: true,
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                bool isCollapsed = constraints.biggest.height <=
                    kToolbarHeight + MediaQuery.of(context).padding.top;
                return FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  title: isCollapsed
                      ? Row(
                          children: [
                            ConstantWidgets.width40(context),
                            Text( barber.barberName,style: TextStyle(color: AppPalette.whiteClr),
                            ),
                          ],
                        ): Text(''),
                  titlePadding: EdgeInsets.only(left: screenWidth * .04),
                  background: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned.fill(
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            AppPalette.greyClr.withAlpha((0.19 * 270).toInt()),BlendMode.modulate,
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
                              horizontal: screenWidth * 0.08,
                            ), child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstantWidgets.hight30(context),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                          color: AppPalette.greyClr,
                                          width: 60,   height: 60,
                                          child: (barber.image != null &&
                                                  barber.image!
                                                      .startsWith('http'))
                                              ? imageshow(
                                                  imageUrl: barber.image!,
                                                  imageAsset:AppImages.loginImageAbove)
                                              : Image.asset(
                                                  AppImages.loginImageAbove, fit: BoxFit.cover,
                                                )),
                                    ),
                                    ConstantWidgets.width40(context),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        profileviewWidget(
                                          screenWidth, context,  Icons.lock_person_outlined,"Hello, ${barber.barberName}",AppPalette.whiteClr,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context,AppRoutes.accountScreen,arguments: true);
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor:AppPalette.orengeClr,
                                            minimumSize: const Size(0, 0),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0,vertical: 2.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:BorderRadius.circular(15.0),
                                            ),
                                          ),
                                          child: const Text( "Edit Profile",
                                          style: TextStyle( color: AppPalette.whiteClr),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                ConstantWidgets.hight30(context),
                                profileviewWidget(
                                  screenWidth,context, Icons.add_business_rounded,barber.ventureName, AppPalette.whiteClr,
                                ),
                                profileviewWidget(
                                  screenWidth,context, Icons.attach_email,barber.email, AppPalette.hintClr,
                                ),
                                profileviewWidget(
                                  screenWidth,context,Icons.location_on_rounded,barber.address, AppPalette.whiteClr,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: TabBarDelegate(
                TabBar(
                  automaticIndicatorColorAdjustment: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: AppPalette.orengeClr,
                  labelColor: AppPalette.orengeClr,
                  unselectedLabelColor: const Color.fromARGB(255, 128, 128, 128),
                  tabs: const [
                    Tab(icon: Icon(Icons.grid_view_sharp)),
                    Tab(icon: Icon(Icons.photo_size_select_large_sharp)),
                    Tab(icon: Icon(Icons.settings)),
                  ],
                  onTap: (index) { context.read<ProfiletabCubit>().switchTab(index);},
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: BlocBuilder<ProfiletabCubit, int>(
                builder: (context, selectedTab) {
                  return _buildTabContent(selectedTab, screenHeight,screenWidth, context, scrollController,barber);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

//Tabbar bodys

Widget _buildTabContent(int tabIndex, double screenHeight, double screenWidth,
    BuildContext context, ScrollController scrollController, BarberModel barber) {
  switch (tabIndex) {
    case 0:
      return TabbarImageShow();
    case 1:
      return TabbarAddPost(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        barberId: barber.uid,
        scrollController: scrollController,
      );
    case 2:
      return TabbarSettings(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      );
    default:
      return Center(child: Text("Unknown Tab"));
  }
}
