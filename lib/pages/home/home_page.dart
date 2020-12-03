import 'dart:io';

import 'package:astorage/defines/acolors.dart';
import 'package:astorage/defines/afile_types.dart';
import 'package:astorage/file_browsers/audio_browser.dart';
import 'package:astorage/file_browsers/image_browser.dart';
import 'package:astorage/file_browsers/office_browser.dart';
import 'package:astorage/file_browsers/video_browser.dart';
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
        textTitle: '文件',
        noLeading: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.sort,
              color: AColors.textMain,
            ),
            onPressed: () {},
          )
        ],
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
        color: AColors.white,
        padding: EdgeInsets.only(left: 12),
        child: Container(
          padding: EdgeInsets.only(right: 12, top: 16, bottom: 16),
          decoration: BoxDecoration(
            color: AColors.white,
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: AColors.divider,
              ),
            ),
          ),
          child: Text(file.fileName),
        ),
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
      ARouter.push(context,
          page: AudioBrowser(
            file.path,
            titleDelegate: () => file.fileName,
          ));
    } else if (AFileTypes.isOffice(type)) {
      ARouter.push(context,
          page: OfficeBrowser(
            file.path,
            titleDelegate: () => file.fileName,
          ));
    } else if (AFileTypes.isVideo(type)) {
      ARouter.push(context,
          page: VideoBrowser(
            file.path,
            titleDelegate: () => file.fileName,
          ));
    } else {
      AToast.showText('暂不支持浏览的文件类型');
    }
  }
}
