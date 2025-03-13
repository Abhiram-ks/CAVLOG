import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/datasources/auth/auth_remote_data_source.dart';

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

  String get fullNme => _fullName;
  String get ventureName => _ventureName;
  String get phoneNumber => _phoneNumber;
  String get address => _address;
  String get email => _email;
  String get password => _password;
  bool get isVerified => _isVerified;
  bool get isBlok => _isBlok;

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
