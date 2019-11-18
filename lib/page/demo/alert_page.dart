import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/property/over_scroll_behavior.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/toast_util.dart';
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

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: RefreshConfiguration(
        enableBallisticLoad: false,
        footerTriggerDistance: -80,
        maxUnderScrollExtent: 60,
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          footer: ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          onRefresh: () => _onRefresh(),
          onLoading: () => _onLoadMore(),
          child: _list.isEmpty ? _buildNotData() : _buildListView(),
        ),
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

  _buildListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildListItem(index);
      },
      itemCount: _list.length,
    );
  }

  _buildListItem(int index) {
    return Container(
      height: 80,
      child: Center(
        child: Text(index.toString()),
      ),
    );
  }

  /// 模拟下拉刷新
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _list.add("");
        _list.add("");
        _list.add("");
        _list.add("");
      });
      LToast.show("刷新完成");
      _refreshController.refreshCompleted(resetFooterState: true);
    });
  }

  Future<void> _onLoadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      _refreshController.loadNoData();
    });
  }
}
