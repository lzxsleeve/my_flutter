import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter/util/log_util.dart';

/// 温度时间线形图 Create by lzx on 2019/12/2.
class SimpleTimeSeriesChart extends StatelessWidget {
  final List<TimeSeriesSales> data;
  final bool animate;
  final Function(DateTime time, num) selectFun;

  SimpleTimeSeriesChart(this.data, {this.animate, this.selectFun});

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
          tickFormatterSpec: charts.BasicNumericTickFormatterSpec.fromNumberFormat(NumberFormat('0℃'))),
      domainAxis: charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          hour: charts.TimeFormatterSpec(format: 'HH:mm', transitionFormat: 'HH:mm'),
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
            selectFun(time, measures['Sales']);
          },
        )
      ],
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> dataToSeriesList(List<TimeSeriesSales> data){
    return[
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  /// Create one series with sample hard coded data.
  static List<TimeSeriesSales> _createSampleData() {
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
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final double sales;

  TimeSeriesSales(this.time, this.sales);
}
