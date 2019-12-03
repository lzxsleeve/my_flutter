import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/temp_time_chart.dart';

/// 说明 Create by lzx on 2019/10/24.

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 200,
          child: SimpleTimeSeriesChart.withSampleData(),
        ),
      ),
      appBar: AppBar(),
    );
  }
}

