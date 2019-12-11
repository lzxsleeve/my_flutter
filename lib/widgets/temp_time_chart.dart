import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter/util/log_util.dart';

/// 温度时间线形图 Create by lzx on 2019/12/2.
class SimpleTimeSeriesChart extends StatelessWidget {
  final List<TimeSeriesTemp> data;
  final bool animate;
  final Function(DateTime time, num) selectFun;
  final String timeFormat;

  SimpleTimeSeriesChart(this.data, {this.animate, this.selectFun, this.timeFormat});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      dataToSeriesList(data),
      animate: animate,
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          zeroBound: false,
          desiredTickCount: 4,
        ),
        /// 格式化纵坐标数字格式
        tickFormatterSpec: charts.BasicNumericTickFormatterSpec.fromNumberFormat(NumberFormat('0℃')),
      ),
      domainAxis: charts.DateTimeAxisSpec(
        /// 格式化横坐标时间格式
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          hour: charts.TimeFormatterSpec(format: 'HH:mm', transitionFormat: timeFormat ?? 'HH:mm'),
        ),
      ),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        charts.LinePointHighlighter(
          showHorizontalFollowLine: charts.LinePointHighlighterFollowLineType.none,
          showVerticalFollowLine: charts.LinePointHighlighterFollowLineType.nearest,
        ),
        charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag),
      ],
      /// 选择模式
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: (charts.SelectionModel model) {
            final selectedDatum = model.selectedDatum;
            DateTime time;
            final measures = <String, num>{};
            if (selectedDatum.isNotEmpty) {
              time = selectedDatum.first.datum.time;
              selectedDatum.forEach((charts.SeriesDatum datumPair) {
                measures[datumPair.series.displayName] = datumPair.datum.sales;
              });
            }
            LogUtil.d("time=$time,measures=$measures");
            selectFun(time, measures['temp']);
          },
        )
      ],
    );
  }

  /// List<TimeSeriesSales> 转 List<charts.Series<TimeSeriesSales, DateTime>>
  static List<charts.Series<TimeSeriesTemp, DateTime>> dataToSeriesList(List<TimeSeriesTemp> data) {
    return [
      charts.Series<TimeSeriesTemp, DateTime>(
        id: 'temp',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesTemp sales, _) => sales.time,
        measureFn: (TimeSeriesTemp sales, _) => sales.temp,
        data: data,
      )
    ];
  }

  /// Create one series with sample hard coded data.
  static List<TimeSeriesTemp> _createSampleData() {
    return [
      TimeSeriesTemp(DateTime(2019, 11, 30, 12, 0, 0), 21.5),
      TimeSeriesTemp(DateTime(2019, 11, 30, 12, 30, 0), 22.6),
      TimeSeriesTemp(DateTime(2019, 11, 30, 13, 0, 0), 21.0),
      TimeSeriesTemp(DateTime(2019, 11, 30, 13, 30, 0), 26.3),
      TimeSeriesTemp(DateTime(2019, 11, 30, 14, 0, 0), 31.1),
      TimeSeriesTemp(DateTime(2019, 11, 30, 14, 30, 0), 24.4),
      TimeSeriesTemp(DateTime(2019, 11, 30, 15, 0, 0), 25.1),
      TimeSeriesTemp(DateTime(2019, 11, 30, 15, 30, 0), 24.9),
      TimeSeriesTemp(DateTime(2019, 11, 30, 16, 0, 0), 22.3),
      TimeSeriesTemp(DateTime(2019, 11, 30, 16, 30, 0), 19.8),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesTemp {
  final DateTime time;
  final double temp;

  TimeSeriesTemp(this.time, this.temp);
}
