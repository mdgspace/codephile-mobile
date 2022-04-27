part of 'signup_widgets.dart';

/// Wrapper that listens to the [SignUpBloc] provided and reacts with snackbars.
class SnackBarWrapper extends StatelessWidget {
  /// Wrapper that listens to the [SignUpBloc] provided and reacts with snackbars.
  const SnackBarWrapper({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) async {
        // Errors
        if (state.status is Error) {
          final message = (state.status as Error).errorMessage;
          if (message == AppStrings.similarUserExists) {
            showSnackBar(
              message: message,
              actionTitle: 'Log in instead',
              action: () => Get.offAllNamed(AppRoutes.login),
            );
          } else if (message.isNotEmpty) {
            showSnackBar(message: message);
          }
        }
        // Success
        else if (state.status is Idle) {
          final message = (state.status as Idle).message;
          if (message == AppStrings.signUpSuccess) {
            await showSnackBar(message: message!);
            Get.offAllNamed(AppRoutes.login);
          }
        }
      },
      listenWhen: (previousState, currentState) =>
          previousState.status != currentState.status,
      child: child,
    );
  }
}
