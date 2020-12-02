import 'dart:ui';

import 'package:flutter/material.dart';

class AGlobal {
  /// UI稿屏幕宽度
  static const double uiScreenWidth = 375;

  /// UI稿屏幕高度
  static const double uiScreenHeight = 667;

  /// UI稿屏幕尺寸
  static const Size uiScreenSize = const Size(uiScreenWidth, uiScreenHeight);

  /// 屏幕适配后当前设备屏幕宽度
  static double uiScreenWidthCurrent = uiScreenWidth;

  /// 屏幕适配后当前设备屏幕高度
  static double uiScreenHeightCurrent = (window.physicalSize.height /
      (window.physicalSize.width / uiScreenWidth));

  /// 屏幕逻辑像素宽度
  static double screenLogicalWidth =
      window.physicalSize.width / window.devicePixelRatio;

  /// 屏幕逻辑像素高度
  static double screenLogicalHeight =
      window.physicalSize.height / window.devicePixelRatio;

  /// App版本号
  static String appVersion = '';

  /// Device ID
  static String deviceId = '';

  /// App Info
  static String appInfo = '';

  /// 顶部非安全距离
  static double unsafeHeightTop = 0.0;

  /// 全局路由监听对象
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  /// 文件存储路径
  static String fileSavePath = '';
}
