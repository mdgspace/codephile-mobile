part of 'signup_widgets.dart';

/// Function component of the "resend email" button. Used by [VerifyScreen].
Widget resendEmailButton(String userId) {
  return TextButton(
    onPressed: () => _resendEmail(userId),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.white),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        const ContinuousRectangleBorder(),
      ),
      side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(color: AppColors.primary),
      ),
    ),
    child: Container(
      alignment: Alignment.center,
      height: 48.r,
      padding: EdgeInsets.symmetric(horizontal: 30.r),
      child: Text(
        'Resend Email',
        style: AppStyles.h6.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

/// Requests the backend to send a new verification email.
Future<void> _resendEmail(String userId) async {
  final emailSent = await UserRepository.sendVerifyEmail(userId);
  if (emailSent) {
    showSnackBar(message: 'Verification email sent');
  } else {
    showSnackBar(message: AppStrings.genericError);
  }
}
