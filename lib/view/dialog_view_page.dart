/**
 * 弹窗集成界面
 *
 * Create by lzx on 2019/9/9 2019/7/24.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/util/toast_util.dart';

class DialogViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DialogViewState();
  }
}

class _DialogViewState extends State<DialogViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DialogView'),
        actions: <Widget>[
          buildPopupMenuButton(context),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
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
                ToastUtil.show("${date.year}-${date.month}-${date.day}");
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

  // 菜单弹窗
  PopupMenuButton<String> buildPopupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.all(0),
      offset: Offset(0, kToolbarHeight),
      onSelected: (String value) {
        ToastUtil.show(value);
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

  Container buildCupertinoTimePicker(BuildContext context) {
    return Container(
      height: 250,
      child:CupertinoTimerPicker(
        mode: CupertinoTimerPickerMode.hms, //可以设置时分、时分秒和分秒三种模式
        initialTimerDuration: Duration(hours: 1, minutes: 35, seconds: 50), // 默认显示的时间值
        minuteInterval: 5, // 分值间隔，必须能够被initialTimerDuration.inMinutes整除
        secondInterval: 10, // 秒值间隔，必须能够被initialTimerDuration.inSeconds整除，此时设置为10，则选择项为0、10、20、30、40、50六个值
        onTimerDurationChanged: (duration) {
          print('当前选择了：${duration.inHours}时${duration.inMinutes-duration.inHours*60}分${duration.inSeconds-duration.inMinutes*60}秒');
        },
      )
    );
  }

  CupertinoActionSheet buildCupertinoActionSheet(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        '提示',
        style: TextStyle(fontSize: 22),
      ), //标题
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
