import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 封装下拉刷新和下拉加载的List Create by lzx on 2019/11/20.

class MyRefreshList extends StatefulWidget {
  const MyRefreshList({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.onRefresh,
    @required this.controller,
    this.onLoadMore,
    this.hasMore: false,
    this.itemExtent,
    this.header,
    this.footer,
    this.padding,
  })  : assert(controller != null),
        super(key: key);

  final RefreshController controller;
  final RefreshCallback onRefresh;
  final LoadMoreCallback onLoadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final double itemExtent;
  final Widget header;
  final Widget footer;
  final EdgeInsetsGeometry padding;

  @override
  State<StatefulWidget> createState() {
    return _MyRefreshList();
  }
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _MyRefreshList extends State<MyRefreshList> {
  bool _enableLoadMore = false;

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      enableBallisticLoad: false,
      footerTriggerDistance: -60,
      maxUnderScrollExtent: _enableLoadMore ? 10 : 0,
      hideFooterWhenNotFull: true,
      child: SmartRefresher(
        controller: widget.controller,
        enablePullDown: true,
        enablePullUp: true,
        onOffsetChange: (up, offset) {
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
        onRefresh: () {
          setState(() {
            _enableLoadMore = false;
            widget.onRefresh();
          });
        },
        onLoading: () => widget.onLoadMore,
        child: ListView.builder(itemCount: widget.itemCount, padding: widget.padding, itemExtent: widget.itemExtent, itemBuilder: widget.itemBuilder),
      ),
    );
  }
}

