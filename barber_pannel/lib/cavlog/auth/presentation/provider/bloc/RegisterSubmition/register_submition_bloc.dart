import 'dart:developer';import 'package:barber_pannel/cavlog/auth/domain/repositories/otpSend/generate_otp_source.dart';
import 'package:barber_pannel/cavlog/auth/domain/repositories/otpVarification/otp_varification.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/datasources/authentication/auth_remote_data_source.dart';

part 'register_submition_event.dart';
part 'register_submition_state.dart';

class RegisterSubmitionBloc extends Bloc<RegisterSubmitionEvent, RegisterSubmitionState> {
  String _fullName = '';
  String _ventureName = '';
  String _phoneNumber = '';
  String _address = ''; 
  String _email = '';
  String _password = '';
  bool _isVerified = false;
  bool _isBlok = false;
  String? _otp = '';
  DateTime? _otpGeneratedTime;

  String get fullNme => _fullName;
  String get ventureName => _ventureName;
  String get phoneNumber => _phoneNumber;
  String get address => _address;
  String get email => _email;
  String get password => _password;
  bool get isVerified => _isVerified;
  bool get isBlok => _isBlok;
  String? get otp => _otp;

  RegisterSubmitionBloc() : super(RegisterSubmitionInitial()) {
    on<UpdatePersonalDetails>((event, emit){
     _fullName = event.fullName;
     _ventureName = event.ventureName;
     _phoneNumber = event.phoneNumber;
     _address = event.address;
     
    });

    on<UpdateCredentials>((event, emit) {
      _email = event.email;
      _password = event.password;
      _isVerified = event.isVerified;
      _isBlok = event.isBloc;
     log('Working well $_email $_password');
    });
    
    on<GenerateOTPEvent>((event, emit)async {
      if (_email.isEmpty) {
        emit(RegisterSubmitionInitial());
         await Future.delayed(Duration(milliseconds: 30));
        emit(OtpFailure(error: 'Email is Required to generate OTP'));
        return;
      }

      try {
         emit(OtpLoading());
         String? otpSend = await OtpService().sendOtpToEmail(_email);
         _otp = otpSend;
         _otpGeneratedTime = DateTime.now();

         if (otpSend != null) {
         emit(OtpSuccess());
         log('OTP sent successfully to $_email');
         await Future.delayed(Duration(seconds: 120));
         if (_otp != null) {
            emit(OtpExpired());
         }

        //  Future.delayed(Duration(seconds: 120), (){
        //   if (_otp!= null) {
        //     emit(OtpExpired());
        //   }
        //  });

        }else {
          emit(OtpFailure(error: "Failed to Sent OTP"));
        }
      } catch (e) {
        emit(OtpFailure(error: e.toString()));
      }
    });

    on<VerifyOTPEvent>((event, emit)async {
      if (_otp == null) {
        log('OTP Expired - Emitting OtpExpired State');
        emit(OtpExpired());
        return;
      }

     if (_otpGeneratedTime != null && DateTime.now().difference(_otpGeneratedTime!) > Duration(seconds: 120)) {
        _otp = null;
         log('OTP Expired - Emitting OtpExpired State111');
        emit(OtpExpired());
        return;
      }
      
      try {
       final OtpVarification otpVarification = OtpVarification();
       bool response = await otpVarification.verifyOTP(inputOtp: event.inputOtp.trim(),otp: _otp);

       if (response) {
        //  await Future.delayed(Duration(milliseconds: 50)); 
        emit(OtpVarifyed());
       }else{
         emit(OtpLoading()); 
         await Future.delayed(Duration(milliseconds: 50)); 
        log('OTP Incorrect - Emitting OtpIncorrect State');
        emit(OtpIncorrect(error: 'OTP Invalid'));
       }
      } catch (e) {
        log('OTP varification failed: $e');
         emit(OtpIncorrect(error: e.toString()));
      }
    });



     on<SubmitRegistration>((event, emit) async{
      try {
        bool response = await AuthRemoteDataSource().signUpBarber(barberName: _fullName, ventureName: _ventureName, phoneNumber: _phoneNumber, address: _address, email: _email, password: _password, isVerified: _isVerified, isblok: _isBlok);
        log('Working well $_fullName  $_email');
        if (response) {
          emit(RegisterSuccess());
        }else {
          emit(RegisterFailure(error: 'Registration Failed'));
        }
      } catch (e) {
        emit(RegisterFailure(error: e.toString()));
      }
    });
  }
}






