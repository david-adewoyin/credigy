import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSizes {
  static double scale = 1;
  static double get h3 => 48 * scale;
  static double get h4 => 38 * scale;
  static double get h5 => 27 * scale;
  static double get h6 => 20 * scale;
  static double get body => 16 * scale;
  static double get bodySm => 14 * scale;
  static double get button => 14 * scale;
  static double get overlay => 12 * scale;
  static double get subtitle => 18 * scale;
  static double get subtitleSm => 16 * scale;
}

class TextStyles {
  static TextStyle get h4 => GoogleFonts.poppins(
        fontSize: FontSizes.h4,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      );

  static TextStyle get h5 => GoogleFonts.poppins(
        fontSize: FontSizes.h5,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      );
  static TextStyle get h6 => GoogleFonts.poppins(
        fontSize: FontSizes.h6,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      );

  static TextStyle get body => GoogleFonts.poppins(
        fontSize: FontSizes.body,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.6,
      );

  static TextStyle get moneyBody => GoogleFonts.roboto(
        fontSize: FontSizes.body,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.6,
      );
  static TextStyle get bodySm => GoogleFonts.poppins(
        fontSize: FontSizes.bodySm,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  static TextStyle get subtitle => GoogleFonts.redHatDisplay(
        fontSize: FontSizes.subtitle,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      );

  static TextStyle get subtitleSm => GoogleFonts.poppins(
        fontSize: FontSizes.subtitleSm,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.65,
      );
}

extension TextStyleHelpers on TextStyle {
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get boldest => copyWith(fontWeight: FontWeight.w900);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get sizePlus => copyWith(fontSize: fontSize! + 1);
  TextStyle withSize(double fontsize) => copyWith(fontSize: fontsize);
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle get sizeMinus => copyWith(fontSize: fontSize! - 1);
  TextStyle letterSpacing(double value) => copyWith(letterSpacing: value);
}
