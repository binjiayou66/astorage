import 'package:astorage/defines/acolors.dart';
import 'package:astorage/widgets/aappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_filereader/flutter_filereader.dart';

class OfficeBrowser extends StatefulWidget {
  final String url;
  final String Function() titleDelegate;

  OfficeBrowser(this.url, {this.titleDelegate, Key key}) : super(key: key);

  @override
  _OfficeBrowserState createState() => _OfficeBrowserState();
}

class _OfficeBrowserState extends State<OfficeBrowser> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        textTitle: widget.titleDelegate?.call() ?? '',
      ),
      body: Container(
        color: AColors.white,
        child: FileReaderView(
          filePath: widget.url,
        ),
      ),
    );
  }
}
