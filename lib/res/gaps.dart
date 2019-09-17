import 'package:flutter/widgets.dart';
import 'colors.dart';

/// 间隔
class Gaps {
  /// 常用水平间隔
  static const Widget hGap4 = const SizedBox(width: 4.0);
  static const Widget hGap5 = const SizedBox(width: 5.0);
  static const Widget hGap8 = const SizedBox(width: 8.0);
  static const Widget hGap10 = const SizedBox(width: 10.0);
  static const Widget hGap12 = const SizedBox(width: 12.0);
  static const Widget hGap15 = const SizedBox(width: 15.0);
  static const Widget hGap16 = const SizedBox(width: 16.0);

  /// 常用垂直间隔
  static const Widget vGap4 = const SizedBox(height: 4.0);
  static const Widget vGap5 = const SizedBox(height: 5.0);
  static const Widget vGap8 = const SizedBox(height: 8.0);
  static const Widget vGap10 = const SizedBox(height: 10.0);
  static const Widget vGap12 = const SizedBox(height: 12.0);
  static const Widget vGap15 = const SizedBox(height: 15.0);
  static const Widget vGap16 = const SizedBox(height: 16.0);

  static Widget line = const SizedBox(
    height: 0.6,
    width: double.infinity,
    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
  );

  ///自定义水平间隔
  static Widget buildHGap(double width) {
    return SizedBox(width: width);
  }

  ///自定义垂直间隔
  static Widget buildVGap(double height) {
    return SizedBox(height: height);
  }

  static const Widget empty = const SizedBox();
}
