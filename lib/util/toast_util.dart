/**
 * Toast工具类
 *
 * Create by lzx on 2019/8/28.
 */

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LToast {
  /// 通用的Toast
  static void show(String msg, {gravity = ToastGravity.BOTTOM, toastLength: Toast.LENGTH_SHORT, fontSize = 14.0, Color backgroundColor}) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: gravity,
      toastLength: toastLength,
      fontSize: fontSize,
      backgroundColor: backgroundColor == null ? Color(0x90000000) : backgroundColor,
    );
  }
}
