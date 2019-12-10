import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/property/over_scroll_behavior.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/image_utils.dart';

/// 帮助文档 Create by lzx on 2019/12/10.

class HelpDocPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HelpDocState();
  }
}

class _HelpDocState extends State<HelpDocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('帮助文档'),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildItem();
          },
          itemCount: 1,
        ),
      ),
    );
  }

  _buildItem() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Card(
        elevation: 4,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('标题', style: TextStyle(fontSize: 24)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Image(
                width: double.infinity,
                image: ImageUtils.getImageProvider('http://www.gddelin.net/UserFile/form/DOC_HELP/0000-0500/0000/1565581932(1).jpg'),
              ),
            ),
            Gaps.vGap16
          ],
        ),
      ),
    );
  }
}
