import 'package:admin/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/media_quary/constant/constant.dart';

class AlertBoxHelper {
  void showAlertDialog({
   required BuildContext context,
   required String title,
   required String description,
   required String firstButtonText,
   required VoidCallback firstButtonAction,
   required Color firstButtonColor,
   required String secoundButtonText,
   required VoidCallback secoundButtonAction,
   required Color secoundButtonColor,
  }
    ) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 2,
          
          backgroundColor: AppPalette.whiteClr,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.only(left: 6.0, right: 6),
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 21,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              ConstantWidgets.hight10(context),
              SizedBox(
                  width: double.infinity,
                  child: Divider(
                      color: const Color.fromARGB(255, 220, 220, 220),
                      thickness: 1)),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 20)),
                  minimumSize: WidgetStateProperty.all(Size.zero),
                ),
                onPressed: firstButtonAction,
                child: Text(
                  firstButtonText,
                    style: GoogleFonts.inter(
                        fontSize: 17,
                        color:firstButtonColor,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                  width: double.infinity,
                  child: Divider(
                      color: const Color.fromARGB(255, 220, 220, 220),
                      thickness: 1)),
                      TextButton(
                    onPressed: secoundButtonAction,
                    child: Text(secoundButtonText,
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            color: secoundButtonColor,
                            fontWeight: FontWeight.w500)),
                  ),
            ],
          ),
        );
      },
    );
  }
}
