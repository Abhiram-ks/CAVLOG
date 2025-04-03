import 'dart:developer';
import 'package:flutter/material.dart';

class OtpVarification {
  DateTime otpCreationTime = DateTime.now();
  final Duration otpValidity  = Duration(minutes: 2);


  Future<bool> verifyOTP({required String inputOtp,required String? otp}) async{
    try {   
      log('Verifying OTP: $inputOtp');
      log('genertaed OTP: $otp');
     if (inputOtp.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(inputOtp)){
         log('generated otp is $otp');
       debugPrint('Invalid OTP format: $inputOtp');
       return false;
      }

      if (DateTime.now().difference(otpCreationTime) > otpValidity){
          debugPrint('OTP expired.');
          return false;
        }
        
        return Future.delayed(Duration(seconds: 1), (){
          log('INPUT OTP: $inputOtp, GENERATE OTP: $otp');
          return inputOtp == otp;
        });

    }catch (e) {
      log('INPUT OTP: $inputOtp, GENERATE OTP: $otp');
      log('verifyOTP response: $e');
      return false;
    }
  }

}

