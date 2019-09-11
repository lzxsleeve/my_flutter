import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_flutter/util/toast_util.dart';
import 'package:my_flutter/view/dialog_view_page.dart';
import 'package:my_flutter/web/web_view_page.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.blue));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '首页',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '首页'),
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
class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: GridView.count(
          //水平子Widget之间间距
          crossAxisSpacing: 10,
          //垂直子Widget之间间距
          mainAxisSpacing: 10,
          //GridView内边距
          padding: EdgeInsets.all(10),
          //一行的Widget数量
          crossAxisCount: 2,
          //子Widget宽高比例
          childAspectRatio: 2,
          //子Widget列表
          children: <Widget>[
            buildInk(
                context,
                'WebView',
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewPage(
                            url: 'https://github.com', title: 'github')))),
            buildInk(
                context,
                'Dialog集成',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DialogViewPage()))),
            buildInk(context, '...', () => ToastUtil.show("敬请期待")),
          ],
        ));
  }

  // 构建一个颜色渐变的按键
  Ink buildInk(BuildContext context, String text, VoidCallback widget) {
    return Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue[400], Colors.blue[300]]),
        boxShadow: [BoxShadow(color: Colors.grey[300], offset: Offset(1, 2))],
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: widget,
      ),
    );
  }
}
