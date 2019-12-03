import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/base/app_navigator.dart';
import 'package:my_flutter/page/demo/device_detail_page.dart';
import 'package:my_flutter/page/demo/device_list_page.dart';
import 'package:my_flutter/property/over_scroll_behavior.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/routers/fluro_navigator.dart';
import 'package:my_flutter/util/image_utils.dart';
import 'package:my_flutter/util/log_util.dart';
import 'package:my_flutter/util/toast_util.dart';
import 'package:my_flutter/widgets/text_switch.dart';

/// 设备 Create by lzx on 2019/11/7.

class DevicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DeviceState();
  }
}

class _DeviceState extends State<DevicePage> {
  bool isLoading = false;
  List _aloneList = List();
  List _groupList = List();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: <Widget>[
            Tab(text: '集群版(${_groupList.length})'),
            Tab(text: '单机版(${_aloneList.length})'),
          ],
        ),
        body: TabBarView(
          children: <Widget>[_buildContent(_groupList, _buildListItem()), _buildContent(_aloneList, _buildAloneItem())],
        ),
      ),
    );
  }

  _buildContent(List list, Widget itemWidget) {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1), () {
            setState(() {
              list.add("");
              LToast.show("刷新完成");
            });
          });
        },
        child: ListView.builder(
          itemCount: list.length == 0 ? 1 : list.length, //列表长度+底部加载中提示
          itemBuilder: (context, index) {
            if (list.isEmpty) {
              return _buildNoDataItem();
            } else {
              return itemWidget;
            }
          },
        ),
      ),
    );
  }

  _buildListItem() {
    return InkWell(
      onTap: () {
        AppNavigator.push(context, DeviceListPage());
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            height: 100,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 15,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        ImageUtils.getImgPath('cluster'),
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        '在线',
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('设备：GHX-0189'),
                          Gaps.hGap8,
                          Container(
                            width: 50,
                            height: 20,
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                              onPressed: () {
                                LToast.show("解绑");
                              },
                              color: Colors.blue,
                              child: Text('解绑', style: TextStyle(fontSize: 12, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap5,
                      Text('条形码：SN_000000000000000000000')
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Gaps.line,
          )
        ],
      ),
    );
  }

  _buildAloneItem() {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, DeviceDetailPage());
      },
      child: Container(
        height: 180,
        padding: EdgeInsets.all(6),
        child: Card(
          color: Colors.green,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 12,
                left: 12,
                child: Text(
                  '254. 东露阳',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '运行中',
                    style: TextStyle(color: Colors.white, shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 4)]),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('23.6', style: TextStyle(fontSize: 50, color: Colors.white)),
                      Text('℃', style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 70,
                      child: TextSwitch(
                        onText: '开',
                        offText: '关',
                        textStyle: TextStyle(color: Colors.white),
                        initValue: true,
                        onChanged: (value) {
                          LogUtil.d("Switch: true");
                        },
                      ),
                    ),
                    Gaps.vGap8,
                    GestureDetector(
                      onTap: () {
                        LToast.show("目标温度点击");
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('22.3℃', style: TextStyle(color: Colors.white)),
                          Text('目标温度', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildNoDataItem() {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Gaps.buildVGap(40),
          Icon(Icons.info, size: 36, color: Colors.grey),
          Gaps.vGap8,
          Text('尚未添加设备', style: TextStyle(fontSize: 15, color: Colors.grey)),
          Gaps.vGap16,
          RaisedButton(
            onPressed: _showBottomSheet,
            child: Icon(Icons.add, size: 70, color: Colors.grey),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                // 保留原来的边框样式
                color: Colors.grey,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            elevation: 0,
          )
        ],
      ),
    );
  }

  /// 模拟下拉刷新
  Future<void> _onRefresh(List list) async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        list.add("");
        LToast.show("刷新完成");
      });
    });
  }

  _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  Gaps.vGap10,
                  Row(
                    children: <Widget>[
                      Gaps.hGap16,
                      Text(
                        '添加设备',
                        style: TextStyle(fontSize: 16.0, color: Color(0xff666666)),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text("扫一扫"),
                    leading: Icon(Icons.center_focus_weak),
                    onTap: () {
                      LToast.show("扫一扫");
                    },
                  ),
                  ListTile(
                    title: Text("手动输入"),
                    leading: Icon(Icons.create),
                    onTap: () {
                      LToast.show("手动输入");
                    },
                  ),
                ],
              ),
            ));
  }
}
