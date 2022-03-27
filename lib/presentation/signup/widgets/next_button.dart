part of 'signup_widgets.dart';

/// The primary button below the forms.
class NextButton extends StatelessWidget {
  /// The primary button below the forms.
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              _backgroundColor(state),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const ContinuousRectangleBorder(),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              _borderSide(state),
            ),
          ),
          onPressed: () => _onPressed(context, state),
          child: Container(
            alignment: Alignment.center,
            height: 48.r,
            child: state.status is Loading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: CircularProgressIndicator(
                      color: _foregroundColor(state),
                    ),
                  )
                : Text(
                    _text(state),
                    style: AppStyles.h6.copyWith(
                      color: _foregroundColor(state),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Color _backgroundColor(SignUpState state) {
    switch (state.primaryButtonStatus()) {
      case PrimaryButtonStatus.next:
        return AppColors.primary;
      case PrimaryButtonStatus.skip:
        return AppColors.white;
      case PrimaryButtonStatus.disabled:
        return AppColors.grey2;
    }
  }

  BorderSide _borderSide(SignUpState state) {
    switch (state.primaryButtonStatus()) {
      case PrimaryButtonStatus.skip:
        return const BorderSide(color: AppColors.primary);
      case PrimaryButtonStatus.disabled:
      case PrimaryButtonStatus.next:
        return BorderSide.none;
    }
  }

  Color _foregroundColor(SignUpState state) {
    switch (state.primaryButtonStatus()) {
      case PrimaryButtonStatus.skip:
        return AppColors.primary;
      case PrimaryButtonStatus.disabled:
      case PrimaryButtonStatus.next:
        return AppColors.white;
    }
  }

  void _onPressed(BuildContext context, SignUpState state) {
    FocusScope.of(context).requestFocus(FocusNode());
    switch (state.primaryButtonStatus()) {
      case PrimaryButtonStatus.disabled:
        return;
      case PrimaryButtonStatus.next:
      case PrimaryButtonStatus.skip:
        context.read<SignUpBloc>().add(const Next());
    }
  }

  String _text(SignUpState state) {
    switch (state.primaryButtonStatus()) {
      case PrimaryButtonStatus.skip:
        return 'SKIP';
      case PrimaryButtonStatus.disabled:
      case PrimaryButtonStatus.next:
        return (state.pageIndex == pages.length - 1) ? 'SUBMIT' : 'NEXT';
    }
  }
}
