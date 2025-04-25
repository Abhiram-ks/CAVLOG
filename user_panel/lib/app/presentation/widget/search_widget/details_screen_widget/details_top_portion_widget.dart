import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_panel/app/data/models/barber_model.dart';
import 'package:user_panel/app/presentation/widget/search_widget/details_screen_widget/details_call_helper_function.dart';
import 'package:user_panel/app/presentation/widget/search_widget/details_screen_widget/details_screen_actionbuttos.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../profile_widget/profile_scrollable_section.dart';


class DetailTopPortionWidget extends StatelessWidget {
  const DetailTopPortionWidget({
    super.key,
    required this.screenWidth,
    required this.barber,
  });

  final double screenWidth;
  final BarberModel barber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ConstantWidgets.hight20(context),
          Text(
            barber.ventureName,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          ConstantWidgets.hight10(context),
          profileviewWidget(
            screenWidth,
            context,
            Icons.location_on,
            barber.address,
            AppPalette.greyClr,
            maxline: 2,
            widget: double.infinity,
            textColor: AppPalette.greyClr,
          ),
          ConstantWidgets.hight10(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              profileviewWidget(
                screenWidth,
                context,
                Icons.star,
                '${barber.rating?.toStringAsFixed(1) ?? '0.0'} (Customer Reviews)',
                AppPalette.buttonClr,
                maxline: 1,
                textColor: AppPalette.greyClr,
              ),
              Text(
                () {
                  final gender = barber.gender?.toLowerCase();
                  if(gender == 'male') return 'Male';
                  if(gender == 'female') return 'Female';
                  return 'Unisex';
                } (),
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: (() {
                      final gender = barber.gender?.toLowerCase();
                      if (gender == 'male') return AppPalette.blueClr;
                      if (gender == 'female') return Colors.pink;
                      return AppPalette.orengeClr;
                    })(),
                    ),
              ),
              Text(
                "Open",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppPalette.greenClr,
                ),
              ),
            ],
          ),
          ConstantWidgets.hight20(context),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                detailsPageActions(
                    context: context,
                    screenWidth: screenWidth,
                    icon: CupertinoIcons.chat_bubble_2_fill,
                    onTap: () {},
                    text: 'Message'),
                detailsPageActions(
                    context: context,
                    screenWidth: screenWidth,
                    icon: Icons.phone_in_talk_rounded,
                    onTap: () {
                      CallHelper.makeCall(barber.phoneNumber, context);
                    },
                    text: 'Call'),
                detailsPageActions(
                    context: context,
                    screenWidth: screenWidth,
                    icon: Icons.location_on_sharp,
                    onTap: () {},
                    text: 'Direction'),
                detailsPageActions(
                    context: context,
                    screenWidth: screenWidth,
                    icon: CupertinoIcons.heart_fill,
                    onTap: () {},
                    text: 'Favorite'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


