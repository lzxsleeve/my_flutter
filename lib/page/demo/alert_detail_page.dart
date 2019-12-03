import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/property/over_scroll_behavior.dart';
import 'package:my_flutter/res/styles.dart';

/// 报警详情 Create by lzx on 2019/12/2.

class AlertDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlertDetailState();
  }
}

class _AlertDetailState extends State<AlertDetailPage> {
  List<String> titleList = ['编号', '设备编号', '设备名称', '报警名称', '报警原因', '处理方式', '开始时间', '结束时间', '持续'];
  List<String> contentList = [
    'GHX-0189',
    'HX_0198',
    '设备名',
    '翅片温度闯过去故障',
    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    '2019-12-2 18:24:19',
    '2019-12-2 18:24:30',
    '11秒'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('报警信息明细'),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildTextTile(titleList[index], contentList[index]);
          },
          itemCount: titleList.length,
        ),
      ),
    );
  }

  _buildTextTile(String title, String content) {
    return Container(
      height: 50,
      child: ListTile(
        title: Text(content, style: TextStyles.textDark14),
        leading: Container(
          width: 60,
          child: Text(title, style: TextStyles.textNormal14),
        ),
      ),
    );
  }
}
