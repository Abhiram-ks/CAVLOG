
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user_panel/app/presentation/widget/search_widget/rating_review_widget/reviews_builder_bottomsheet.dart';
import '../../../../../core/common/custom_actionbutton_widget.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../../data/models/barber_model.dart' show BarberModel;
import '../../profile_widget/profile_scrollable_section.dart';
import 'reviews_upload_bottomsheet.dart';

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
                  Text('Ratings & Reviews',style: TextStyle(fontWeight: FontWeight.bold),
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
                  onPressed: () {showReviewDetisSheet(context, screenHight, screenWidth, barber.uid);
                  },icon: Icon(Icons.arrow_forward_ios_rounded))
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
              showReviewBottomSheet(context, barber, screenHight, screenWidth);
            },
            buttonColor: AppPalette.greyClr,
          ),
          ConstantWidgets.hight10(context),
          Text( 'Ratings and reiews are varified and are from people who use the same type of device that you use ⓘ',
          )
        ],
      ),
    );
  }

 
}
