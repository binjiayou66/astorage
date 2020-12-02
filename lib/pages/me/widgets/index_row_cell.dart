import 'package:astorage/defines/acolors.dart';
import 'package:astorage/defines/afont.dart';
import 'package:astorage/pages/me/models/index_row_model.dart';
import 'package:flutter/material.dart';

class IndexRowCell extends StatelessWidget {
  final IndexRowModel rowModel;
  final VoidCallback onTap;

  IndexRowCell(this.rowModel, {this.onTap, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AColors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: AColors.divider,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          children: [
            Icon(
              rowModel.iconData,
              color: AColors.textMain,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                rowModel.title,
                style: TextStyle(
                  color: AColors.textMain,
                  fontSize: AFontSize.body1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
