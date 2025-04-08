import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:user_panel/auth/data/datasources/auth_remote_datasource.dart';
import 'package:user_panel/auth/domain/repositories/otp_repo/generate_otpsource.dart';
import 'package:user_panel/auth/domain/repositories/otp_repo/varifiy_otpgenerate.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  String _fullName = '';
  String _phoneNumber = '';
  String _address = ''; 
  String _email = '';
  String _password = '';
  String? _otp = '';
  DateTime? __otpGeneratedTime;

  String get fullName => _fullName;
  String get phoneNumber => _phoneNumber;
  String get address => _address;
  String get email => _email;
  String get password => _password;
  String? get otp => _otp;

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterPersonalData>((event, emit) {
      _fullName = event.fullName;
      _phoneNumber = event.phoneNumber;
      _address = event.address;
    });

    on<RegisterCredentialsData>((event, emit) {
      _email = event.email;
      _password = event.password;
    });

    on<GenerateOTPEvent>((event, emit) async {
      if (_email.isEmpty) {
        emit(RegisterInitial());
        await Future.delayed(Duration(milliseconds: 30));
        emit(OtpFailure('Email is Required to generate OTP'));
        return;
      }
       
      try {
        emit(OtpLoading());
        String? otpSend = await OtpService().sendOtpToEmail(_email);
        _otp = otpSend;
        __otpGeneratedTime = DateTime.now();

        if (otpSend != null) {
         emit(OtpSuccess());
         await Future.delayed(Duration(seconds: 120));
         if (_otp != null) {
            emit(OtpExpired());
         }
        }else{
          emit(OtpFailure('Failed to Sent OTP'));
        }
      } catch (e) {
        emit(OtpFailure('Error: $e'));
      }
    });

    on<VerifyOTPEvent>((event, emit)async {
      if (_otp == null) {
        emit(OtpExpired());
        return;
      }

      if (__otpGeneratedTime != null && DateTime.now().difference(__otpGeneratedTime!) > Duration(seconds: 120)) {
        _otp = null;
        emit(OtpExpired());
        return;
      }

      try {
        final OtpVarification otpVarification = OtpVarification();
        bool response = await otpVarification.verifyOTP(inputOtp: event.inputOtp.trim(), otp: _otp);
    
        if (response) {
          emit(OtpVarifyed());
        }else{
          emit(OtpLoading());
          await Future.delayed(Duration(microseconds: 120));
          emit(OtpIncorrect('OTP invalid'));
        }
      } catch (e) {
        emit(OtpIncorrect('OTP varification failed: $e'));
      }
    });

    on<RegisterSubmit>((event, emit)async {
      try {
        log('Registraction message: $_fullName, $_phoneNumber, $_address, $_email, $_password');
        bool response = await AuthRemoteDataSource().signUpUser(userName: _fullName, phoneNumber: _phoneNumber, address: _address, email: _email, password: _password);
        log('Working well $fullName  $email');
        if (response) {
          emit(RegisterSuccess());
        }else{
          emit(RegisterFailure('Registration Failed'));
        }
      } catch (e) {
        emit(RegisterFailure('Registration Failed: $e'));
      }
    });
  }
}
