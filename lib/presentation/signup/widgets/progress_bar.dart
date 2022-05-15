part of 'signup_widgets.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpBloc, SignUpState, int>(
      selector: (state) => state.pageIndex,
      builder: (context, pageIndex) {
        return SizedBox(
          width: 1.sw - 32.r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(
              signUpPages.length,
              (index) {
                return Container(
                  height: 8.r,
                  width: 80.r,
                  padding: EdgeInsets.all(2.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.r),
                    color: index <= pageIndex
                        ? AppColors.primary
                        : AppColors.primaryAccent,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
