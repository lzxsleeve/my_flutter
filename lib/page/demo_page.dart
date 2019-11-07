import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/page/demo/device_page.dart';
import 'package:my_flutter/page/demo/person_page.dart';
import 'package:my_flutter/page/demo/product_page.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:my_flutter/util/toast_util.dart';

import 'demo/alert_page.dart';

/// Demo页面 Create by lzx on 2019/11/6.

class DemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemoState();
  }
}

class _DemoState extends State<DemoPage> {
  var _title = '设备管理';
  var titleList = ['设备管理', '产品', '警报信息', '我的'];
  var _currentIndex = 0;
  final PageController _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        actions: <Widget>[
          _currentIndex == 0
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _showBottomSheet();
                  },
                )
              : Container()
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[DevicePage(), ProductPage(), AlertPage(), PersonPage()],
      ),
//      body: PageView.builder(
//        // 禁用左右滑动
//        physics: NeverScrollableScrollPhysics(),
//        onPageChanged: (index) {
//          _pageChange(index);
//        },
//        controller: _pageController,
//        itemBuilder: (BuildContext context, int index) {
//          if (index == 0) {
//            return DevicePage();
//          } else if (index == 1) {
//            return ProductPage();
//          } else if (index == 2) {
//            return AlertPage();
//          } else if (index == 3) {
//            return PersonPage();
//          }
//          return Container();
//        },
//        itemCount: 4,
//      ),
    );
  }

  void _pageChange(int index) {
    setState(() {
      _title = titleList[index];
      _currentIndex = index;
    });
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.important_devices), title: new Text('设备')),
        BottomNavigationBarItem(icon: Icon(Icons.developer_board), title: new Text('产品')),
        BottomNavigationBarItem(icon: Icon(Icons.warning), title: new Text('警报')),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: new Text('我的')),
      ],
      currentIndex: _currentIndex,
      onTap: (int i) {
        _pageChange(i);
        _pageController.jumpToPage(i);
//        _pageController.animateToPage(i, duration: Duration(milliseconds: 400), curve: Curves.ease);
      },
    );
  }

  Widget _buildContent(String text, Color color) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: color,
      child: Center(
        child: Text(text),
      ),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  Gaps.vGap10,
                  Row(
                    children: <Widget>[
                      Gaps.hGap16,
                      Text(
                        '添加设备',
                        style: TextStyle(fontSize: 16.0, color: Color(0xff666666)),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text("扫一扫"),
                    leading: Icon(Icons.center_focus_weak),
                    onTap: () {
                      LToast.show("扫一扫");
                    },
                  ),
                  ListTile(
                    title: Text("手动输入"),
                    leading: Icon(Icons.create),
                    onTap: () {
                      LToast.show("手动输入");
                    },
                  ),
                ],
              ),
            ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
