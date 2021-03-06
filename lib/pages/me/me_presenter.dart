import 'package:astorage/pages/developer/developer_page.dart';
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
        ARouter.push(context, page: DeveloperPage());
        break;
      default:
    }
  }
}
