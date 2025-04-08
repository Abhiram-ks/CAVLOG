import 'dart:math';
import 'package:barber_pannel/cavlog/auth/data/repositories/email_service.dart';
import 'package:barber_pannel/cavlog/auth/domain/repositories/otpVarification/otp_varification.dart';
import 'package:flutter/cupertino.dart';

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
      print('Otp generated : $otp                       xxxxxxxxxx');
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
