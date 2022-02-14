part of 'onboarding_widgets.dart';

/// Pagination indicator. Overrides default values in package.
///
/// The package gives the option to choose alignment for the pagination
/// indicators, but overrules it without exception. The solution is to extend
/// [SwiperCustomPagination] to make a custom pagination indicator.
class PaginationDots extends SwiperCustomPagination {
  /// Pagination indicator. Overrides default values in package.
  ///
  /// The package gives the option to choose alignment for the pagination
  /// indicators, but overrules it without exception. The solution is to extend
  /// [SwiperCustomPagination] to make a custom pagination indicator.
  PaginationDots()
      : super(
          builder: (context, config) {
            return Align(
              alignment: const Alignment(-0.8, 0.8),
              child: DotSwiperPaginationBuilder(
                color: AppColors.grey5,
                activeColor: Colors.white,
                activeSize: 12.r,
                size: 8.r,
                space: 8.r,
              ).build(context, config),
            );
          },
        );
}
