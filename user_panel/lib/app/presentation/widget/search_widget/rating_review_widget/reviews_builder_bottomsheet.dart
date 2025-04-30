import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_panel/core/utils/constant/constant.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/image/app_images.dart';
import '../../../../data/repositories/fetch_reviews_details_repo.dart';
import '../../../provider/bloc/fetching_bloc/fetch_reviews_bloc/fetch_reviews_bloc.dart';
import 'reviews_rating_builder.dart';

void showReviewDetisSheet(BuildContext context, double screenHeight,
    double screenWidth, String shopId) {
  showModalBottomSheet(
    backgroundColor: AppPalette.scafoldClr,
    context: context,
    enableDrag: true,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return BlocProvider(
        create: (context) =>
            FetchReviewsBloc(FetchReviewsDetailsRepositoryImpl())
              ..add(FetchReviewRequest(shopId: shopId)),
        child: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .05, vertical: screenHeight * 0.08),
              child: BlocBuilder<FetchReviewsBloc, FetchReviewsState>(
                builder: (context, state) {
                  if (state is FetchReviewsLoadingState ||
                      state is FetchReviewFailureState) {
                    return reviewsShimerBuilder();
                  } else if (state is FetchReviewsEmptyState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                          Icon(Icons.rate_review_outlined,size: 60, color: AppPalette.buttonClr),
                          ConstantWidgets.hight20(context),
                          Text( 'No reviews yet', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ConstantWidgets.hight10(context),
                          Text('Make an impact – leave the first impression',style: TextStyle(color: AppPalette.greyClr)),ConstantWidgets.hight20(context),
                          const SpinKitThreeBounce(color: AppPalette.buttonClr,size: 30.0),
                        ],
                      ),
                    );
                  } 
                  else if (state is FetchReviewsSuccesState) {
                    final reviews = state.reviews;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All Reviews (${reviews.length})',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(CupertinoIcons.clear),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: reviews.length,
                            itemBuilder: (context, index) {
                              final review = reviews[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: ratingReviewListWidget(
                                  context: context,
                                  imageUrl: review.imageUrl,
                                  userName: review.userName,
                                  rating: review.starCount,
                                  date: DateFormat('dd/MM/yyyy').format(review.createdAt),
                                  feedback: review.description,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return reviewsShimerBuilder();
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}

Shimmer reviewsShimerBuilder() {
  return Shimmer.fromColors(
                    baseColor: Colors.grey[300] ?? AppPalette.greyClr,
                    highlightColor: AppPalette.whiteClr,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('All Reviews (Loading...)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                           Icon(CupertinoIcons.clear)
                          ],
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: ratingReviewListWidget(
                                  context: context,
                                  imageUrl: AppImages.barberEmpty,
                                  userName: 'Reviewer Name',
                                  rating: 5,
                                  date: '22/01/2000',
                                  feedback: "We're currently gathering genuine reviews and honest ratings from our users to give you the best insights. These opinions come straight from people who’ve experienced it firsthand — their voices will help you make informed choices. ",
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
}
