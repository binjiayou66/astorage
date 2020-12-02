import 'dart:io';

import 'package:astorage/pages/me/pages/upload_page.dart';
import 'package:astorage/utils/arouter.dart';
import 'package:flutter/material.dart';

class MePresenter {
  void onTapRow(BuildContext context, int index) {
    switch (index) {
      case 0:
        ARouter.push(context, page: UploadPage());
        break;
      case 1:
        _test();
        break;
      default:
    }
  }

  void _test() async {
    final file = File('../../../images/1606893526476.png');
    print('file: ${await file.exists()}');
  }
}
