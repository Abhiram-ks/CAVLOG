import 'dart:developer';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/app/data/models/barber_model.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetch_barber_bloc/fetch_barber_id_bloc.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetch_barber_details_bloc/fetch_barber_details_bloc.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetch_posts_bloc/fetch_posts_bloc.dart';
import 'package:user_panel/app/presentation/provider/bloc/rating_review_bloc/rating_review_bloc.dart';
import 'package:user_panel/app/presentation/widget/search_widget/rating_review_widget/handle_ratereview_state.dart';
import 'package:user_panel/core/utils/image/app_images.dart';
import '../../../../../../core/common/custom_actionbutton_widget.dart';
import '../../../../../../core/themes/colors.dart';
import '../../../../../../core/utils/constant/constant.dart';
import '../../../../provider/cubit/tab_cubit/tab_cubit.dart';
import '../../../../widget/profile_widget/profile_scrollable_section.dart';
import '../../../../widget/search_widget/details_screen_widget/details_imagescroll_widget.dart';
import '../../../../widget/search_widget/details_screen_widget/details_loading_widget.dart';
import '../../../../widget/search_widget/details_screen_widget/details_post_widget.dart';
import '../../../../widget/search_widget/details_screen_widget/details_services_buld_widget.dart';
import '../../../../widget/search_widget/details_screen_widget/details_top_portion_widget.dart';

class DetailBarberScreen extends StatefulWidget {
  final String barberId;
  const DetailBarberScreen({
    super.key,
    required this.barberId,
  });

  @override
  State<DetailBarberScreen> createState() => _DetailBarberScreenState();
}

class _DetailBarberScreenState extends State<DetailBarberScreen> {
  late final List<String> imageList;
  @override
  void initState() {
    super.initState();
    context
        .read<FetchBarberIdBloc>()
        .add(FetchBarberDetailsAction(widget.barberId));
    context
        .read<FetchPostsBloc>()
        .add(FetchPostRequest(barberId: widget.barberId));
    context
        .read<FetchBarberDetailsBloc>()
        .add(FetchBarberServicesRequested(widget.barberId));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;

        return Scaffold(
            body: BlocBuilder<FetchBarberIdBloc, FetchBarberIdState>(
              builder: (context, state) {
                log('Fetch barber state is like : $state');
                if (state is FetchBarberDetailsLoading ||
                    state is FetchBarberDetailsFailure) {
                      BarberModel barber = BarberModel(uid: '', barberName: 'barberNamei', ventureName: 'Cavlog - Executing smarter, Manaing better', phoneNumber: 'phoneNumber', address: '221B Baker street Santa clau 101 saint NIcholas Dive North Pole, Landon -  99705', email: 'cavlogenoia@gmail.com', isVerified: true, isblok: false);
                  return  detailshowWidgetLoading(barber, screenHeight, screenWidth, context);
                } else if (state is FetchBarberDetailsSuccess) {
                  final barber = state.barberServices;
                  return Column(
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
                  );
                }
                return  detailshowWidgetLoading(BarberModel(uid: '', barberName: 'barberNamei', ventureName: 'Cavlog - Executing smarter, Manaing better', phoneNumber: 'phoneNumber', address: '221B Baker street Santa clau 101 saint NIcholas Dive North Pole, Landon -  99705', email: 'cavlogenoia@gmail.com', isVerified: true, isblok: false), screenHeight, screenWidth, context);
              },
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.09),
              child: ButtonComponents.actionButton(
                screenWidth: screenWidth,
                onTap: () {},
                label: 'Booking Now',
                screenHeight: screenHeight,
              ),
            ));
      },
    );
  }
}

class SheduleTagsWidget extends StatelessWidget {
  final String text;
  const SheduleTagsWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.scafoldClr,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppPalette.hintClr,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child:
          Text(text, style: TextStyle(fontSize: 18, color: AppPalette.greyClr)),
    );
  }
}

