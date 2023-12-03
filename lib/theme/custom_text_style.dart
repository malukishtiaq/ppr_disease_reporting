import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomTextStyles {
  static get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w900,
      );
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get jockeyOne {
    return copyWith(
      fontFamily: 'Jockey One',
    );
  }
}
