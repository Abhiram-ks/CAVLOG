  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user_panel/app/presentation/widget/search_widget/rating_review_widget/handle_ratereview_state.dart';

import '../../../../../core/common/custom_actionbutton_widget.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../../data/models/barber_model.dart';
import '../../../provider/bloc/rating_review_bloc/rating_review_bloc.dart';

void showReviewBottomSheet(BuildContext context, BarberModel barber, double screenHeight, double screenWidth) {
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
              Text( 'Help others by sharing your honest experience. Your review will be visible to the shop.',
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
                  screenHeight: screenHeight,
                ),
              ),
            ],
          ),
        );
      },
    );
  }