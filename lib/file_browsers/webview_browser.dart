import 'package:astorage/widgets/aappbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewBrowser extends StatefulWidget {
  final String url;

  WebViewBrowser(this.url, {Key key}) : super(key: key);

  @override
  _WebViewBrowserState createState() => _WebViewBrowserState();
}

class _WebViewBrowserState extends State<WebViewBrowser> {
  WebViewController _controller;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        textTitle: '',
      ),
      body: WebView(
        initialUrl: widget.url,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
      ),
    );
  }
}
