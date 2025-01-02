import 'package:flutter/widgets.dart';

abstract class AppTextStyle {
  /// The name of the package that the text styles are defined in.
  ///
  /// Must be non-null if the font family is defined in a package that is not
  /// the main application package.
  ///
  /// If your font is defined in the main application package, set this to null
  /// or remove it entirely.
  static const _fontPackage = 'app_ui';

  /// 30Extrabold figma style properties
  /// fontFamily: Roboto
  /// fontSize: 30px
  /// height: 32px
  /// fontWeight: 700
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const extrabold30 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 30,
    height: 1.07,
    fontWeight: FontWeight.w700,
    package: _fontPackage,
  );

  /// 28Semibold figma style properties
  /// fontFamily: Roboto
  /// fontSize: 28px
  /// height: 30px
  /// fontWeight: 600
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const semibold28 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 28,
    height: 1.07,
    fontWeight: FontWeight.w600,
    package: _fontPackage,
  );

  /// 22Black figma style properties
  /// fontFamily: Roboto
  /// fontSize: 22px
  /// height: 24px
  /// fontWeight: 900
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const black22 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    height: 1.09,
    fontWeight: FontWeight.w900,
    package: _fontPackage,
  );

  /// 22Semibold figma style properties
  /// fontFamily: Roboto
  /// fontSize: 22px
  /// height: 18px
  /// fontWeight: 600
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const semibold22 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    height: 0.82,
    fontWeight: FontWeight.w600,
    package: _fontPackage,
  );

  /// 22Regular figma style properties
  /// fontFamily: Roboto
  /// fontSize: 22px
  /// height: 18px
  /// fontWeight: 400
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const regular22 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    height: 0.82,
    fontWeight: FontWeight.w400,
    package: _fontPackage,
  );

  /// 18Bold figma style properties
  /// fontFamily: Roboto
  /// fontSize: 18px
  /// height: 19px
  /// fontWeight: 700
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const bold18 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    height: 1.06,
    fontWeight: FontWeight.w700,
    package: _fontPackage,
  );

  /// 18Medium figma style properties
  /// fontFamily: Roboto
  /// fontSize: 18px
  /// height: 24px
  /// fontWeight: 500
  /// letterSpacing: -1.1%
  /// fontStyle: none
  /// decoration: none
  static const medium18 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
    package: _fontPackage,
  );

  /// 18MediumUnderlined figma style properties
  /// fontFamily: Roboto
  /// fontSize: 18px
  /// height: 24px
  /// fontWeight: 500
  /// letterSpacing: -1.1%
  /// fontStyle: none
  /// decoration: underline
  static const mediumUnderlined18 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
    decoration: TextDecoration.underline,
    package: _fontPackage,
  );

  /// 16Bold figma style properties
  /// fontFamily: Roboto
  /// fontSize: 16px
  /// height: 24px
  /// fontWeight: 700
  /// letterSpacing: -1.1%
  /// fontStyle: none
  /// decoration: none
  static const bold16 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.18,
    package: _fontPackage,
  );

  /// 16Semibold figma style properties
  /// fontFamily: Roboto
  /// fontSize: 16px
  /// height: 24px
  /// fontWeight: 600
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const semibold16 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w600,
    package: _fontPackage,
  );

  /// 16Medium figma style properties
  /// fontFamily: Roboto
  /// fontSize: 16px
  /// height: 18px
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const medium16 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    height: 1.13,
    fontWeight: FontWeight.w500,
    package: _fontPackage,
  );

  /// 16Regular figma style properties
  /// fontFamily: Roboto
  /// fontSize: 16px
  /// height: 18px
  /// fontWeight: 400
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const regular16 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    height: 1.13,
    fontWeight: FontWeight.w400,
    package: _fontPackage,
  );

  /// 14Extrabold figma style properties
  /// fontFamily: Roboto
  /// fontSize: 14px
  /// height: 19px
  /// fontWeight: 700
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const extrabold14 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    height: 1.36,
    fontWeight: FontWeight.w700,
    package: _fontPackage,
  );

  /// 14Bold figma style properties
  /// fontFamily: Roboto
  /// fontSize: 14px
  /// height: 19px
  /// fontWeight: 700
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const bold14 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    height: 1.36,
    fontWeight: FontWeight.w700,
    package: _fontPackage,
  );

  /// 14Medium figma style properties
  /// fontFamily: Roboto
  /// fontSize: 14px
  /// height: 16px
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const medium14 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    height: 1.14,
    fontWeight: FontWeight.w500,
    package: _fontPackage,
  );

  /// 14Regular figma style properties
  /// fontFamily: Roboto
  /// fontSize: 14px
  /// height: 17px
  /// fontWeight: 400
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const regular14 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    height: 1.21,
    fontWeight: FontWeight.w400,
    package: _fontPackage,
  );

  /// 12Medium figma style properties
  /// fontFamily: Roboto
  /// fontSize: 12px
  /// height: 24px
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const medium12 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    height: 2,
    fontWeight: FontWeight.w500,
    package: _fontPackage,
  );

  /// 10Medium figma style properties
  /// fontFamily: Roboto
  /// fontSize: 10px
  /// height: 24px
  /// fontWeight: 500
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  static const medium10 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 10,
    height: 2.4,
    fontWeight: FontWeight.w500,
    package: _fontPackage,
  );
}
