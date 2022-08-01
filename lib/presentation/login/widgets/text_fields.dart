part of 'login_widgets.dart';

/// The password text field.
class PasswordField extends StatelessWidget {
  /// The password text field.
  const PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, bool>(
      selector: (state) => state.obscurePassword,
      builder: (context, obscurePassword) {
        return TextInput(
          action: TextInputAction.done,
          hint: 'Password',
          keyboard: TextInputType.visiblePassword,
          obscureText: obscurePassword,
          onChanged: (value) =>
              context.read<LoginBloc>().add(PasswordInput(value)),
          prefix: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.r,
              vertical: 10.r,
            ),
            // TODO(BURG3R5): Deal with Focus transfer.
            child: const ImageIcon(
              Svg(AppAssets.lock),
            ),
          ),
          suffix: IconButton(
            icon: ImageIcon(
              Svg(
                obscurePassword ? AppAssets.eyeOff : AppAssets.eyeOn,
              ),
            ),
            onPressed: () =>
                context.read<LoginBloc>().add(const ToggleObscure()),
          ),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        );
      },
    );
  }
}

/// The username text field.
class UsernameField extends StatelessWidget {
  /// The username text field.
  const UsernameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextInput(
      hint: 'Username',
      onChanged: (value) => context.read<LoginBloc>().add(UsernameInput(value)),
      prefix: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.r,
          vertical: 10.r,
        ),
        child: const ImageIcon(
          Svg(AppAssets.person),
        ),
      ),
    );
  }
}
