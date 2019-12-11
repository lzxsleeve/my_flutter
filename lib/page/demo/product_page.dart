import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/property/over_scroll_behavior.dart';

/// 产品 Create by lzx on 2019/11/7.

class ProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductState();
  }
}

class _ProductState extends State<ProductPage> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView.builder(
          controller: _controller,
          physics: ClampingScrollPhysics(),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return _buildListItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Container(
      width: double.infinity,
      child: Image.asset(getImgPath((index + 1).toString())),
    );
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/product/$name.$format';
  }
}
