import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 具有背景颜色的文本输入控制器 Create by lzx on 2019/12/11.
/// see: https://juejin.im/post/5def44086fb9a016266450c4

class BackgroundEditController extends TextEditingController {
  final TextStyle editingTextStyle;

  BackgroundEditController({
    String text,
    this.editingTextStyle = const TextStyle(backgroundColor: Colors.black12),
  }) : super(text: text);

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    if (!value.composing.isValid || !withComposing) {
      return TextSpan(style: style, text: text);
    }
    // -----此处就是正在输入的样式
//    final TextStyle composingStyle = style.merge(
//      const TextStyle(decoration: TextDecoration.underline),
//    );
    // -----↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--------
    final TextStyle composingStyle = style.merge(editingTextStyle);

    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(value.text)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(value.text),
        ),
        TextSpan(text: value.composing.textAfter(value.text)),
      ]);
  }
}
