import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/toast_util.dart';

/// 警报信息 Create by lzx on 2019/11/7.

class AlertPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlertState();
  }
}

class _AlertState extends State<AlertPage> {
  List _list = List();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (_list.isEmpty) {
            return _buildNotData();
          } else {
            return _buildNotData();
          }
        },
        itemCount: _list.length == 0 ? 1 : _list.length,
      ),
    );
  }

  _buildNotData() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[
          Icon(Icons.info, size: 36, color: Colors.grey),
          Gaps.vGap8,
          Text('没有消息', style: TextStyle(fontSize: 15, color: Colors.grey)),
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

    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        LToast.show("刷新完成");
      });
    });
  }
}
