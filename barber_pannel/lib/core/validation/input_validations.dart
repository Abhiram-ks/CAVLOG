import 'package:cloud_firestore/cloud_firestore.dart';

class ValidatorHelper {
  static final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@gmail\.com$');

  static String? validateEmailId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid Gmail address';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter amount';
    }

    final pattern = RegExp(r'^(0|[1-9]\d*)(\.\d{2})?$');

    if (!pattern.hasMatch(value)) {
      return 'Enter a valid amount (e.g. 10.00), only 2 digits after dot';
    }

    return null;
  }

  static Future<String?> validateEmailWithFirebase(String email) async {
    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid Gmail address';
    }

    try {
      final futures = [
        FirebaseFirestore.instance
            .collection('barbers')
            .where('email', isEqualTo: email)
            .get(),
        FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get(),
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

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'enter valid phone number';
    }
    return null;
  }

  static String? validateName(String? name) {
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

  static String? validatePasswordMatch(
      String? password, String? confirmPassword) {
    if (password == null || password.isEmpty) {
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

  static String? validateYear(String? year) {
    if (year == null || year.isEmpty) {
      return 'Enter your Answer';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(year)) {
      return '$year Invalid Enter.';
    }

    int yearValue  = int.parse(year);
    int currentYear = DateTime.now().year;

    if (yearValue < 1900 || yearValue > currentYear ) {
     return 'Invalid Year! Please enter a valid year between 1900 and $currentYear.';
    }

    return null;
  }

  static String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return 'Plase fill the field';
    } else {
      if (text.startsWith(' ')) {
        return "Cannot start with a space.";
      }

      if (!RegExp(r'^[A-Z]').hasMatch(text)) {
        return "The first letter must be uppercase.";
      }
    }
    return null;
  }

  static String? loginValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'please enter your password';
    } else if (password.length > 15) {
      return 'Oops! That password doesn’t look right.';
    }
    return null;
  }
}
