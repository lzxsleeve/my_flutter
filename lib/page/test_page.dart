import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/util/image_utils.dart';

/// 说明 Create by lzx on 2019/10/24.

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage> {

  String _name = 'desktop1';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image(
            image: ImageUtils.getAssetImage(_name, format: 'jpg'),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          right: 24,
          child: RaisedButton(
            child: Text('切换'),
            onPressed: () {
              setState(() {
                if (_name != 'desktop1') {
                  _name = 'desktop1';
                } else if (_name != 'desktop2') {
                  _name = 'desktop2';
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
