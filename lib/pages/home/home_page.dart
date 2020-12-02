import 'dart:io';

import 'package:astorage/defines/acolors.dart';
import 'package:astorage/defines/afile_types.dart';
import 'package:astorage/file_browsers/audio_browser.dart';
import 'package:astorage/file_browsers/image_browser.dart';
import 'package:astorage/file_browsers/webview_browser.dart';
import 'package:astorage/provider/home_provider.dart';
import 'package:astorage/utils/aglobal.dart';
import 'package:astorage/utils/arouter.dart';
import 'package:astorage/utils/atoast.dart';
import 'package:astorage/widgets/aappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:astorage/extensions/file_extensions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void initState() {
    super.initState();

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.refresh();
    Future.delayed(Duration.zero, () {
      AGlobal.unsafeHeightTop = MediaQuery.of(context).padding.top;
      AGlobal.routeObserver.subscribe(this, ModalRoute.of(context));
    });
  }

  @override
  void dispose() {
    AGlobal.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        textTitle: '首页',
        noLeading: true,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return _itemBuilder(context, homeProvider, index);
            },
            itemCount: homeProvider.files.length,
          );
        },
      ),
    );
  }

  // Navigator Observer
  @override
  void didPopNext() {
    super.didPopNext();

    print('HomePage will show.');
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.refresh();
  }

  Widget _itemBuilder(
    BuildContext context,
    HomeProvider homeProvider,
    int index,
  ) {
    final file = homeProvider.files[index];
    return InkWell(
      onTap: () => _onTapFile(file),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: AColors.white,
        ),
        child: Text(file.fileName),
      ),
    );
  }

  void _onTapFile(FileSystemEntity file) {
    final type = file.fileType;
    if (AFileTypes.isImage(type)) {
      ARouter.push(
        context,
        page: ImageBrowserPage(
          1,
          (index) => FileImage(file),
          titleDelegate: (index) => file.fileName,
        ),
      );
    } else if (AFileTypes.isAudio(type)) {
      ARouter.push(context, page: AudioBrowser(file.path));
    } else {
      // final url = 'file://${file.path}';
      // ARouter.push(context, page: WebViewBrowser(url));
      AToast.showText('暂不支持浏览的文件类型');
    }
  }
}
