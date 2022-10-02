part of 'change_password.dart';

class CurrentPasswordField extends StatelessWidget {
  const CurrentPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UpdateProfileBloc, UpdateProfileState, bool>(
      selector: (state) => state.passwordFieldObscureState[0],
      builder: (context, obscure) {
        return TextInput(
          hint: 'Current Password',
          validator: (val) {
            if (val?.isEmpty ?? true) {
              return 'Required Field';
            }

            return null;
          },
          onChanged: (val) {},
          controller: UpdateProfileBloc.controllers['old_pass'],
          obscureText: obscure,
          prefix: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.r,
              vertical: 10.r,
            ),
            child: const ImageIcon(Svg(AppAssets.lock)),
          ),
          suffix: IconButton(
            onPressed: () {
              context
                  .read<UpdateProfileBloc>()
                  .add(const ToggleObscure(index: 0));
            },
            icon: ImageIcon(
              Svg(obscure ? AppAssets.eyeOff : AppAssets.eyeOn),
            ),
          ),
        );
      },
    );
  }
}

class NewPasswordField extends StatelessWidget {
  const NewPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UpdateProfileBloc, UpdateProfileState, bool>(
      selector: (state) => state.passwordFieldObscureState[1],
      builder: (context, obscure) {
        return TextInput(
          hint: 'New Password',
          validator: (val) {
            if (val?.isEmpty ?? true) {
              return 'Required Field';
            }

            return null;
          },
          onChanged: (val) {},
          controller: UpdateProfileBloc.controllers['new_pass'],
          obscureText: obscure,
          prefix: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.r,
              vertical: 10.r,
            ),
            child: const ImageIcon(
              Svg(AppAssets.lockFilled),
            ),
          ),
          suffix: IconButton(
            onPressed: () {
              context
                  .read<UpdateProfileBloc>()
                  .add(const ToggleObscure(index: 1));
            },
            icon: ImageIcon(
              Svg(obscure ? AppAssets.eyeOff : AppAssets.eyeOn),
            ),
          ),
        );
      },
    );
  }
}

class ReEnterPasswordField extends StatelessWidget {
  const ReEnterPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UpdateProfileBloc, UpdateProfileState, bool>(
      selector: (state) => state.passwordFieldObscureState[2],
      builder: (context, obscure) {
        return TextInput(
          hint: 'Re-enter Password',
          action: TextInputAction.done,
          validator: (val) {
            if (val?.isEmpty ?? true) {
              return 'Required Field';
            }
            // Re-enter field
            if (val != UpdateProfileBloc.controllers['new_pass']?.text) {
              return "It doesn't matches with new password";
            }
            return null;
          },
          controller: UpdateProfileBloc.controllers['re_enter'],
          obscureText: obscure,
          prefix: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.r,
              vertical: 10.r,
            ),
            child: const ImageIcon(
              Svg(AppAssets.lockFilled),
            ),
          ),
          suffix: IconButton(
            onPressed: () {
              context
                  .read<UpdateProfileBloc>()
                  .add(const ToggleObscure(index: 2));
            },
            icon: ImageIcon(
              Svg(obscure ? AppAssets.eyeOff : AppAssets.eyeOn),
            ),
          ),
        );
      },
    );
  }
}
