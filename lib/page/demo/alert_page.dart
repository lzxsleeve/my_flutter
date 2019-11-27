import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/log_util.dart';
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
  bool _enableLoadMore = false;

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      enableBallisticLoad: false,
      footerTriggerDistance: -60,
      maxUnderScrollExtent: _enableLoadMore ? 10 : 0,
      hideFooterWhenNotFull: true,
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onOffsetChange: (up, offset) {
          LogUtil.d("isUp=$up,offset=$offset");
          if (!up && !_enableLoadMore) {
            setState(() {
              _enableLoadMore = true;
            });
          }
        },
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          loadingText: '正在加载...',
          canLoadingText: '松手,加载更多!',
          idleText: '上拉加载更多',
          failedText: '加载失败!',
          noDataText: '没有更多数据了!',
        ),
        onRefresh: () => _onRefresh(),
        onLoading: () => _onLoadMore(),
        child: _buildListView(),
      ),
    );
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
    return Container(
      height: 80,
      child: Center(
        child: Text(index.toString()),
      ),
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

        _enableLoadMore = false;
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
