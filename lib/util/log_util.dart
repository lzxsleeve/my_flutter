import 'package:intl/intl.dart';
import 'package:my_flutter/base/global_config.dart';

/// 日志打印 Create by lzx on 2019/11/5.
/// example: 2019-11-05 17:01:02.565 D/tag: msg

class LogUtil {
  static bool isDebug = GlobalConfig.isDebug;

  static d(msg, {String tag = "Log"}) {
    if (isDebug) {
      print("${getCurrentTime()} D/$tag: $msg");
    }
  }

  static i(msg, {String tag = "Log"}) {
    if (isDebug) {
      print("${getCurrentTime()} I/$tag: $msg");
    }
  }

  static w(msg, {String tag = "Log"}) {
    if (isDebug) {
      print("${getCurrentTime()} W/$tag: $msg");
    }
  }

  static e(msg, {String tag = "Log"}) {
    if (isDebug) {
      print("${getCurrentTime()} E/$tag: $msg");
    }
  }

  static getCurrentTime() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss:SSS");
    return dateFormat.format(DateTime.now());
  }
}
