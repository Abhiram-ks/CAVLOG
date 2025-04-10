import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/common/custom_imageshow_widget.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../../../core/utils/image/app_images.dart';
import '../../profile_widget/profile_scrollable_section.dart';

class ListForBarbers extends StatelessWidget {
  const ListForBarbers({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.imageURl,
    required this.shopName,
    required this.shopAddress,
    required this.rating,
    required this.ontap,
  });

  final double screenHeight;
  final double screenWidth;
  final String imageURl;
  final String shopName;
  final String shopAddress;
  final String rating;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: SizedBox(
        height: screenHeight * 0.12,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: (imageURl.startsWith('http'))
                    ? imageshow(
                        imageUrl: imageURl, imageAsset: AppImages.barberEmpty)
                    : Image.asset(
                        AppImages.barberEmpty,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
              ),
            ),
            SizedBox(width: screenWidth * .015),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        shopName,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      ConstantWidgets.hight10(context),
                      profileviewWidget(
                        screenWidth,
                        context,
                        Icons.location_on,
                        shopAddress,
                        AppPalette.greyClr,
                        maxline: 1,
                        textColor: AppPalette.greyClr,
                      ),
                      profileviewWidget(
                        screenWidth,
                        context,
                        Icons.star_half_sharp,
                        rating,
                        AppPalette.buttonClr,
                        maxline: 1,
                        textColor: AppPalette.greyClr,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 5,
                    right: 20,
                    child: Text(
                      "Open",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppPalette.greenClr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}