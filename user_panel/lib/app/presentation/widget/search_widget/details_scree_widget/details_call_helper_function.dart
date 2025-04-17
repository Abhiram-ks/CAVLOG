import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:user_panel/core/common/custom_snackbar_widget.dart';
import 'package:user_panel/core/themes/colors.dart';

class CallHelper {
  static Future<void> makeCall(String phoneNumber, BuildContext context) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (e) {
      if (!context.mounted) return;
       CustomeSnackBar.show(
        context: context,
         title: 'Unable to Connect', 
         description: 'We couldn’t make the call right now. Please try again in a moment.',
          titleClr: AppPalette.redClr);
    }
  }
}