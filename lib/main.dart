import 'dart:io';
import 'dart:ui';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_flutter/page/home_page.dart';
import 'package:my_flutter/res/colors.dart';
import 'package:my_flutter/routers/application.dart';
import 'package:my_flutter/routers/routers.dart';
import 'package:my_flutter/util/file_helper.dart';
import 'package:my_flutter/util/toast_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  Future<void> getSDCardDir() async {
    FileHelper().sDCardDir = (await getExternalStorageDirectory()).path;
    print("getLibraryDirectory = ${FileHelper().sDCardDir}");
  }

//  动态申请权限
  Future applyPermission() async {
    // 申请结果  权限检测
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      //权限没允许
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      //此时要在检测一遍，如果允许了就下载。
      //没允许就就提示。
      PermissionStatus pp = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
      if (pp == PermissionStatus.granted) {
        // 权限允许
        await getSDCardDir();
      } else {
        // 参数1：提示消息// 参数2：提示消息多久后自动隐藏// 参数3：位置
        LToast.show("请允许存储权限!");
      }
    } else {
      //权限已允许
      await getSDCardDir();
    }
  }

  applyPermission();

  /// 开启布局线
//  debugPaintSizeEnabled = true;

  runApp(MyApp());

  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_Learn',
      theme: ThemeData(
        primaryColor: Colours.app_main,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
      onGenerateRoute: Application.router.generator,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        const FallbackCupertinoLocalisationsDelegate()
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
    );
  }
}

// 解决CupertinoAlertDialog异常问题
class FallbackCupertinoLocalisationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) => DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
