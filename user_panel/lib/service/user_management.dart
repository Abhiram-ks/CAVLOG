import 'package:user_panel/auth/data/models/user_model.dart';

class UserManagement {
  static final UserManagement _instance = UserManagement._internal();
  
  UserModel? _currentUser;

  factory UserManagement(){
    return _instance;
  }

  UserManagement._internal();

  UserModel? get currentUser => _currentUser;

  void setUser(UserModel user){
    _currentUser = user;
  }

  void clearUser(){
    _currentUser = null;
  }

}