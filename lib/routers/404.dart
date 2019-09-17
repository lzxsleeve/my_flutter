import 'package:flutter/material.dart';
import 'package:my_flutter/res/styles.dart';

class WidgetNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('错误'),
      ),
      body: const Center(
        child: Text(
          '页面不存在',
          style: TextStyles.textDark16,
        ),
      ),
    );
  }
}
