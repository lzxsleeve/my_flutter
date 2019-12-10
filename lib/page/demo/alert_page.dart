import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/base/app_navigator.dart';
import 'package:my_flutter/page/demo/alert_detail_page.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/image_utils.dart';
import 'package:my_flutter/util/log_util.dart';
import 'package:my_flutter/util/toast_util.dart';
import 'package:my_flutter/widgets/smart_refresh_res.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 警报信息 Create by lzx on 2019/11/7.

class AlertPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlertState();
  }
}

class _AlertState extends State<AlertPage> {
  RefreshController _refreshController = RefreshController();
  List _list = List();
  bool _loadEnableState = false;

  @override
  Widget build(BuildContext context) {
    return SmartRefreshRes.build(
        controller: _refreshController,
        child: _buildListView(),
        onRefresh: _onRefresh,
        onLoadMore: _onLoadMore,
        onOffsetChange: (up, offset) {
          if (!up && !_loadEnableState && offset > 0) {
            setState(() {
              _loadEnableState = true;
            });
          }
        },
        loadEnableState: _loadEnableState);
  }

  _buildNotData() {
    return Container(
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

  _buildListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (_list.length == 0) {
          return _buildNotData();
        } else {
          return _buildListItem(index);
        }
      },
      itemCount: _list.length == 0 ? 1 : _list.length,
    );
  }

  _buildListItem(int index) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            AppNavigator.push(context, AlertDetailPage());
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            height: 100,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  child: Column(
                    children: <Widget>[
                      Image.asset(ImageUtils.getImgPath('alert2'), width: 40, height: 40),
                      Gaps.vGap5,
                      Text('2019-11-27', style: TextStyle(fontSize: 10, color: Color(0xff999999))),
                      Gaps.vGap5,
                      Text('15:17:12', style: TextStyle(fontSize: 12, color: Color(0xff777777)))
                    ],
                  ),
                ),
                Positioned(
                  left: 70,
                  top: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[Text('设备: GHX-0189'), Gaps.hGap5, Text('1.XXXX')],
                      ),
                      Gaps.vGap4,
                      Text('翅片温度传感器故障'),
                      Gaps.vGap4,
                      Row(
                        children: <Widget>[
                          Text('持续: 20秒', style: TextStyle(fontSize: 12)),
                          Gaps.hGap5,
                          Text('结束时间: 11-27 15:18:14', style: TextStyle(fontSize: 12))
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Text('已处理', style: TextStyle(fontSize: 12, color: Colors.green)),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Gaps.line,
        )
      ],
    );
  }

  /// 模拟下拉刷新
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        _list.add("");
        _list.add("");
        _list.add("");
        _list.add("");
        _loadEnableState = false;
      });
      LToast.show("刷新完成");
      _refreshController.refreshCompleted(resetFooterState: true);
    });
  }

  Future<void> _onLoadMore() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      _refreshController.loadNoData();
    });
  }
}
