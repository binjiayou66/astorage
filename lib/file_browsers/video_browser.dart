import 'dart:io';

import 'package:astorage/defines/acolors.dart';
import 'package:astorage/widgets/aappbar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBrowser extends StatefulWidget {
  final String url;
  final String Function() titleDelegate;

  VideoBrowser(this.url, {this.titleDelegate, Key key}) : super(key: key);

  @override
  _VideoBrowserState createState() => _VideoBrowserState();
}

class _VideoBrowserState extends State<VideoBrowser> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.url))
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        textTitle: widget.titleDelegate?.call() ?? '',
        actions: [
          if (_controller != null)
            IconButton(
                icon: Icon(
                  _controller.value.isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill,
                  color: AColors.textMain,
                ),
                onPressed: () {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                  setState(() {});
                }),
        ],
      ),
      body: Container(
        color: AColors.white,
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
    );
  }
}
