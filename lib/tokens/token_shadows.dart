import 'package:flutter/material.dart';
import 'token_colors.dart';

const shadow01 = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  color: cardBg,
);

const searchBarShadow = BoxShadow(
  color: Color(0x4D000000),
  offset: Offset(0, 1),
  blurRadius: 2,
  spreadRadius: 0,
);

final cardShadow =
    BoxDecoration(borderRadius: BorderRadius.circular(2.0), boxShadow: const [
  BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 6.0,
      spreadRadius: 2.0,
      color: Color.fromARGB(30, 0, 0, 0)),
  BoxShadow(
      offset: Offset(1, 0), blurRadius: 2, color: Color.fromARGB(15, 0, 0, 0)),
]);

//TODO: shadows, iconos y grid
//En los input dice usar subtitle01 pero el color es distinto
//por que hay un height en text style
//como funcionan los iconos? son botones? quiero hacer componente
//como hago iconos interactivos sin iconButton