import 'package:flutter/material.dart';
import 'token_colors.dart';

// line-height ?
//font-feature-settings?
//text-transform
//si le pongo height a los estilos de tipografia, se rompe todo

const TextStyle headLine01 = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 24,
  //height: 24,
  letterSpacing: 0.18,
  color: lbl,
);

const TextStyle headLine02 = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 20,
  //height: 24,
  letterSpacing: 0.15,
  color: lbl,
);

const TextStyle subtitle01 = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 16,
  //height: 24,
  letterSpacing: 0.15,
  color: lbl,
);

const TextStyle body01 = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 14,
  //height: 20,
  letterSpacing: 0.25,
  color: btnSecondary,
);

const TextStyle body02 = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 12,
  //height: 16,
  letterSpacing: 0.4,
  color: btnSecondary,
);

TextStyle btnModif(Color givenColor) {
  return TextStyle(
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.1,
    color: givenColor,
  );
}

const TextStyle btn = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 14,
  letterSpacing: 0.1,
  color: neutralBg,
);

const TextStyle btnGreen = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 14,
  letterSpacing: 0.1,
  color: primary,
);

const TextStyle caption = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 12,
  //height: 16,
  letterSpacing: 0.4,
  color: lbl,
);

const TextStyle overline = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 10,
  //height: 16,
  letterSpacing: 1.5,
  color: btnSecondary,
);
