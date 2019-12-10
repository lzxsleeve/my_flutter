import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/base/app_navigator.dart';
import 'package:my_flutter/base/global_config.dart';
import 'package:my_flutter/page/demo/help_list_page.dart';
import 'package:my_flutter/page/demo/message_center_page.dart';
import 'package:my_flutter/page/demo/pc_login_help_doc.dart';
import 'package:my_flutter/property/over_scroll_behavior.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/image_utils.dart';
import 'package:my_flutter/util/toast_util.dart';

import 'device_share_page.dart';
import 'operate_log_page.dart';

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
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 98,
            padding: EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: ImageUtils.getImageProvider('https://ws1.sinaimg.cn/large/0065oQSqly1g0ajj4h6ndj30sg11xdmj.jpg'),
                  radius: 33,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Name', style: TextStyle(fontSize: 18, color: GlobalConfig.text333)),
                        Text('x个设备', style: TextStyle(fontSize: 14, color: GlobalConfig.text999))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Text('ID:000000', style: TextStyle(color: GlobalConfig.text999)),
                  ),
                  onTap: () {
                    AppNavigator.push(context, PcLoginHelpDocPage());
                  },
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
              AppNavigator.push(context, DeviceSharePage());
            },
          ),
          Gaps.line,
          ListTile(
            dense: true,
            leading: Icon(Icons.info, size: 20),
            title: Text('消息中心'),
            trailing: Icon(Icons.arrow_forward_ios, size: 15),
            onTap: () {
              AppNavigator.push(context, MessageCenterPage());
            },
          ),
          Gaps.line,
          ListTile(
            dense: true,
            leading: Icon(Icons.build, size: 20),
            title: Text('操作日志'),
            trailing: Icon(Icons.arrow_forward_ios, size: 15),
            onTap: () {
              AppNavigator.push(context, OperateLogPage());
            },
          ),
          Gaps.line,
          ListTile(
            dense: true,
            leading: Icon(Icons.help, size: 20),
            title: Text('帮助'),
            trailing: Icon(Icons.arrow_forward_ios, size: 15),
            onTap: () {
              AppNavigator.push(context, HelpListPage());
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
      ),
    );
  }
}
