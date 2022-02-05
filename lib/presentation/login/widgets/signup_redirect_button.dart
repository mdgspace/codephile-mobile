part of 'login_widgets.dart';

class SignUpRedirectButton extends StatelessWidget {
  const SignUpRedirectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "Don't have an account? ",
            style: AppStyles.h6,
          ),
          TextSpan(
            text: 'Create one',
            style: AppStyles.h6.copyWith(color: AppColors.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.offNamed(AppRoutes.signUp),
          ),
        ],
      ),
    );
  }
}
