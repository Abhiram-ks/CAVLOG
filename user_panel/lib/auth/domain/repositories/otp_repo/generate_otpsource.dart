import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:user_panel/auth/domain/repositories/otp_repo/varifiy_otpgenerate.dart';

import '../../../data/repositories/otpemail_service_repo.dart';

class OtpService {
  final EmailService _emailService = EmailService();
  final OtpVarification otpVarification = OtpVarification();
  Future<String> _generateOTP() async {
    var rng = Random();
    return (rng.nextInt(900000) + 100000).toString();
  }

  Future<String?> sendOtpToEmail(String email) async {
    try {
      String otp = await _generateOTP();
      print('Generated OTP: ********** $otp *************');
      bool emailSent = await _emailService.sendOTPEmail(email, otp);
      if (emailSent) {
        return otp;
      }else {
        return null;
      }
    } catch (e) {
      debugPrint('Error sending otp $e');
      return null;
    }
  }
}
