import 'package:barber_pannel/core/common/common_imageshow.dart';
import 'package:barber_pannel/core/utils/constant/constant.dart';
import 'package:barber_pannel/core/utils/image/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../provider/bloc/fetch_posts_bloc/fetch_posts_bloc.dart';
class TabbarImageShow extends StatelessWidget {
  const TabbarImageShow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchPostsBloc, FetchPostsState>(
      builder: (context, state) {
        if (state is FetchPostsLoadingState || state is FetchPostFailureState) {
          return loadingImage();
        } else if (state is FetchPostFailureState) {
          return Center(child: Text(state.errorMessage));
        } else if (state is FetchPostsEmptyState) {
          return  Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.photo_fill_on_rectangle_fill, size: 50,),
              ConstantWidgets.hight20(context),
              Text('No posts yet'),
            ],
          ));
        } 
        else if (state is FetchPostSuccessState) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 1,
            ),
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: imageshow(
                  imageUrl: post.imageUrl, 
                  imageAsset: AppImages.loginImageAbove)
              );
            },
          );
        } 
        else {
          return loadingImage();
        }
      },
    );
  }

  Shimmer loadingImage() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300] ?? AppPalette.greyClr,
        highlightColor: AppPalette.whiteClr,
    child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 1,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.zero, 
                ),
                child: Image.asset(
                  AppImages.splashImage,
                  fit: BoxFit.cover, 
                ),
              );
            },
     ),
  );
  }
}
