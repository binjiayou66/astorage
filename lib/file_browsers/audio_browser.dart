import 'package:astorage/widgets/aappbar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioBrowser extends StatefulWidget {
  final String url;
  final String Function() titleDelegate;

  AudioBrowser(this.url, {this.titleDelegate, Key key}) : super(key: key);

  @override
  _AudioBrowserState createState() => _AudioBrowserState();
}

class _AudioBrowserState extends State<AudioBrowser> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _player.play(widget.url, isLocal: true);
  }

  @override
  void dispose() async {
    await _player.release();
    await _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        textTitle: widget.titleDelegate?.call() ?? '听听音乐吧',
      ),
      body: Container(),
    );
  }
}
