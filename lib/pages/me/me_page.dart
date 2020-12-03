import 'package:astorage/defines/acolors.dart';
import 'package:astorage/pages/me/me_presenter.dart';
import 'package:astorage/pages/me/models/index_row_model.dart';
import 'package:astorage/pages/me/widgets/index_me_info_widget.dart';
import 'package:astorage/pages/me/widgets/index_row_cell.dart';
import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  final int _excessRowCount = 1;
  final List<IndexRowModel> _rowDatas = [
    IndexRowModel('上传文件', Icons.upload_file),
    IndexRowModel('开发者选项', Icons.text_fields),
  ];
  final MePresenter _presenter = MePresenter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AColors.background,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: _itemBuilder,
          itemCount: _rowDatas.length + _excessRowCount,
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == 0) {
      return IndexMeInfoWidget();
    } else if (index >= _excessRowCount &&
        index < _rowDatas.length + _excessRowCount) {
      final delIndex = index - _excessRowCount;
      return IndexRowCell(
        _rowDatas[delIndex],
        onTap: () => _presenter.onTapRow(context, delIndex),
      );
    }
    return Container();
  }
}
