import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/property/over_scroll_behavior.dart';
import 'package:my_flutter/res/gaps.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:my_flutter/widgets/temp_time_chart.dart';

/// 设备参数详情 Create by lzx on 2019/11/30.

class DeviceDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DeviceDetailState();
  }
}

class _DeviceDetailState extends State<DeviceDetailPage> {
  List<bool> isSelected = [true, false, false, false, false];
  bool chartData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设备参数'),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 60,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    Positioned(left: 0, child: Text('HX-0199', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                    Positioned(right: 0, child: Text('运行中', style: TextStyle(color: Colors.green)))
                  ],
                ),
              ),
              Text('设备名', style: TextStyle(fontSize: 16)),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap8,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildToggleButton('1小时', 0, isSelected[0]),
                  _buildToggleButton('6小时', 1, isSelected[1]),
                  _buildToggleButton('12小时', 2, isSelected[2]),
                  _buildToggleButton('1天', 3, isSelected[3]),
                  _buildToggleButton('3天', 4, isSelected[4]),
                ],
              ),
              Gaps.vGap8,
              Text('水箱平均温度'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 200,
                child: SimpleTimeSeriesChart(chartData ? _sampleData() : _sampleData1()),
              ),
              Gaps.vGap8,
              Gaps.line,
              _buildTextTile('目标温度', '21.5℃'),
              _buildTextTile('压缩机启停间隔', ''),
              _buildTextTile('应急运行时间', ''),
              _buildTextTile('故障压缩机停机时间', ''),
              _buildTextTile('开机方式', ''),
              _buildTextTile('工作模式', ''),
              _buildTextTile('控制方式', ''),
              _buildTextTile('操作等级', ''),
              _buildTextTile('控制精度', ''),
            ],
          ),
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<TimeSeriesSales> _sampleData() {
    return [
      TimeSeriesSales(DateTime(2019, 11, 30, 12, 0, 0), 21.5),
      TimeSeriesSales(DateTime(2019, 11, 30, 12, 30, 0), 22.6),
      TimeSeriesSales(DateTime(2019, 11, 30, 13, 0, 0), 21.0),
      TimeSeriesSales(DateTime(2019, 11, 30, 13, 30, 0), 26.3),
      TimeSeriesSales(DateTime(2019, 11, 30, 14, 0, 0), 31.1),
      TimeSeriesSales(DateTime(2019, 11, 30, 14, 30, 0), 24.4),
      TimeSeriesSales(DateTime(2019, 11, 30, 15, 0, 0), 25.1),
      TimeSeriesSales(DateTime(2019, 11, 30, 15, 30, 0), 24.9),
      TimeSeriesSales(DateTime(2019, 11, 30, 16, 0, 0), 22.3),
      TimeSeriesSales(DateTime(2019, 11, 30, 16, 30, 0), 19.8),
    ];
  }

  List<TimeSeriesSales> _sampleData1() {
    return [
      TimeSeriesSales(DateTime(2019, 11, 30, 12, 0, 0), 20.5),
      TimeSeriesSales(DateTime(2019, 11, 30, 12, 30, 0), 25.6),
      TimeSeriesSales(DateTime(2019, 11, 30, 13, 0, 0), 24.0),
      TimeSeriesSales(DateTime(2019, 11, 30, 13, 30, 0), 29.3),
      TimeSeriesSales(DateTime(2019, 11, 30, 14, 0, 0), 21.1),
      TimeSeriesSales(DateTime(2019, 11, 30, 14, 30, 0), 27.4),
      TimeSeriesSales(DateTime(2019, 11, 30, 15, 0, 0), 26.1),
      TimeSeriesSales(DateTime(2019, 11, 30, 15, 30, 0), 23.9),
      TimeSeriesSales(DateTime(2019, 11, 30, 16, 0, 0), 21.3),
      TimeSeriesSales(DateTime(2019, 11, 30, 16, 30, 0), 28.8),
    ];
  }

  _buildTextTile(String title, String content) {
    return Container(
      height: 48,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[Positioned(left: 0, child: Text(title)), Positioned(right: 0, child: Text(content))],
      ),
    );
  }

  _buildToggleButton(String text, int index, bool isSelect) {
    return Container(
      width: 72,
      height: 28,
      child: RaisedButton(
        onPressed: () {
          toggleFun(index);
        },
        child: Text(text, style: TextStyle(fontSize: 12)),
        elevation: isSelect ? 4 : 0,
        color: isSelect ? Colors.green[350] : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        highlightElevation: 0,
      ),
    );
  }

  void toggleFun(int index) {
    setState(() {
      for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
        if (buttonIndex == index) {
          chartData = !chartData;
          isSelected[buttonIndex] = true;
        } else {
          isSelected[buttonIndex] = false;
        }
      }
    });
  }
}
