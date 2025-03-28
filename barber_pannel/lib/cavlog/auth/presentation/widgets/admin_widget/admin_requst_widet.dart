
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/common/lottie_widget.dart';
import '../../../../../core/common/snackbar_helper.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/image/app_images.dart';

class AdminRequestWidget extends StatelessWidget {
  const AdminRequestWidget({
    super.key,
    required this.screenWidth,
    required this.screenHight,
  });

  final double screenWidth;
  final double screenHight;

  final String _email =  "cavlogenoia@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Verification Process.',
          style: GoogleFonts.plusJakartaSans(
              fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          'Your request for admin verification has been received. Our team will review your submission and send you a confirmation email once the verification process is complete. The verification process typically takes 24 to 72 hours. Please ensure you respond to any follow-up requests from our team. \nThank you',
        ),
        LottiefilesCommon(assetPath: LottieImages.adminRequstW8Image, width: screenWidth*0.5, height: screenHight*0.5),
        Text(
          'Contact Us:',
          style: GoogleFonts.plusJakartaSans(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: ()async {
            final Uri emialUri = Uri(
              scheme: 'mailto',
              path: _email,
              query: 'subject=${Uri.encodeComponent("Need Help")}&body=${Uri.encodeComponent("Hello Team Cavalog,\n\nI need help with...")}',
            );
            try {
              await launchUrl(emialUri);
            } catch (e) {
                CustomeSnackBar.show(context: context, title: 'Email not open', description: "Unable to open the email app at this time. Try opening your email manually. Error: $e", iconColor: AppPalette.redClr, icon: Icons.email_rounded);
            }
          },
          
           child: Text(
           _email,
            style: TextStyle(
              color: AppPalette.blueClr,
            ),
           ),
        ),
           Text(
          "With appreciation, Team Cavalog",
          style: GoogleFonts.plusJakartaSans(
              fontSize: 14, fontWeight: FontWeight.w100,color: AppPalette.greyClr),
        ),
      ],
    );
  }
}
