import 'package:astorage/defines/acolors.dart';
import 'package:astorage/utils/aglobal.dart';
import 'package:flutter/material.dart';

class IndexMeInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      color: AColors.white,
      height: 180 + AGlobal.unsafeHeightTop,
      child: Column(
        children: [
          Container(
            height: AGlobal.unsafeHeightTop,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
