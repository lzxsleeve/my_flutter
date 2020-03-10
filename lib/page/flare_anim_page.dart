import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///flare动画页 Create by lzx on 2020/3/6.

class FlareAnimPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlareAnimState();
  }
}

class _FlareAnimState extends State<FlareAnimPage> {
  var _controls = FlareControls();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: FlareActor(
        'assets/flare/Trim.flr',
        alignment: Alignment.center,
        animation: 'body_anim',
        fit: BoxFit.contain,
        color: Colors.black,
        controller: _controls,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
