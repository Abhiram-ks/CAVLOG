import 'package:barber_pannel/core/common/custom_app_bar.dart';
import 'package:barber_pannel/core/themes/colors.dart';
import 'package:barber_pannel/core/utils/media_quary/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/common/lottie_widget.dart';
import '../../../../../core/common/snackbar_helper.dart';
import '../../../../../core/utils/image/app_images.dart';

class BlockedScreen extends StatelessWidget {
  const BlockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;
        return Scaffold(
         appBar: const CustomAppBar(),
         body: SafeArea(child: 
         SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
          child: Padding(
             padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
            ),
            child: BlockedAcWidget(screenHeight: screenHeight, screenWidth: screenWidth,),),
         )),
        );
      }
    );
  }
}

class BlockedAcWidget extends StatelessWidget {
  const BlockedAcWidget({
    
    super.key, required this.screenHeight, required this.screenWidth,
  });
  final double screenHeight;
  final double screenWidth;

  final String _email =  "cavlogenoia@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
           'Account Temporarily Suspended',
          style: GoogleFonts.plusJakartaSans(
              fontSize: 28, fontWeight: FontWeight.bold,),
        ),
        ConstantWidgets.hight10(context),
         Text( 'Due to unauthorized activity detected, your account has been temporarily suspended. For further assistance.'),
          LottiefilesCommon(assetPath: LottieImages.adminRequstW8Image, width: screenWidth*0.5, height: screenHeight*0.5),
          ConstantWidgets.hight50(context),
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