class DetailsReviewWidget extends StatelessWidget {
  final BarberModel barber;
  final double screenWidth;
  final double screenHight;
  const DetailsReviewWidget({
    super.key,
    required this.screenWidth,
    required this.screenHight,
    required this.barber,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ratings & Reviews',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  profileviewWidget(
                    screenWidth,
                    context,
                    Icons.verified,
                    'by varified Customers',
                    textColor: AppPalette.greyClr,
                    AppPalette.blueClr,
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    showReviewDetisSheet(context, screenHight, screenWidth);
                  },
                  icon: Icon(Icons.arrow_forward_ios_rounded))
            ],
          ),
          ConstantWidgets.hight30(context),
          Row(
            children: [
              Text('${(barber.rating ?? 0.0).toStringAsFixed(1)} / 5',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              ConstantWidgets.width20(context),
              RatingBarIndicator(
                rating: barber.rating ?? 0.0,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: AppPalette.blackClr,
                ),
                itemCount: 5,
                itemSize: 25.0,
                direction: Axis.horizontal,
              ),
            ],
          ),
          ConstantWidgets.hight30(context),
          ButtonComponents.actionButton(
            screenWidth: screenWidth,
            screenHeight: screenHight,
            label: 'Rate & Review',
            onTap: () {
              showReviewBottomSheet(context, barber);
            },
            buttonColor: AppPalette.greyClr,
          ),
          ConstantWidgets.hight10(context),
          Text(
            'Ratings and reiews are varified and are from people who use the same type of device that you use ⓘ',
          )
        ],
      ),
    );
  }

  void showReviewDetisSheet(
      BuildContext context, double screenHeight, double screenWidth) {
    showModalBottomSheet(
      backgroundColor: AppPalette.scafoldClr,
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .05, vertical: screenHeight * 0.08),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ratingReviewListWidget(
                    context: context,
                    imageUrl: AppImages.barberEmpty,
                    userName: 'abhiram ks',
                    rating: 3,
                    date: '22/04/2025',
                    feedback:
                        'l honestly love the shop. Mainly l just use the order function then collect. Relly smooth transaction for payment and oredering. Getting deals is also very easy and smooth...'),
              ),
            ),
          ),
        );
      },
    );
  }

  Column ratingReviewListWidget({
    required BuildContext context,
    required String imageUrl,
    required String userName,
    required double rating,
    required String date,
    required String feedback,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(imageUrl),
            ),
            ConstantWidgets.width20(context),
            Expanded(child: Text(userName)),
          ],
        ),
        ConstantWidgets.hight10(context),
        Row(
          children: [
            RatingBarIndicator(
              rating: rating,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: AppPalette.buttonClr,
              ),
              itemCount: 5,
              itemSize: 18.0,
              direction: Axis.horizontal,
            ),
            ConstantWidgets.width20(context),
            Text(date)
          ],
        ),
        ConstantWidgets.hight20(context),
        Text(feedback)
      ],
    );
  }

  void showReviewBottomSheet(BuildContext context, BarberModel barber) {
    double rating = 5.0;
    TextEditingController reviewController = TextEditingController();

    showModalBottomSheet(
      backgroundColor: AppPalette.scafoldClr,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(barber.ventureName),
              Text(
                  'Help others by sharing your honest experience. Your review will be visible to the shop.',
                  style: TextStyle(color: AppPalette.hintClr)),
              ConstantWidgets.hight10(context),
              Text("Rate this Shop",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Divider(color: AppPalette.hintClr),
              ConstantWidgets.hight10(context),
              Center(
                child: RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  glow: true,
                  glowColor: AppPalette.buttonClr,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: AppPalette.orengeClr),
                  onRatingUpdate: (value) {
                    rating = value;
                  },
                ),
              ),
              ConstantWidgets.hight20(context),
              TextField(
                controller: reviewController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Write your review...",
                  hintStyle: TextStyle(
                    color: AppPalette.hintClr,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppPalette.hintClr,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              BlocListener<RatingReviewBloc, RatingReviewState>(
                listener: (context, state) {
                  handleRatingAndReviewState(context, state);
                },
                child: ButtonComponents.actionButton(
                  screenWidth: screenWidth,
                  onTap: () {
                    String reviewText = reviewController.text.trim();

                    if (reviewText.isNotEmpty) {
                      context.read<RatingReviewBloc>().add(RatingReviewRequest(
                          shopId: barber.uid,
                          description: reviewText,
                          starCount: rating));
                    }
                  },
                  label: 'Submit',
                  screenHeight: screenHight,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
