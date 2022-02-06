part of 'login_widgets.dart';

/// The login button.
class LoginButton extends StatelessWidget {
  /// The login button.
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // [BlocSelector] is not used because widget depends on both
    // [state.isFormFilled()] and [state.isLoginButtonActive()].
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              state.isFormFilled() ? AppColors.primary : AppColors.grey2,
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const ContinuousRectangleBorder(),
            ),
            side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
          ),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            if (state.isLoginButtonActive()) {
              context.read<LoginBloc>().add(const Submit());
            }
          },
          child: Container(
            alignment: Alignment.center,
            height: 48.r,
            child: state.status is Loading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    'LOGIN',
                    style: AppStyles.h6.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
