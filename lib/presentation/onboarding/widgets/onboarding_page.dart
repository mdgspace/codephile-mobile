part of 'onboarding_widgets.dart';

/// A single onboarding sub-page. Contains a screenshot, a title and a
/// description of the feature. Uses [PageData] given to [pages].
class OnboardingPage extends StatelessWidget {
  /// A single onboarding sub-page. Contains a screenshot, a title and a
  /// description of the feature. Uses [PageData] given to [pages].
  OnboardingPage({required this.index, Key? key}) : super(key: key) {
    pageIndex = index;
  }

  /// Index of the page.
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Padding(
          padding: pages[index].padding,
          child: Image.asset(
            pages[index].asset,
            width: pages[index].width.w,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            color: AppColors.primary,
            height: 228.r,
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pages[index].title,
                  style: AppStyles.h2,
                  maxLines: 1,
                ),
                const SizedBox(height: 8),
                Text(
                  pages[index].description,
                  style: AppStyles.h5,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Data about the three pages under the onboarding screen.
final List<PageData> pages = <PageData>[
  PageData(
    title: 'Get updates on your Feed',
    description: 'Follow people to get updates when they solve a problem',
    asset: AppAssets.feedCardIllustration,
    padding: EdgeInsets.only(top: 150.r),
    width: 320,
  ),
  PageData(
    title: 'Get updates about Contests',
    description: 'Get updates about contests from various coding platforms',
    asset: AppAssets.contestCardIllustration,
    padding: EdgeInsets.only(top: 150.r),
    width: 320,
  ),
  PageData(
    title: 'Check progress',
    description: "You can check others' progress by visiting their profile",
    asset: AppAssets.profileIllustration,
    padding: EdgeInsets.only(top: 76.r),
    width: 190,
  ),
];

/// Index of the page the screen is currently on.
///
/// This is necessary because the card_swiper package does not update the value
/// of [SwiperController].
int pageIndex = 0;
