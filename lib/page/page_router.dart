
import 'package:fluro/fluro.dart';
import 'package:my_flutter/page/anim_view_page.dart';
import 'package:my_flutter/page/flare_anim_page.dart';
import 'package:my_flutter/page/demo_page.dart';
import 'package:my_flutter/page/dialog_view_page.dart';
import 'package:my_flutter/page/file_manage_page.dart';
import 'package:my_flutter/page/test_page.dart';
import 'package:my_flutter/routers/router_init.dart';

class PageRouter implements IRouterProvider{

  static String dialogPage = "/dialog";
  static String animPage = "/anim";
  static String filePage = "/file";
  static String testPage = "/test";
  static String demoPage = "/demo";
  static String flarePage = "/flare";

  @override
  void initRouter(Router router) {
    router.define(dialogPage, handler: Handler(handlerFunc: (_, params) => DialogViewPage()));
    router.define(animPage, handler: Handler(handlerFunc: (_, params) => AnimViewPage()));
    router.define(filePage, handler: Handler(handlerFunc: (_, params) => FileManagePage()));
    router.define(testPage, handler: Handler(handlerFunc: (_, params) => TestPage()));
    router.define(demoPage, handler: Handler(handlerFunc: (_, params) => DemoPage()));
    router.define(flarePage, handler: Handler(handlerFunc: (_, params) => FlareAnimPage()));
  }
  
}