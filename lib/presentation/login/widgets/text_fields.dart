part of 'login_widgets.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            TextFormField(
              initialValue: '',
              onChanged: (value) =>
                  context.read<LoginBloc>().add(PasswordInput(value)),
              minLines: 1,
              style: AppStyles.h6.copyWith(color: AppColors.grey3),
              obscureText: state.obscurePassword,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: AppStyles.h6,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.r,
                    vertical: 10.r,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.lock,
                    color: (state.isPasswordFocused)
                        ? AppColors.primary
                        : AppColors.grey1,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                (state.obscurePassword) ? AppAssets.eyeOn : AppAssets.eyeOff,
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

class UsernameField extends StatelessWidget {
  const UsernameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: '',
          onChanged: (value) =>
              context.read<LoginBloc>().add(UsernameInput(value)),
          minLines: 1,
          style: AppStyles.h6.copyWith(color: AppColors.grey3),
          decoration: InputDecoration(
            hintText: 'Username',
            hintStyle: AppStyles.h6,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.r,
                vertical: 10.r,
              ),
              child: SvgPicture.asset(
                AppAssets.person,
                color: state.isUsernameFocused
                    ? AppColors.primary
                    : AppColors.grey1,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        );
      },
    );
  }
}
