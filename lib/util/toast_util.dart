/**
 * Toast工具类
 *
 * Create by admin on 2019/8/28 2019/7/24.
 */

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {

  /* 通用的Toast */
  static void show(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 14,
      backgroundColor: Color(0x90000000),
    );
  }
}