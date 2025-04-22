import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_panel/app/presentation/widget/search_widget/details_screen_widget/details_screen_actionbuttos.dart';
import '../../../../../core/common/custom_imageshow_widget.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/image/app_images.dart';
import '../../../provider/cubit/image_slider/image_slider_cubit.dart';

class ImageScolingWidget extends StatelessWidget {
  const ImageScolingWidget({
    super.key,
    required this.imageList,
    required this.screenHeight,
    required this.screenWidth,
  });

  final List<String> imageList;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageSliderCubit(imageList: imageList),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ImageSliderCubit>();
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            child: Container(
              height: screenHeight * 0.29,
              width: screenWidth,
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: cubit.pageController,
                    itemCount: imageList.length,
                    onPageChanged: cubit.updatePage,
                    itemBuilder: (context, index) {
                      return (imageList[index].startsWith('http'))
                          ? imageshow(
                              imageUrl: imageList[index],
                              imageAsset: imageList[index])
                          : Image.asset(
                              AppImages.barberEmpty,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            );
                    },
                  ),
                  Positioned(
                      top: 40,
                      left: 20,
                      child: iconsFilledDetail(
                        icon: Icons.arrow_back,
                        forgroudClr: AppPalette.whiteClr,
                        context: context,
                        borderRadius: 100,
                        padding: 10,
                        fillColor:
                            AppPalette.blackClr.withAlpha((0.45 * 255).toInt()),
                        onTap: () => Navigator.pop(context),
                      )),
                  Positioned(
                    bottom: 8,
                    child: BlocBuilder<ImageSliderCubit, int>(
                      builder: (context, state) {
                        return SmoothPageIndicator(
                          controller: cubit.pageController,
                          count: imageList.length,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: AppPalette.whiteClr,
                            dotColor: AppPalette.greyClr,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
