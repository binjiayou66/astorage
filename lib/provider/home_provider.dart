import 'dart:io';

import 'package:astorage/utils/aglobal.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  factory HomeProvider() => _getInstance();
  static HomeProvider get instance => _getInstance();
  static HomeProvider _instance;
  HomeProvider._();
  static HomeProvider _getInstance() {
    if (_instance == null) {
      _instance = HomeProvider._();
    }
    return _instance;
  }

  List<FileSystemEntity> get files => _files;
  final List<FileSystemEntity> _files = [];

  Future<void> refresh() async {
    final directory = Directory(AGlobal.fileSavePath);
    _files.clear();
    await for (var item in directory.list()) {
      if (FileSystemEntity.isFileSync(item.path)) _files.add(item);
    }
    notifyListeners();
  }
}
