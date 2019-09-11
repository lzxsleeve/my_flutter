/**
 * 状态栏样式
 *
 * Create by admin on 2019/9/3 2019/7/24.
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarStyle {

  static const SystemUiOverlayStyle theme = SystemUiOverlayStyle(
    statusBarColor: Colors.blue,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  );

  static const SystemUiOverlayStyle light = SystemUiOverlayStyle(
    statusBarColor: Color(0xFFFFFFFF),
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  );

  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    statusBarColor: Color(0xFF000000),
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  );
}
