import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 动画相关页面 Create by lzx on 2019/9/12.
class AnimViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimViewState();
  }
}

class _AnimViewState extends State<AnimViewPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: 0.0, end: 250.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
//    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: double.infinity),
          RaisedButton(
            onPressed: () {
              controller.forward();
            },
            child: Text('start'),
          ),
          RaisedButton(
            onPressed: () {
              controller.stop();
            },
            child: Text('stop'),
          ),
          Container(
            height: animation.value,
            width: animation.value,
            child: FlutterLogo(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
