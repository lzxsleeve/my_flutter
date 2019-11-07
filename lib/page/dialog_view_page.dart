/**
 * 弹窗集成界面
 *
 * Create by lzx on 2019/9/9.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/base/popup_window.dart';
import 'package:my_flutter/res/colors.dart';
import 'package:my_flutter/res/styles.dart';
import 'package:my_flutter/routers/fluro_navigator.dart';
import 'package:my_flutter/util/load_image.dart';
import 'package:my_flutter/util/toast_util.dart';

class DialogViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DialogViewState();
  }
}

class _DialogViewState extends State<DialogViewPage> {
  GlobalKey _addKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DialogView'),
        actions: <Widget>[
          IconButton(
            key: _addKey,
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: _showPopupWindow,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          buildPopupMenuButton(context),
          RaisedButton(
            child: Text('SimpleDialog'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return buildSimpleDialog(context);
                  });
            },
          ),
          RaisedButton(
            child: Text('AlertDialog'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => buildAlertDialog(context));
            },
          ),
          RaisedButton(
            child: Text('BottomDialog'),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => buildContainer(context));
            },
          ),
          RaisedButton(
            child: Text('AboutDialog'),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'FlutterLearn',
                applicationVersion: 'v1.0.0',
                applicationIcon: Image(
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/ic_logo.png'),
                ),
                children: <Widget>[
                  Text("用于记录flutter学习的"),
                ],
              );
            },
          ),
          RaisedButton(
            child: Text('CupertinoAlertDialog'),
            onPressed: () {
              showCupertinoDialog(
                  context: context,
                  builder: (context) => buildCupertinoAlertDialog(context));
            },
          ),
          RaisedButton(
            child: Text('CupertinoModalPopup'),
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) => buildCupertinoActionSheet(context));
            },
          ),
          RaisedButton(
            child: Text('DatePicker'),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950, 1, 1),
                lastDate: DateTime(2099, 12, 31),
                locale: Locale('zh', 'CH'),
              ).then((DateTime date) {
                LToast.show("${date.year}-${date.month}-${date.day}");
              }).catchError((onError) {
                print(onError);
              });
            },
          ),
          RaisedButton(
            child: Text('TimePicker'),
            onPressed: () {
              showTimePicker(context: context, initialTime: TimeOfDay.now());
            },
          ),
          RaisedButton(
            child: Text('DatePicker(IOS样式)'),
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) => buildCupertinoDatePicker(context));
            },
          ),
          RaisedButton(
            child: Text('TimePicker(IOS样式)'),
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) => buildCupertinoTimePicker(context));
            },
          ),
        ],
      ),
    );
  }

  _showPopupWindow(){
    final RenderBox button = _addKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    var a =  button.localToGlobal(Offset(button.size.width - 8.0, button.size.height - 12.0), ancestor: overlay);
    var b =  button.localToGlobal(button.size.bottomLeft(Offset(0, - 12.0)), ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    showPopupWindow(
      context: context,
      fullWidth: false,
      isShowBg: true,
      position: position,
      elevation: 0.0,
      child: GestureDetector(
        onTap: (){
          NavigatorUtils.pop(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: const LoadAssetImage("jt", width: 8.0, height: 4.0,),
            ),
            SizedBox(
              width: 120.0,
              height: 40.0,
              child: FlatButton.icon(
                  onPressed: (){

                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    ///顶部圆角
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                  ),
                  icon: const LoadAssetImage("ic_wx", width: 20.0, height: 20.0,),
                  label: const Text("微信图标", style: TextStyles.textDark14,)
              ),
            ),
            Container(width: 120.0, height: 0.6, color: Colours.line),
            SizedBox(
              width: 120.0,
              height: 40.0,
              child: FlatButton.icon(
                  color: Colors.white,
                  onPressed: (){

                  },
                  shape: RoundedRectangleBorder(
                    ///底部圆角
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                  ),
                  icon: const LoadAssetImage("ic_alipay", width:20.0, height: 20.0,),
                  label: const Text("支付宝嗷", style: TextStyles.textDark14)
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 菜单弹窗
  PopupMenuButton<String> buildPopupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      child: Container(
        height: 36,
        child: Card(
          margin: EdgeInsets.all(0),
          color: Color(0xffe0e0e0),
          child: Center(
            child: Text(
              'PopupMenuButton',
              style: TextStyles.textDark14,
            ),
          ),
        ),
      ),
      padding: EdgeInsets.all(0),
      offset: Offset(0, kToolbarHeight),
      onSelected: (String value) {
        LToast.show(value);
        if (value == 'launch') {
          Navigator.pop(context);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        PopupMenuItem(
          value: 'refresh',
          child: ListTile(
            leading: Icon(Icons.refresh),
            title: Text('刷新'),
          ),
        ),
        PopupMenuItem(
          value: 'setting',
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
          ),
        ),
        PopupMenuItem(
          value: 'all_inclusive',
          child: ListTile(
            leading: Icon(Icons.all_inclusive),
            title: Text('无限'),
          ),
        ),
        PopupMenuItem(
          value: 'launch',
          child: ListTile(
            leading: Icon(Icons.launch),
            title: Text('退出'),
          ),
        )
      ],
    );
  }

  Container buildCupertinoDatePicker(BuildContext context) {
    return Container(
      height: 250,
      child: CupertinoDatePicker(
        //日期时间模式，此处为日期和时间模式
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) {
          if (dateTime == null) {
            return;
          }
          print('当前选择了：${dateTime.year}年${dateTime.month}月${dateTime.day}日');
        },
        initialDateTime: DateTime.now(),
      ),
    );
  }

  //Android的文字样式可能有问题
  Container buildCupertinoTimePicker(BuildContext context) {
    return Container(
        height: 250,
        child: CupertinoTimerPicker(
          mode: CupertinoTimerPickerMode.hms,
          //可以设置时分、时分秒和分秒三种模式
          initialTimerDuration: Duration(hours: 1, minutes: 35, seconds: 50),
          // 默认显示的时间值
          minuteInterval: 5,
          // 分值间隔，必须能够被initialTimerDuration.inMinutes整除
          secondInterval: 10,
          // 秒值间隔，必须能够被initialTimerDuration.inSeconds整除，此时设置为10，则选择项为0、10、20、30、40、50六个值
          onTimerDurationChanged: (duration) {
            print(
                '当前选择了：${duration.inHours}时${duration.inMinutes - duration.inHours * 60}分${duration.inSeconds - duration.inMinutes * 60}秒');
          },
        ));
  }

  CupertinoActionSheet buildCupertinoActionSheet(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        '提示',
        style: TextStyle(fontSize: 22),
      ),
      message: Text('麻烦抽出几分钟对该软件进行评价，谢谢!'), //提示内容
      actions: <Widget>[
        //操作按钮集合
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('给个好评'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('我要吐槽'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        //取消按钮
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('取消'),
      ),
    );
  }

  // 一个IOS演示的AlertDialog
  CupertinoAlertDialog buildCupertinoAlertDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Alert"),
      content: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text('Some Message')
        ],
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text("Sure"),
          onPressed: () {
            Navigator.pop(context, 1);
          },
        ),
        CupertinoDialogAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context, 2);
          },
        ),
      ],
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Center(
              child: Text("Item_1"),
            ),
          ),
          ListTile(
            title: Center(
              child: Text("Item_2"),
            ),
          ),
          ListTile(
            title: Center(
              child: Text("Item_3"),
            ),
          ),
          ListTile(
            title: Center(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Dialog'),
      content: Text(('Dialog content..')),
      actions: <Widget>[
        new FlatButton(
          child: new Text("取消"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text("确定"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  SimpleDialog buildSimpleDialog(BuildContext context) {
    return SimpleDialog(
      title: Text("SimpleDialog"),
      titlePadding: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))),
      children: <Widget>[
        ListTile(
          title: Center(
            child: Text("Item_1"),
          ),
        ),
        ListTile(
          title: Center(
            child: Text("Item_2"),
          ),
        ),
        ListTile(
          title: Center(
            child: Text("Item_3"),
          ),
        ),
        ListTile(
          title: Center(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
