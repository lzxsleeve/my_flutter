import 'package:flutter/material.dart';
import 'package:my_flutter/property/over_scroll_behavior.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/res/styles.dart';
import 'package:my_flutter/util/image_utils.dart';

/// 帮助文档  pc登录文档 Create by lzx on 2019/12/10.

class PcLoginHelpDocPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PcLoginHelpState();
  }
}

class _PcLoginHelpState extends State<PcLoginHelpDocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('帮助文档'),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                Gaps.vGap16,
                Text('电脑端登录帮助文档', style: TextStyle(fontSize: 24)),
                Gaps.vGap16,
                Image(image: ImageUtils.getAssetImage('pc_login_1')),
                Gaps.vGap8,
                Text('登录地址: http://www.gddelin.net', style: TextStyles.textNormal14),
                Gaps.vGap8,
                Image(image: ImageUtils.getAssetImage('pc_login_2', format: 'jpg')),
                Gaps.vGap8,
                Image(image: ImageUtils.getAssetImage('pc_login_3')),
                Gaps.vGap16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
