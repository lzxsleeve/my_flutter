import 'package:flutter/material.dart';
import 'package:my_flutter/page/page_router.dart';
import 'package:my_flutter/res/styles.dart';
import 'package:my_flutter/routers/fluro_navigator.dart';
import 'package:my_flutter/util/toast_util.dart';

/// 首页 Create by lzx on 2019/9/12.
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            '首页',
            style: TextStyles.textBoldDark26,
          ),
        ),
        body: _buildBody());
    ;
  }

  _buildBody() {
    return GridView.count(
      //取消GridView回弹效果
      controller: new ScrollController(keepScrollOffset: false),
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
        _buildInk(
            'WebView',
            () => NavigatorUtils.goWebViewPage(
                context, 'NutUI', 'http://192.168.199.220:8081/#/')),
        _buildInk('Dialog集成',
            () => NavigatorUtils.push(context, PageRouter.dialogPage)),
        _buildInk('Animation',
            () => NavigatorUtils.push(context, PageRouter.animPage)),
        _buildInk('File',
            () => NavigatorUtils.push(context, PageRouter.filePage)),
        _buildInk('Test',
            () => NavigatorUtils.push(context, PageRouter.testPage)),
        _buildInk('Demo',
            () => NavigatorUtils.push(context, PageRouter.demoPage)),
        _buildInk('...', () => LToast.show("敬请期待")),
      ],
    );
  }

  // 构建一个颜色渐变的按键
  Ink _buildInk(String text, Function function) {
    return Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue[400], Colors.blue[300], Colors.blue[200]]),
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
        onTap: function,
      ),
    );
  }
}
