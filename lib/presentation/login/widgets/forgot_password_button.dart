part of 'login_widgets.dart';

/// Button component that opens a dialog using [showForgotPasswordDialog].
class ForgotPasswordButton extends StatelessWidget {
  /// Button component that opens a dialog using [showForgotPasswordDialog].
  const ForgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Forgot Password?',
        style: AppStyles.h6.copyWith(color: AppColors.primary),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            FocusScope.of(context).requestFocus();
            context.read<LoginBloc>().add(const ToggleDialog());
          },
      ),
      // textAlign: TextAlign.right,
    );
  }
}

/// Dialog component that takes an email id to send a reset password link to.
void showForgotPasswordDialog(BuildContext context) async {
  final controller = TextEditingController();

  final result = await showDialog<String?>(
    context: context,
    builder: (context) => AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 15.r),
        decoration: const BoxDecoration(
          color: Color(0xFFF3F4F7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: const Text(
          'Forgot Password',
          textAlign: TextAlign.center,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: EdgeInsets.fromLTRB(15.r, 15.r, 15.r, 0),
        child: TextInput(
          controller: controller,
          hint: 'Email',
          keyboard: TextInputType.emailAddress,
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.only(right: 10.r),
            ),
          ),
          onPressed: () => Get.back(result: controller.text),
          child: Container(
            color: AppColors.primary,
            padding: EdgeInsets.symmetric(horizontal: 40.r, vertical: 10.r),
            child: Text(
              'Okay',
              style: AppStyles.h6.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ],
    ),
  );

  // ignore:use_build_context_synchronously
  context.read<LoginBloc>().add(ToggleDialog(email: result));
}
