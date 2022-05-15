part of 'signup_widgets.dart';

/// Displays the progress bar above the forms and handles navigation.
class ScrollAndNavWrapper extends StatelessWidget {
  /// Displays the progress bar above the forms and handles navigation.
  const ScrollAndNavWrapper({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 24.r),
            child: Column(
              children: <Widget>[
                const ProgressBar(),
                SizedBox(height: 25.r),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: child,
                  ),
                ),
                const NextButton(),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        if (context.read<SignUpBloc>().state.pageIndex == 0) return true;
        context.read<SignUpBloc>().add(const Back());
        return false;
      },
    );
  }
}
