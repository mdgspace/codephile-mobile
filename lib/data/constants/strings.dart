class AppStrings {
  // Storage
  static const String hiveBoxName = 'app_box';
  static const String authTokenKey = 'auth_token';
  static const String newUser = 'new_user';
  static const String userKey = 'user';
  static const String filterKey = 'filter';
  static const String recentSearchKey = 'recent_search';

  // Error
  static const String similarUserExists = 'This user already exists. '
      'Please choose different email or username.';
  static const String genericError = 'Something went wrong';
  static const String incorrectCredentials = 'Incorrect credentials';
  static const String duplicateEmail =
      'This email is already in use. Use another email or log in';
  static const String noUserWithEmail =
      'No user associated with given email address';
  static const String passwordResetSuccess =
      'Successful! Please check your email for a password reset link';
  static const String signUpSuccess =
      'You are almost done with the sign up process. '
      'Please check your email to verify this account';
  static const String duplicateUsername =
      'This username is already in use. Choose another username or log in';
  static const String verifyFirst =
      'Please verify your email before attempting to log in. '
      'Check your email for the verification link';
  static const String wrongFormValues =
      'Please fill all required values in the form correctly';

  // Misc.
  static const String emailValidationRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))'
      r'@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
      r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}
