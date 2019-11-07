import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/toast_util.dart';

/// 设备 Create by lzx on 2019/11/7.

class DevicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DeviceState();
  }
}

class _DeviceState extends State<DevicePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: <Widget>[
            Tab(text: '集群版(0)'),
            Tab(text: '单机版(0)'),
          ],
        ),
        body: TabBarView(
          children: <Widget>[_buildContent(), _buildContent()],
        ),
      ),
    );
  }

  _buildContent() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: 1, //列表长度+底部加载中提示
        itemBuilder: (context, index) {
          return _buildItem(index);
        },
      ),
    );
  }

  _buildItem(int index) {
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
  Future<void> _onRefresh() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
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
