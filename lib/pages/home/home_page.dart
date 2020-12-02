import 'package:astorage/defines/acolors.dart';
import 'package:astorage/widgets/aappbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        textTitle: '首页',
        noLeading: true,
      ),
      body: Container(
        color: AColors.background,
      ),
    );
  }
}
