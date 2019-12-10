import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/res/styles.dart';
import 'package:my_flutter/util/log_util.dart';
import 'package:my_flutter/util/toast_util.dart';
import 'package:my_flutter/widgets/smart_refresh_res.dart';
import 'package:my_flutter/widgets/time_line_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 消息中心 Create by lzx on 2019/12/9.

class MessageCenterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessageCenterState();
  }
}

class _MessageCenterState extends State<MessageCenterPage> {
  RefreshController _refreshController = RefreshController();
  List<MsgItem> _list = List();
  bool _loadEnableState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息中心'),
        centerTitle: true,
      ),
      body: SmartRefreshRes.build(
        controller: _refreshController,
        child: _buildListView(),
        onRefresh: _onRefresh,
        onLoadMore: _onLoadMore,
        onOffsetChange: (up, offset) {
          LogUtil.d("isUp:$up,offset:$offset");
          if (!up && !_loadEnableState && offset > 0) {
            setState(() {
              _loadEnableState = true;
            });
          }
        },
        loadEnableState: _loadEnableState,
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
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(_list[index].day, style: TextStyle(fontSize: 24)),
              Gaps.hGap4,
              Expanded(
                flex: 1,
                child: Text(_list[index].month, style: TextStyles.textNormal12),
              ),
              Text(_list[index].week, style: TextStyles.textNormal12)
            ],
          ),
          Gaps.vGap12,
          Column(
            children: getContentWidgetList(_list[index].childList),
          ),
        ],
      ),
    );
  }

  /// 模拟下拉刷新
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        _list = getList();
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

  // 获取时间轴Item集合
  List<Widget> getContentWidgetList(List<MsgItemChild> list) {
    List<Widget> widgetList = new List<Widget>();

    if (list.length == 1) {
      widgetList.add(TimeLineItem(text: list[0].text, time: list[0].time, hasLast: false, hasNext: false));
      return widgetList;
    }

    for (int i = 0; i < list.length; i++) {
      if (i == 0) {
        widgetList.add(TimeLineItem(text: list[i].text, time: list[i].time, hasLast: false));
      } else if (i == list.length - 1) {
        widgetList.add(TimeLineItem(text: list[i].text, time: list[i].time, hasNext: false));
      } else {
        widgetList.add(TimeLineItem(text: list[i].text, time: list[i].time));
      }
    }
    return widgetList;
  }

  // 模拟数据
  List<MsgItem> getList() {
    List<MsgItem> list = new List<MsgItem>();

    List<MsgItemChild> childList0 = new List<MsgItemChild>();
    childList0.add(MsgItemChild('我收到 王五 分享给我的 12 个设备', '16:04'));
    list.add(MsgItem('14', '11月', '星期四', childList0));

    List<MsgItemChild> childList1 = new List<MsgItemChild>();
    childList1.add(MsgItemChild('我被 李四 删除设备', '20:43'));
    childList1.add(MsgItemChild('我收到 李四 分享给我的 6 个设备', '18:39'));
    childList1.add(MsgItemChild('我被 李四 删除设备', '18:39'));
    childList1.add(MsgItemChild('我收到 李四 分享给我的 3 个设备', '17:50'));
    childList1.add(MsgItemChild('我被 李四 删除设备', '17:30'));
    list.add(MsgItem('04', '11月', '星期一', childList1));

    List<MsgItemChild> childList2 = new List<MsgItemChild>();
    childList2.add(MsgItemChild('我收到 张三 分享给我的 8 个设备', '18:00'));
    childList2.add(MsgItemChild('我被 张三 删除设备', '15:10'));
    list.add(MsgItem('02', '11月', '星期六', childList2));

    return list;
  }
}

class MsgItem {
  String day;
  String month;
  String week;
  List<MsgItemChild> childList;

  MsgItem(String day, String month, String week, List<MsgItemChild> childList) {
    this.day = day;
    this.month = month;
    this.week = week;
    this.childList = childList;
  }
}

class MsgItemChild {
  String text;
  String time;

  MsgItemChild(String text, String time) {
    this.text = text;
    this.time = time;
  }
}
