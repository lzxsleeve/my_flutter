import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/base/app_navigator.dart';
import 'package:my_flutter/page/demo/device_detail_page.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/image_utils.dart';
import 'package:my_flutter/util/log_util.dart';
import 'package:my_flutter/util/toast_util.dart';
import 'package:my_flutter/widgets/text_switch.dart';

/// 设备列表 Create by lzx on 2019/12/2.

class DeviceListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DeviceListState();
  }
}

class _DeviceListState extends State<DeviceListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('设备列表'),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _headItem();
            } else {
              return _buildDeviceItem();
            }
          },
          itemCount: 3,
        ));
  }

  _headItem() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      height: 150,
      child: Card(
        elevation: 4,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 16,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(ImageUtils.getImgPath('cluster'), width: 60, height: 60),
                  Gaps.vGap4,
                  Text('在线', style: TextStyle(color: Colors.green))
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 92,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('GHX-0189', style: TextStyle(fontWeight: FontWeight.bold)),
                  Gaps.vGap8,
                  Text('条形码：SN_00000000000000000000'),
                  Gaps.vGap8,
                  Text('经销商：'),
                  Gaps.vGap8,
                  Text('客户：')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildDeviceItem() {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, DeviceDetailPage());
      },
      child: Container(
        height: 180,
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Card(
          color: Colors.green,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 12,
                left: 12,
                child: Text(
                  '254. 东露阳',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '运行中',
                    style: TextStyle(color: Colors.white, shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 4)]),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('23.6', style: TextStyle(fontSize: 50, color: Colors.white)),
                      Text('℃', style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 70,
                      child: TextSwitch(
                        onText: '开',
                        offText: '关',
                        textStyle: TextStyle(color: Colors.white),
                        initValue: true,
                        onChanged: (value) {
                          LogUtil.d("Switch: true");
                        },
                      ),
                    ),
                    Gaps.vGap8,
                    GestureDetector(
                      onTap: () {
                        LToast.show("目标温度点击");
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('22.3℃', style: TextStyle(color: Colors.white)),
                          Text('目标温度', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
