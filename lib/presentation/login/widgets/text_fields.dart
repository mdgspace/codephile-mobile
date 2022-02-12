part of 'login_widgets.dart';

/// The password text field.
class PasswordField extends StatelessWidget {
  /// The password text field.
  const PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // [BlocSelector] is not used because widget depends on both
    // [state.isPasswordFocused] and [state.obscurePassword].
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            TextInput(
              action: TextInputAction.done,
              hint: 'Password',
              keyboard: TextInputType.visiblePassword,
              obscureText: state.obscurePassword,
              onChanged: (value) =>
                  context.read<LoginBloc>().add(PasswordInput(value)),
              prefix: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.r,
                  vertical: 10.r,
                ),
                child: SvgPicture.asset(
                  AppAssets.lock,
                  // TODO(BURG3R5): Deal with Focus transfer.
                  color: (state.isPasswordFocused)
                      ? AppColors.primary
                      : AppColors.grey1,
                ),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                (state.obscurePassword) ? AppAssets.eyeOff : AppAssets.eyeOn,
                color: state.isPasswordFocused
                    ? AppColors.primary
                    : AppColors.grey1,
              ),
              onPressed: () =>
                  context.read<LoginBloc>().add(const ToggleObscure()),
            ),
          ],
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
    return BlocSelector<LoginBloc, LoginState, bool>(
      selector: (state) => state.isUsernameFocused,
      builder: (context, isUsernameFocused) {
        return TextInput(
          hint: 'Username',
          onChanged: (value) =>
              context.read<LoginBloc>().add(UsernameInput(value)),
          prefix: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.r,
              vertical: 10.r,
            ),
            child: SvgPicture.asset(
              AppAssets.person,
              color: isUsernameFocused ? AppColors.primary : AppColors.grey1,
            ),
          ),
        );
      },
    );
  }
}
