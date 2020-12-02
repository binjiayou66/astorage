import 'package:flutter/material.dart';

class AColors {
  /// 3296FA
  static const Color primary = const Color(0xFF3296FA);

  /// 2C86E0
  static const Color primaryHighLight = const Color(0xFF2C86E0);

  /// C1DFFD
  static const Color primaryDisable = const Color(0xFFC1DFFD);

  /// 000000
  static const Color black = const Color(0xFF000000);

  /// FFFFFF
  static const Color white = const Color(0xFFFFFFFF);

  /// 84C01A
  static const Color success = const Color(0xFF84C01A);

  /// E49539
  static const Color warning = const Color(0xFFE49539);

  /// DF3B3B
  static const Color danger = const Color(0xFFDF3B3B);

  /// 5F6B7C
  static const Color info = const Color(0xFFF5F6B7C);

  /// E6E6E6
  static const Color divider = const Color(0xFFE6E6E6);

  /// EEEEEE
  static const Color background = const Color(0xFFEEEEEE);

  /// AAFFFFFF
  static const Color disabled = const Color(0xAAFFFFFF);

  /// 262626
  static const Color textMain = const Color(0xFF262626);

  /// 595959
  static const Color textSub = const Color(0xFF595959);

  /// 8c8c8c
  static const Color textInfo = const Color(0xFF8c8c8c);

  /// BFBFBF
  static const Color textTips = const Color(0xFFBFBFBF);

  /// D6D6D6
  static const Color textDisable = const Color(0xFFD6D6D6);

  /// EBEBEB
  static const Color dividerLight = const Color(0xFFEBEBEB);

  /// F5F5F5
  static const Color backgroundDark = const Color(0xFFF5F5F5);

  /// F7F8FA
  static const Color backgroundLight = const Color(0xFFF7F8FA);

  /// From int value
  static Color fromeValue(int value) => Color(value);

  // From Hex String
  static Color fromHexString(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      print('hexToColor error: e');
      return Colors.white;
    }
  }
}
