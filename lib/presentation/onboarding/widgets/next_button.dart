part of 'onboarding_widgets.dart';

/// Button component that takes user to the next page/screen.
class NextButton extends StatelessWidget {
  /// Button component that takes user to the next page/screen.
  const NextButton({required this.nextPage, Key? key}) : super(key: key);

  /// Callback to control the [Swiper] widget.
  final Function({bool animation}) nextPage;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.white,
      onPressed: () {
        if (pageIndex == pages.length - 1) {
          Get.offNamed(AppRoutes.home);
        } else {
          pageIndex = (pageIndex + 1) % pages.length;
          nextPage();
        }
      },
      child: SvgPicture.asset(
        AppAssets.arrowForward,
        width: 17.r,
      ),
    );
  }
}
