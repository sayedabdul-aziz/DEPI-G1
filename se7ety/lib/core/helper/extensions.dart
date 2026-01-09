// context.pushTo(newScreen);
// pushTo(context, newScreen);

// SizedBox(height:17)

// 17.h()
// 17.h

// 17.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension Sizing on num {
  Widget get h {
    return SizedBox(height: toDouble());
  }
}

extension Localization on BuildContext {
  bool get isArabic => locale.languageCode == 'ar';
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}
