import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 说明 Create by lzx on 2019/10/24.

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage> {
  RefreshController _refreshController = RefreshController();

  List<String> data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  Widget buildCtn() {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (c, i) => _buildListItem(
        data[i],
      ),
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          color: Colors.greenAccent,
        );
      },
      itemCount: data.length,
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshController.loadNoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshConfiguration(
        enableBallisticLoad: false,
        footerTriggerDistance: -80,
        maxUnderScrollExtent: 60,
        child: SmartRefresher(
          enablePullUp: true,
          footer: ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          child: buildCtn(),
          onLoading: () async {
            await Future.delayed(Duration(milliseconds: 1000));
//            for(int i =0 ;i<5;i++)
//            data.add("1");
//            SmartRefresher.ofState(context).setState((){
//
//            });
            _refreshController.loadFailed();
          },
          controller: _refreshController,
        ),
      ),
      appBar: AppBar(),
    );
  }

  _buildListItem(String text) {
    return Container(
      height: 50,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
