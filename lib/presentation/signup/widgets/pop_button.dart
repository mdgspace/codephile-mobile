part of 'signup_widgets.dart';

/// The back button above the forms.
class PopButton extends StatelessWidget {
  /// The back button above the forms.
  const PopButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpBloc, SignUpState, int>(
      selector: (state) => state.pageIndex,
      builder: (context, pageIndex) {
        if (pageIndex == 0) {
          return Container();
        } else {
          return GestureDetector(
            onTap: () => context.read<SignUpBloc>().add(const Back()),
            child: svg.SvgPicture.asset(
              AppAssets.arrowBackward,
              width: 16.r,
            ),
          );
        }
      },
    );
  }
}
