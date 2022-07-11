part of 'login_widgets.dart';

/// Wrapper that adds a circle and a triangle behind its [child].
class BackgroundDecoration extends StatelessWidget {
  /// Wrapper that adds a circle and a triangle behind its [child].
  const BackgroundDecoration({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: svg.SvgPicture.asset(
              AppAssets.circle1,
              width: 170.r,
            ),
          ),
          Positioned(
            top: 80.r,
            right: 0,
            child: svg.SvgPicture.asset(
              AppAssets.triangle,
              width: 140.r,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
