// context.pushTo(newScreen);
// pushTo(context, newScreen);

// SizedBox(height:17)

// 17.h()
// 17.h

// 17.

import 'package:flutter/material.dart';

extension Sizing on num {
  Widget get h {
    return SizedBox(height: toDouble());
  }
}
