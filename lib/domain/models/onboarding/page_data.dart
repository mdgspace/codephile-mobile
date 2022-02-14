import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_data.freezed.dart';

@freezed

/// Model for the three similar pages shown during onboarding.
class PageData with _$PageData {
  /// Model for the three similar pages shown during onboarding.
  const factory PageData({
    /// Main text on the page.
    required String title,

    /// Extra descriptive text on the page.
    required String description,

    /// Path of the image asset to be displayed.
    required String asset,

    /// Padding of the image.
    required EdgeInsets padding,

    /// Width of the image.
    required int width,
  }) = _PageData;
}
