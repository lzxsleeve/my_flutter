import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/res/styles.dart';
import 'package:my_flutter/util/log_util.dart';

/// 时间轴组件Item Create by lzx on 2019/12/9.

class TimeLineItem extends StatefulWidget {
  const TimeLineItem({@required this.text, @required this.time, this.hasLast = true, this.hasNext = true});

  final String text;
  final String time;
  final bool hasLast;
  final bool hasNext;

  @override
  State<StatefulWidget> createState() {
    return _TimeLineItemState();
  }
}

class _TimeLineItemState extends State<TimeLineItem> {
  double item_height = 0.0;
  GlobalKey textKey = new GlobalKey();

  @override
  void initState() {
    super.initState();

    ///  监听是否渲染完
    WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback) {
      ///  获取相应控件的size
      RenderObject renderObject = textKey.currentContext.findRenderObject();
      setState(() {
        item_height = renderObject.semanticBounds.size.height;
      });
      LogUtil.d("高度：$item_height");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: item_height, // 高度需自适应
          child: Column(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  width: 0.6,
                  child: DecoratedBox(decoration: BoxDecoration(color: widget.hasLast ? Colors.grey : Colors.transparent)),
                ),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 0.6,
                  child: DecoratedBox(decoration: BoxDecoration(color: widget.hasNext ? Colors.grey : Colors.transparent)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            key: textKey,
            padding: EdgeInsets.only(left: 16, top: widget.hasLast ? 12 : 0, bottom: widget.hasNext ? 12 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.text),
                Text(widget.time, style: TextStyles.textNormal12),
              ],
            ),
          ),
        )
      ],
    );
  }
}
