import 'package:flutter/material.dart';
import 'package:se7ety/features/auth/data/models/specializations.dart';

ColorPair skyBluePair = ColorPair(Color(0xff71b4fb), Color(0xffa3d1fb));
ColorPair orangePair = ColorPair(Color(0xfffa8c73), Color(0xfffac0b1));
ColorPair purplePair = ColorPair(Color(0xff8873f4), Color(0xffb3a8f5));
ColorPair greenPair = ColorPair(Color(0xff4cd1bc), Color(0xff8de3d4));

class ColorPair {
  final Color primaryColor;
  final Color lightColor;

  ColorPair(this.primaryColor, this.lightColor);
}

class SpecializationCardModel {
  String specialization;
  ColorPair colorPair;

  SpecializationCardModel(this.specialization, this.colorPair);
}

List<SpecializationCardModel> specializationsList = specializations
    .map(
      (e) =>
          SpecializationCardModel(e, getPairColors(specializations.indexOf(e))),
    )
    .toList();

getPairColors(int index) {
  switch (index % 4) {
    case 0:
      return skyBluePair;
    case 1:
      return orangePair;
    case 2:
      return purplePair;
    case 3:
      return greenPair;
  }
}
