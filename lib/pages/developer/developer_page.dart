import 'package:astorage/defines/acolors.dart';
import 'package:astorage/defines/afont.dart';
import 'package:astorage/widgets/aappbar.dart';
import 'package:flutter/material.dart';

class DeveloperPage extends StatefulWidget {
  @override
  _DeveloperPageState createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        textTitle: '开发者',
      ),
      body: Container(
        color: AColors.background,
        child: ListView(
          children: [
            _item('测试', () {}),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      height: 44,
      color: AColors.white,
      child: Text(
        title,
        style: TextStyle(
          fontSize: AFontSize.body2,
          color: AColors.textMain,
        ),
      ),
    );
  }
}
