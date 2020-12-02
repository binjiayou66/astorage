import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class AToast {
  static showText(String text) {
    showToast(
      text,
      duration: Duration(milliseconds: 1200),
      textPadding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      radius: 20,
    );
  }
}
