import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 封装SmartRefresher 常用样式 Create by lzx on 2019/12/9.
///
/// SmartRefresher 通过继承StatefulWidget封装为组件时, 无法正常使用控制器 RefreshController(ps: StatelessWidget 也行不通), 所以通过静态构造方法来实现封装。
///
/// 缺点：setState()无法使用，故[loadEnableState] 的动态更新需要在外层通过[onOffsetChange]实现，无法封装。
///
/// * [loadEnableState] 主要用于控制底部加载增加的偏移量, 为null时底部加载圆圈会紧贴父件底部, 不影响组件的使用
///
/// {@tool sample}
///
/// 构建一个下拉刷新/上拉加载的组件
///
/// ```dart
/// SmartRefreshRes.build(
///   controller: _refreshController,
///   child: buildListView(),
///   onRefresh: (){
///     _refreshController.refreshCompleted()
///   },
///   onLoadMore: (){
///     _refreshController.loadCompleted()
///   },
///   onOffsetChange: (up, offset) {
///     if (!up && !_loadEnableState && offset > 0) {
///       setState(() {
///         _loadEnableState = true;
///       });
///     }
///   },
///   loadEnableState: _loadEnableState),
/// )
/// ```
/// {@end-tool}

class SmartRefreshRes {
  static Widget build({
    @required RefreshController controller,
    @required Widget child,
    @required Function onRefresh,
    Function onLoadMore,
    OnOffsetChange onOffsetChange,
    loadEnableState = false,
    hasLoad = true,
    Widget header,
    Widget footer,
  }) {
    return _buildRefreshConfiguration(
      loadEnableState: loadEnableState,
      child: _buildSmartRefresher(
        controller: controller,
        child: child,
        onRefresh: onRefresh,
        onLoadMore: onLoadMore,
        onOffsetChange: onOffsetChange,
        hasLoad: hasLoad,
        header: header,
        footer: footer,
      ),
    );
  }

  /// SmartRefresher 常用配置
  static _buildRefreshConfiguration({@required Widget child, bool loadEnableState = false}) {
    return RefreshConfiguration(
      enableBallisticLoad: false,
      footerTriggerDistance: -60,
      maxUnderScrollExtent: loadEnableState ? 10 : 0,
      hideFooterWhenNotFull: true,
      child: child,
    );
  }

  /// 构建 SmartRefresher
  /// child的详细说明 see: [ https://github.com/peng8350/flutter_pulltorefresh/blob/master/README_CN.md/#对smartrefresher里child详细说明 ]
  static _buildSmartRefresher({
    @required RefreshController controller,
    @required Widget child,
    @required Function onRefresh,
    Function onLoadMore,
    OnOffsetChange onOffsetChange,
    hasLoad = true,
    Widget header,
    Widget footer,
  }) {
    return SmartRefresher(
      controller: controller,
      enablePullDown: true,
      enablePullUp: hasLoad,
      onOffsetChange: onOffsetChange,
      header: header ?? (Platform.isAndroid ? null : buildClassicHeader()),
      footer: footer ?? buildClassicFooter(),
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      child: child,
    );
  }

  /// 常用刷新样式
  static Widget buildClassicHeader() {
    return ClassicHeader(
      failedText: '刷新失败',
      idleText: '下拉刷新',
      completeText: '刷新完成',
      refreshingText: '正在刷新',
      releaseText: '松开刷新数据',
    );
  }

  /// 常用加载样式
  static Widget buildClassicFooter() {
    return ClassicFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      loadingText: '正在加载...',
      canLoadingText: '松开加载更多!',
      idleText: '上拉加载更多',
      failedText: '加载失败!',
      noDataText: '没有更多数据了!',
    );
  }
}
