import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/base/global_config.dart';
import 'package:my_flutter/property/over_scroll_behavior.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/image_utils.dart';
import 'package:my_flutter/util/toast_util.dart';

/// 设备分享 Create by lzx on 2019/12/10.

class DeviceSharePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DeviceShareState();
  }
}

class _DeviceShareState extends State<DeviceSharePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设备分享'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.style),
            onPressed: () {
              LToast.show("这是二维码");
            },
          )
        ],
      ),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text('可编辑分享', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          LToast.show("可编辑分享");
                        },
                      ),
                    ),
                    Gaps.hGap8,
                    Expanded(
                      child: RaisedButton(
                        color: Colors.lightBlueAccent,
                        child: Text('不可编辑分享', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          LToast.show("不可编辑分享");
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), child: Text('我分享的')),
              Column(
                children: getMyShareItemList(),
              ),
              Padding(padding: EdgeInsets.only(top: 8), child: Gaps.line),
              Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), child: Text('其他人分享')),
              Column(
                children: getOtherShareItemList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getMyShareItemList() {
    List<Widget> list = new List();

    var widget = Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: ImageUtils.getImageProvider('https://ws1.sinaimg.cn/large/0065oQSqly1g0ajj4h6ndj30sg11xdmj.jpg'),
            radius: 20,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name', style: TextStyle(fontSize: 16, color: GlobalConfig.text333)),
                  Container(
                    width: 60,
                    height: 20,
                    child: RaisedButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.blue,
                      child: Text('可编辑', style: TextStyle(fontSize: 12, color: Colors.white)),
                      onPressed: () {
                        LToast.show("可编辑");
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 25,
            child: RaisedButton(
              color: Colors.blue,
              child: Text('取消分享', style: TextStyle(fontSize: 12, color: Colors.white)),
              onPressed: () {
                LToast.show("取消分享");
              },
            ),
          )
        ],
      ),
    );

    list.add(_buildNoData());

    return list;
  }

  List<Widget> getOtherShareItemList() {
    List<Widget> list = new List();

    var widget = Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: ImageUtils.getImageProvider('https://ws1.sinaimg.cn/large/0065oQSqly1g0ajj4h6ndj30sg11xdmj.jpg'),
            radius: 20,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text('Name', style: TextStyle(fontSize: 16, color: GlobalConfig.text333)),
            ),
          ),
          Container(
            height: 25,
            child: RaisedButton(
              color: Colors.blue,
              child: Text('取消分享', style: TextStyle(fontSize: 14, color: Colors.white)),
              onPressed: () {
                LToast.show("取消分享");
              },
            ),
          )
        ],
      ),
    );

    list.add(widget);

    return list;
  }

  _buildNoData() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Text('没有相关数据'),
    );
  }
}
