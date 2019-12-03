import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 带文字切换控件, 控件宽度需要自己调整 Create by lzx on 2019/11/30.

class TextSwitch extends StatefulWidget {
  String onText;
  String offText;
  bool initValue;
  ValueChanged<bool> onChanged;
  TextStyle textStyle;
  bool cupertinoStyle;

  TextSwitch({this.onText = 'On', this.offText = 'Off', this.initValue = true, this.onChanged, this.textStyle, this.cupertinoStyle = false});

  _TextSwitchState state;

  @override
  State<StatefulWidget> createState() {
    state = _TextSwitchState();
    return state;
  }

  get value {
    return state.value;
  }

  set value(bool b) {
    state.value = b;
  }
}

class _TextSwitchState extends State<TextSwitch> {
  bool _value;

  get value {
    return _value;
  }

  set value(bool b) {
    setState(() {
      _value = b;
    });
    //只更新自身，不触发widget.onChanged
  }

  @override
  void initState() {
    super.initState();
    _value = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
              child: new Text(
            _value ? widget.onText : widget.offText,
            style: widget.textStyle,
          )),
          new Container(
            //嵌套一个Container使点击Switch时也会改变其状态
            child: widget.cupertinoStyle
                ? CupertinoSwitch(
                    value: _value,
                    onChanged: (b) {
                      setState(() {
                        //要把改变后的值更新到switch中的value中去，手动复原时才会触发
                        _value = b;
                      });
                      widget.onChanged(b);
                    },
                  )
                : Switch(
                    value: _value,
                    onChanged: (b) {
                      setState(() {
                        //要把改变后的值更新到switch中的value中去，手动复原时才会触发
                        _value = b;
                      });
                      widget.onChanged(b);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
