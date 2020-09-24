import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherApp/Utils/utils.dart';

// Return font with sufficent contrast based on ui colors
class StyleStore {
  TextStyle headline5;

  TextStyle headline6;

  TextStyle caption;

  Color icon;

  Color divider;

  TextStyle headline1;

  TextStyle dancingStyle;

  StyleStore({@required TextTheme textTheme, @required Color background}) {
    this.headline5 = textTheme.headline5.copyWith(
        color: calculateContrastColor(background, Colors.black, Colors.white));
    this.headline6 = textTheme.headline6.copyWith(
        color: calculateContrastColor(background, Colors.black, Colors.white));
    this.caption = textTheme.caption.copyWith(
        color: calculateContrastColor(background, Colors.black.withOpacity(0.8),
            Colors.white.withOpacity(0.8)));
    this.icon = calculateContrastColor(background, Colors.black, Colors.white);
    this.divider = calculateContrastColor(background,
        Colors.black.withOpacity(0.3), Colors.white.withOpacity(0.3));
    this.headline1 = textTheme.headline5
        .copyWith(
            color:
                calculateContrastColor(background, Colors.black, Colors.white))
        .copyWith(fontFamily: GoogleFonts.getFont('Rubik Mono One').fontFamily);
    this.dancingStyle = textTheme.subtitle1
        .copyWith(
            color: calculateContrastColor(background,
                Colors.black.withOpacity(0.8), Colors.white.withOpacity(0.8)))
        .copyWith(fontFamily: GoogleFonts.getFont('Dancing Script').fontFamily);
  }
}
