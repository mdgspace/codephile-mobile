part of 'signup_widgets.dart';

/// Function component of the login button. Used by [VerifyScreen].
Widget loginButton(String username, String password, File? profilePicture) {
  return TextButton(
    onPressed: () => _loginAndUpdateProfilePic(
      username,
      password,
      profilePicture,
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        const ContinuousRectangleBorder(),
      ),
      side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
    ),
    child: Container(
      alignment: Alignment.center,
      height: 48.r,
      padding: EdgeInsets.symmetric(horizontal: 40.r),
      child: Text(
        'Login',
        style: AppStyles.h6.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

/// Logs in the user and uploads the selected profile picture to the user's profile.
Future<void> _loginAndUpdateProfilePic(
  String username,
  String password,
  File? profilePicture,
) async {
  final result = await UserRepository.login(
    username: username,
    password: password,
    rememberMe: true,
  );
  if (result == null) {
    showSnackBar(message: AppStrings.genericError);
  } else if (result == 'Unverified') {
    showSnackBar(message: AppStrings.verifyFirst);
  } else {
    if (profilePicture != null) {
      await UserRepository.uploadProfilePicture(profilePicture);
    }
    Get.offAllNamed(AppRoutes.home);
  }
}
