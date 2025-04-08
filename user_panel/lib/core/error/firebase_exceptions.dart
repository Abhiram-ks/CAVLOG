import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static List<String> handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return ['Login Failed', 'Email and Password does not match'];
      case 'user-not-found':
        return ['User Not Found', 'No user found with this email.'];
      case 'network-request-failed':
         return [
          'Network Error',
          'Network error. Please check your internet connection.'
         ];
      case 'wrong-password':
        return ['Wrong Password', 'Incorrect password. Please try again.'];
      case 'email-already-in-use':
        return [
          'Registration Failed',
          'This email is already in use by another account.'
        ];
      case 'invalid-email':
        return ['Invalid Email', 'The email address is invalid.'];
      case 'operation-not-allowed':
        return ['Unable to do this', 'This sign-in method is not enabled.'];
      case 'too-many-requests':
        return [
          'Try Again later',
          'Too many requests. Please try again later.'
        ];
      default:
        return ['Try Again', 'An unexpected error occurred.'];
    }
  }
}