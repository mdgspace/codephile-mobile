import 'package:card_swiper/card_swiper.dart';
import 'package:codephile/presentation/onboarding/onboarding_screen.dart';
import 'package:codephile/presentation/onboarding/widgets/onboarding_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_screen.dart';

void widgetTests() {
  group('OnboardingScreen -', () {
    testWidgets('contains sub-widgets', (tester) async {
      await pumpScreen(tester, () => OnboardingScreen());

      expect(find.byType(BackgroundDecoration), findsOneWidget);
      expect(find.byType(NextButton), findsOneWidget);
      expect(find.byType(Swiper), findsOneWidget);
      expect(find.byType(OnboardingPage), findsOneWidget);

      /// The [PaginationDots] widget does not show up as anything special in
      /// the widget tree because of the idiosyncrasies of the package author.
      /// Hence this roundabout way of testing whether the widget is present.
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Align && widget.child is Row,
        ),
        findsOneWidget,
      );
    });

    testWidgets("contains first feature's data", (tester) async {
      await pumpScreen(tester, () => OnboardingScreen());

      expect(find.text(pages[0].title), findsOneWidget);
      expect(find.text(pages[0].description), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName == pages[0].asset,
        ),
        findsOneWidget,
      );
    });

    testWidgets('pressing NextButton takes user to next page', (tester) async {
      await pumpScreen(tester, () => OnboardingScreen());

      for (var i = 0; i < pages.length; i++) {
        // Finds i^th feature's data
        expect(find.text(pages[i].title), findsOneWidget);
        expect(find.text(pages[i].description), findsOneWidget);
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Image &&
                widget.image is AssetImage &&
                (widget.image as AssetImage).assetName == pages[i].asset,
          ),
          findsOneWidget,
        );

        await tester.tap(find.byType(NextButton));
        await tester.pumpAndSettle();
      }

      // TODO(BURG3R5): Uncomment the next line when a HomeScreen widget has been created.
      // expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
