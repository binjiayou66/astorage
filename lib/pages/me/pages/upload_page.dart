import 'dart:io';

import 'package:astorage/defines/ahtml.dart';
import 'package:astorage/widgets/aappbar.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  HttpServer _server;
  String _storagePath;
  String get _browserUri =>
      (_server?.address?.host ?? '') + ':' + (_server?.port?.toString() ?? '');

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
        textTitle: '上传',
      ),
      body: Container(
        child: Center(
          child: Text('请在电脑中打开以下地址\n $_browserUri'),
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
      final filePath = (await _savePath()) + fileName;
      final content = await item.toList();
      await File(filePath).writeAsBytes(content[0]);
      print('file save done! $filePath');
    }

    await request.response.close();
  }

  Future<String> _savePath() async {
    if (_storagePath == null) {
      if (Platform.isIOS) {
        _storagePath = (await getApplicationDocumentsDirectory()).path;
      } else {
        _storagePath = (await getDownloadsDirectory()).path;
      }
    }
    return _storagePath + '/';
  }
}
