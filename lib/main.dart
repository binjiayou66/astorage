import 'dart:io';

import 'package:astorage/pages/root/tab_page.dart';
import 'package:astorage/provider/home_provider.dart';
import 'package:astorage/utils/ascreen_adapter.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'utils/aglobal.dart';

void main() async {
  AWidgetsFlutterBinding.ensureInitialized(AGlobal.uiScreenSize);

  AGlobal.fileSavePath = await App.fileSavePath();

  runScreenAdapter(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider.instance),
      ],
      child: App(),
    ),
    uiSize: AGlobal.uiScreenSize,
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: '一个仓库',
        home: TabPage(),
        navigatorObservers: [
          AGlobal.routeObserver,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.white),
        ),
      ),
    );
  }

  static Future<String> fileSavePath() async {
    var path = '';
    if (Platform.isIOS) {
      path = (await getApplicationDocumentsDirectory()).path;
    } else {
      path = (await getDownloadsDirectory()).path;
    }
    path = '$path/upload/';
    final directory = Directory(path);
    if (directory.existsSync() == false) directory.createSync(recursive: true);
    return path;
  }
}
