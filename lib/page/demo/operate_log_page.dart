import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/res/styles.dart';
import 'package:my_flutter/util/log_util.dart';
import 'package:my_flutter/util/toast_util.dart';
import 'package:my_flutter/widgets/smart_refresh_res.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 操作日志 Create by lzx on 2019/12/10.

class OperateLogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OperateLogState();
  }
}

class _OperateLogState extends State<OperateLogPage> {
  RefreshController _controller = RefreshController();
  List _list = List();
  bool _loadEnableState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('操作日志'),
        centerTitle: true,
      ),
      body: SmartRefreshRes.build(
        controller: _controller,
        child: _buildListView(),
        onRefresh: _onRefresh,
        onLoadMore: _onLoadMore,
        loadEnableState: _loadEnableState,
        onOffsetChange: (up, offset) {
          if (!up && !_loadEnableState && offset > 0) {
            setState(() {
              _loadEnableState = true;
            });
          }
        },
        header: SmartRefreshRes.buildClassicHeader(),
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
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gaps.vGap8,
              Text('GHX-0189', style: TextStyle(fontSize: 18)),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap4,
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('设备编号：HX-0198', style: TextStyles.textDark14),
                  ),
                  Expanded(
                    child: Text('设备名称：设备', style: TextStyles.textDark14),
                  )
                ],
              ),
              Gaps.vGap4,
              Text('海鲜机-开机', style: TextStyles.textDark14),
              Gaps.vGap4,
              Row(
                children: <Widget>[Icon(Icons.access_time, size: 14), Gaps.hGap4, Text('2019-12-10 11:09:26', style: TextStyles.textNormal14)],
              ),
              Gaps.vGap8,
            ],
          ),
        ),
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
        _loadEnableState = false;
      });
      LToast.show("刷新完成");

      _controller.refreshCompleted(resetFooterState: true);
    });
  }

  Future<void> _onLoadMore() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      _controller.loadNoData();
    });
  }
}
