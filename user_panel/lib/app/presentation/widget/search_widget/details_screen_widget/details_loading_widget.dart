  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_panel/app/presentation/widget/search_widget/details_screen_widget/details_imagescroll_widget.dart';
import 'package:user_panel/app/presentation/widget/search_widget/details_screen_widget/details_post_widget.dart';
import 'package:user_panel/app/presentation/widget/search_widget/details_screen_widget/details_services_buld_widget.dart';
import 'package:user_panel/app/presentation/widget/search_widget/details_screen_widget/details_top_portion_widget.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../../../core/utils/image/app_images.dart';
import '../../../../data/models/barber_model.dart';
import '../../../provider/cubit/tab_cubit/tab_cubit.dart';
import '../rating_review_widget/reviews_rating_widget.dart';

Shimmer detailshowWidgetLoading(BarberModel barber, double screenHeight, double screenWidth, BuildContext context) {
    return Shimmer.fromColors(
                  baseColor: Colors.grey[300] ?? AppPalette.greyClr,
                  highlightColor: AppPalette.whiteClr,
                  child: Column(
                    children: [
                      ImageScolingWidget(
                          imageList: [
                            barber.image ?? AppImages.barberEmpty,
                            barber.detailImage ?? AppImages.barberEmpty
                          ],
                          screenHeight: screenHeight,
                          screenWidth: screenWidth),
                      DetailTopPortionWidget(
                          screenWidth: screenWidth, barber: barber),
                      ConstantWidgets.hight30(context),
                      BlocProvider(
                        create: (context) => TabCubit(),
                        child: Expanded(
                          child: Column(
                            children: [
                              BlocBuilder<TabCubit, int>(
                                builder: (context, selectedIndex) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(3, (index) {
                                      final tabs = [
                                        'Post',
                                        'Services',
                                        'review'
                                      ];
                                      return GestureDetector(
                                        onTap: () => context
                                            .read<TabCubit>()
                                            .changeTab(index),
                                        child: Column(
                                          children: [
                                            Text(
                                              tabs[index],
                                              style: TextStyle(
                                                fontWeight:
                                                    selectedIndex == index
                                                        ? FontWeight.w900
                                                        : FontWeight.bold,
                                                color: selectedIndex == index
                                                    ? Colors.black
                                                    : Colors.grey,
                                              ),
                                            ),
                                            ConstantWidgets.hight20(context)
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                              Expanded(
                                child: BlocBuilder<TabCubit, int>(
                                  builder: (context, selectedIndex) {
                                    return IndexedStack(
                                      index: selectedIndex,
                                      children: [
                                        DetailPostWidget(),
                                        DetilServiceWidget(
                                          screenWidth: screenWidth,
                                        ),
                                        DetailsReviewWidget(
                                          barber: barber,
                                          screenHight: screenHeight,
                                          screenWidth: screenWidth,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
  }