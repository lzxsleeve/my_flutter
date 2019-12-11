import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/base/app_navigator.dart';
import 'package:my_flutter/property/over_scroll_behavior.dart';

import 'help_doc_page.dart';

/// 帮助 Create by lzx on 2019/12/10.

class HelpListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HelpListState();
  }
}

class _HelpListState extends State<HelpListPage> {
  List<String> _list = ['添加设备？', '修改目标温度？', '分享设备？'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('帮助'),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildItem(_list[index]);
          },
          itemCount: _list.length,
        ),
      ),
    );
  }

  _buildItem(String text) {
    return ListTile(
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_ios, size: 15),
      onTap: () {
        AppNavigator.push(context, HelpDocPage());
      },
    );
  }
}
