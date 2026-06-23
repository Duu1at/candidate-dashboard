import 'package:flutter/widgets.dart';

abstract final class AppRadius {
  /// Checkbox / toggle corner rounding.
  static const double checkbox = 6.0;

  /// Stack tag chip corner rounding.
  static const double tag = 8.0;

  /// Standard button corner rounding.
  static const double button = 12.0;

  /// Input field corner rounding.
  static const double input = 12.0;

  /// Primary CTA button corner rounding.
  static const double cta = 13.0;

  /// Contact action button.
  static const double contactCard = 14.0;

  /// Standard card / list item corner rounding.
  static const double card = 16.0;

  /// Bottom sheet / modal corner rounding.
  static const double modal = 20.0;

  /// Full pill — filter chips, verdict badges, status dots.
  static const double chip = 999.0;

  static const BorderRadius checkboxBorderRadius = BorderRadius.all(
    Radius.circular(checkbox),
  );
  static const BorderRadius buttonBorderRadius = BorderRadius.all(
    Radius.circular(button),
  );
  static const BorderRadius tagBorderRadius = BorderRadius.all(
    Radius.circular(tag),
  );
  static const BorderRadius inputBorderRadius = BorderRadius.all(
    Radius.circular(input),
  );
  static const BorderRadius ctaBorderRadius = BorderRadius.all(
    Radius.circular(cta),
  );
  static const BorderRadius contactCardBorderRadius = BorderRadius.all(
    Radius.circular(contactCard),
  );
  static const BorderRadius cardBorderRadius = BorderRadius.all(
    Radius.circular(card),
  );
  static const BorderRadius chipBorderRadius = BorderRadius.all(
    Radius.circular(chip),
  );
  static const BorderRadius modalBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(modal),
    topRight: Radius.circular(modal),
  );
}
