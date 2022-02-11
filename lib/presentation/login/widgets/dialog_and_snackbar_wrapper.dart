part of 'login_widgets.dart';

/// Wrapper that listens to the [LoginBloc] provided and reacts with dialogs and snackbars.
class DialogAndSnackBarWrapper extends StatelessWidget {
  /// Wrapper that listens to the [LoginBloc] provided and reacts with dialogs and snackbars.
  const DialogAndSnackBarWrapper({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // Dialog
        if (state.showDialog) {
          showForgotPasswordDialog(context);
        }

        // SnackBar
        if (state.status is Error) {
          final message = (state.status as Error).errorMessage;
          if (message.isNotEmpty) {
            showSnackBar(message: message);
          }
        } else if (state.status is Idle) {
          final message = (state.status as Idle).message;
          if (message != null && message.isNotEmpty) {
            showSnackBar(message: message);
          }
        }
      },
      listenWhen: (state, previousState) =>
          (state.showDialog != previousState.showDialog) ||
          (state.status != previousState.status),
      child: child,
    );
  }
}
