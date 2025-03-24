class ValidatorHelper {
  static final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@gmail\.com$');

  static String? validateEmailId(String? email){
    if(email == null || email.isEmpty){
       return 'Please enter your email';
    }else if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid Gmail address';
    }
    return null;
  }
  
  static String? validatePassword(String? password){
    if(password == null || password.isEmpty){
      return 'please enter your password';
    }else if(password.length > 15){
      return 'Oops! That password doesn’t look right.';
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
}