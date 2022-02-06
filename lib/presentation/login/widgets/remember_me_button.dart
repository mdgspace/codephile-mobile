part of 'login_widgets.dart';

/// Checkbox and label component that allows the user to choose whether to stay
/// logged in for future sessions too. Defaults to on.
class RememberMeButton extends StatelessWidget {
  /// Checkbox and label component that allows the user to choose whether to stay
  /// logged in for future sessions too. Defaults to on.
  const RememberMeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, bool>(
      selector: (state) => state.rememberMe,
      builder: (context, rememberMe) {
        return TextButton(
          onPressed: () => _toggle(context),
          style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all<Color>(AppColors.transparent),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 18.r,
                height: 18.r,
                child: Checkbox(
                  value: rememberMe,
                  onChanged: (_) => _toggle(context),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    side: BorderSide(color: AppColors.grey2),
                  ),
                  activeColor: AppColors.primary,
                ),
              ),
              SizedBox(width: 8.r),
              Text(
                'Keep me signed in',
                style: AppStyles.h6,
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggle(BuildContext context) =>
      context.read<LoginBloc>().add(const ToggleRememberMe());
}
