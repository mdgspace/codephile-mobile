part of 'onboarding_widgets.dart';

/// Wrapper that adds a circle and a triangle behind its [child].
class BackgroundDecoration extends StatelessWidget {
  /// Wrapper that adds a circle and a triangle behind its [child].
  const BackgroundDecoration({
    required this.child,
    this.floatingActionButton,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 106.r,
            left: 0,
            child: SvgPicture.asset(
              AppAssets.circle2,
              height: 290.r,
            ),
          ),
          Positioned(
            top: 80.r,
            right: 0,
            child: SvgPicture.asset(
              AppAssets.triangle,
              width: 140.r,
            ),
          ),
          child,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
