import 'dart:io';

import 'package:astorage/defines/acolors.dart';
import 'package:astorage/defines/afont.dart';
import 'package:astorage/defines/ahtml.dart';
import 'package:astorage/utils/aglobal.dart';
import 'package:astorage/utils/atoast.dart';
import 'package:astorage/widgets/aappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  HttpServer _server;
  String get _browserUri =>
      (_server?.address?.host ?? '') + ':' + (_server?.port?.toString() ?? '');
  List<String> _savedFiles = [];

  @override
  void initState() {
    super.initState();

    _startServer();
  }

  @override
  void dispose() {
    _server?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        textTitle: '文件上传',
      ),
      body: Container(
        color: AColors.background,
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: _browserUri));
                      AToast.showText('地址复制成功');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AColors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '请在电脑中打开以下地址（点击复制）',
                            style: TextStyle(
                              color: AColors.textMain,
                              fontSize: AFontSize.body2,
                            ),
                          ),
                          Text(
                            '\n$_browserUri',
                            style: TextStyle(
                              color: AColors.textMain,
                              fontSize: AFontSize.body1,
                              fontWeight: AFontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (_savedFiles.length > 0)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AColors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: AColors.divider,
                            width: 0.5,
                          ),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: Text(
                        '本次已成功保存以下文件：',
                        style: TextStyle(
                          color: AColors.textMain,
                          fontSize: AFontSize.body2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            Expanded(
              child: ListView.builder(
                itemBuilder: _itemBuilder,
                itemCount: _savedFiles.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index >= _savedFiles.length) return Container();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: AColors.white,
      ),
      child: Text(
        _savedFiles[index],
        style: TextStyle(
          color: AColors.textMain,
          fontSize: AFontSize.body2,
        ),
      ),
    );
  }

  Future<void> _startServer() async {
    try {
      _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
      if (mounted) setState(() {});
    } catch (e) {
      print('开启服务失败: $e');
    }
    await for (var request in _server) {
      switch (request.uri.toString()) {
        case '/':
          request.response
            ..headers.contentType =
                ContentType("text", "html", charset: "utf-8")
            ..write(AHtml.upload)
            ..close();
          break;
        case '/upload':
          _dealUpload(request);
          break;
        default:
          request.response
            ..headers.contentType =
                ContentType("text", "plain", charset: "utf-8")
            ..write('Hello World')
            ..close();
      }
    }
  }

  Future<void> _dealUpload(HttpRequest request) async {
    List<int> dataBytes = [];
    /** 
    request.listen((data) {
      dataBytes.addAll(data);
    }, onDone: () {});

    == 作用等同 ==

    await for (var data in request) {
      dataBytes.addAll(data);
    }
    */
    await for (var data in request) {
      dataBytes.addAll(data);
    }
    final boundary = request.headers.contentType.parameters['boundary'];
    final transformer = MimeMultipartTransformer(boundary);
    final bodyStream = Stream.fromIterable([dataBytes]);
    final parts = await transformer.bind(bodyStream).toList();

    for (var item in parts) {
      final contentDisposition = item.headers['content-disposition'];
      final fileName =
          RegExp(r'filename="([^"]*)"').firstMatch(contentDisposition).group(1);
      final filePath = AGlobal.fileSavePath + fileName;
      final content = await item.toList();
      final file = File(filePath);
      if (await file.exists()) {
        AToast.showText('同名文件已存在');
      } else {
        await file.writeAsBytes(content[0]);
        print('file save done! $filePath');
        _savedFiles.add(fileName);
        if (mounted) setState(() {});
      }
    }

    await request.response.close();
  }
}
