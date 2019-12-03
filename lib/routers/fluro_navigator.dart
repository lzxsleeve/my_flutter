import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/routers/custo_route.dart';

import 'application.dart';
import 'routers.dart';

/// fluro的路由跳转工具类
class NavigatorUtils {

  /// 跳转页面,[path]页面路由,[replace]是否替换,[clearStack]是否清除堆栈
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, TransitionType transitions = TransitionType.cupertino}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: transitions);
  }

  /// 跳转页面，且会接收该页面返回的参数
  static pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false, TransitionType transitions = TransitionType.cupertino}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.cupertino).then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  /// 返回
  static void pop(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void popWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  /// 跳到WebView页，同时也是一个带参跳转页面的例子
  static goWebViewPage(BuildContext context, String title, String url) {
    // fluro 不支持传中文,需转换
    push(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }
}
