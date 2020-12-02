import 'package:astorage/widgets/aappbar.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class ImageBrowserPage extends StatefulWidget {
  final int imageCount;
  final ImageProvider Function(int index) imageProviderDelegate;
  final String Function(int index) titleDelegate;
  final int initialIndex;
  final BoxFit fit;
  final Axis scrollDirection;
  final EdgeInsets pagePadding;

  ImageBrowserPage(
    this.imageCount,
    this.imageProviderDelegate, {
    Key key,
    this.titleDelegate,
    this.initialIndex = 0,
    this.fit = BoxFit.contain,
    this.scrollDirection = Axis.horizontal,
    this.pagePadding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  _ImageBrowserPageState createState() => _ImageBrowserPageState();
}

class _ImageBrowserPageState extends State<ImageBrowserPage> {
  final String _heroPrefix = 'ImageBrowserPageHeroPrefix';
  int _currentIndex;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        textTitle: widget.titleDelegate?.call(_currentIndex) ?? '图片',
      ),
      body: ExtendedImageGesturePageView.builder(
        itemBuilder: (BuildContext context, int index) {
          Widget image = ExtendedImage(
              image: widget.imageProviderDelegate(index),
              fit: widget.fit,
              mode: ExtendedImageMode.gesture);
          image = Container(
            child: image,
            padding: widget.pagePadding,
          );
          if (index == _currentIndex) {
            return Hero(
              tag: _heroPrefix + index.toString(),
              child: image,
            );
          } else {
            return image;
          }
        },
        itemCount: widget.imageCount,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: PageController(
          initialPage: _currentIndex,
        ),
        scrollDirection: widget.scrollDirection,
      ),
    );
  }
}
