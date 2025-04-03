import 'package:cloud_firestore/cloud_firestore.dart';

class ValidatorHelper {
  static final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@gmail\.com$');

  static String? validateEmailId(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid Gmail address';
    }
    return null;
  }

  static Future<String?> validateEmailWithFirebase(String email) async{
      if(!emailRegex.hasMatch(email)){
        return 'Enter a valid Gmail address';
      }
     
      try {
       final futures = [
      FirebaseFirestore.instance.collection('barbers').where('email', isEqualTo: email).get(),
      FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get(),
     ];

     final result = await Future.wait(futures);
     if (result[0].docs.isNotEmpty || result[1].docs.isNotEmpty) {
        return 'Email already exists';
     }
     return null;
    } catch (e) {
         return 'Error checking email: $e';
     }
  }
  
  static String? validatePhoneNumber(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return 'enter valid phone number';
  }
  return null;
  }


  static String? validateName(String? name){
      if (name == null || name.isEmpty) {
      return 'Please fill the field';
    }
    if (name.startsWith(' ')) {
      return "Name cannot start with a space.";
    }

    if (!RegExp(r'[A-Za-z]').hasMatch(name)) {
      return 'Invalid Name please try.';
    }

    if (!RegExp(r'^[A-Z]').hasMatch(name)) {
      return 'The first letter must be Uppercase.';
    }

    if (name.length < 3) {
      return "Name must be at least 3 characters long";
    }

   return null;
  }

  static String? validatePassword(String? password) {
    
   if (password == null || password.isEmpty) {
      return 'Please fill the field';
   }

    if (password.length < 6 || password.length > 15) {
      return 'Password must be between 6 and 15 range.';
    }

    if (password.contains(' ')) {
      return 'Spaces are not allowed in the password.';
    }

    if (!RegExp(r'^[A-Z]').hasMatch(password)) {
      return 'The first letter must be uppercase.';
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static String? validatePasswordMatch(String? password, String? confirmPassword) {
   if (password == null  || password.isEmpty) {
      return 'Create a new Password';
   }
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please fill the field';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }

  static String? validateAge(String? age) {
    if (age == null || age.isEmpty) {
      return 'Enter your Answer';
    }
    if (!RegExp(r'^\d+$').hasMatch(age)) {
      return 'Age must contain only numbers.';
    }

    int ageValue = int.parse(age);

    if (ageValue < 18) {
      return 'Age must be at least 18.';
    }
    if (ageValue > 149) {
      return 'Age must not exceed 149.';
    }

    return null;
  }


  static String? validateText(String? text){
    if (text == null || text.isEmpty) {
      return 'Plase fill the field';
    }else{
       if(text.startsWith(' ')){
       return "Cannot start with a space.";
    }

    if (!RegExp(r'^[A-Z]').hasMatch(text)){
      return "The first letter must be uppercase.";
    }
    }
    return null;
  }

  static String? validateLocation(String? text){
    if (text == null || text.isEmpty) {
      return 'Plase fill the field';
    }else{
       if(text.startsWith(' ')){
       return "Cannot start with a space.";
     }
    }
    return null;
  }

  static String? loginValidation(String? password){
    if(password == null || password.isEmpty){
      return 'please enter your password';
    }else if (password.length > 15){
        return 'Oops! That password doesn’t look right.';
    }
    return null;
  }
}
