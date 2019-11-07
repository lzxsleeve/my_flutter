import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/base/global_config.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/image_utils.dart';
import 'package:my_flutter/util/toast_util.dart';

/// 我的 Create by lzx on 2019/11/6.

class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonState();
  }
}

class _PersonState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 98,
          padding: EdgeInsets.all(16),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: ImageUtils.getImageProvider('https://ws1.sinaimg.cn/large/0065oQSqly1g0ajj4h6ndj30sg11xdmj.jpg'),
                radius: 33,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 86, top: 12),
                child: Column(
                  children: <Widget>[
                    Text('Name', style: TextStyle(fontSize: 18, color: GlobalConfig.text333)),
                    Text('x个设备', style: TextStyle(fontSize: 14, color: GlobalConfig.text999))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text('ID:000000', style: TextStyle(color: GlobalConfig.text999)),
              )
            ],
          ),
        ),
        Container(height: 6, color: Colors.grey[100]),
        ListTile(
          dense: true,
          leading: Icon(Icons.share, size: 20),
          title: Text('设备分享'),
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () {
            LToast.show('设备分享');
          },
        ),
        Gaps.line,
        ListTile(
          dense: true,
          leading: Icon(Icons.info, size: 20),
          title: Text('消息中心'),
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () {
            LToast.show('消息中心');
          },
        ),
        Gaps.line,
        ListTile(
          dense: true,
          leading: Icon(Icons.build, size: 20),
          title: Text('操作日志'),
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () {
            LToast.show('操作日志');
          },
        ),
        Gaps.line,
        ListTile(
          dense: true,
          leading: Icon(Icons.help, size: 20),
          title: Text('帮助'),
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () {
            LToast.show('帮助');
          },
        ),
        Gaps.line,
        ListTile(
          dense: true,
          leading: Icon(Icons.settings, size: 20),
          title: Text('设置'),
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () {
            LToast.show('设置');
          },
        ),
        Gaps.line,
        ListTile(
          dense: true,
          leading: Icon(Icons.subdirectory_arrow_left, size: 20),
          title: Text('退出登录'),
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () {
            LToast.show('退出登录');
          },
        ),
        Gaps.line,
      ],
    );
  }
}
