import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weekly_report/models/chart_model.dart';
import 'package:weekly_report/view_models/view_businessunit_view_model.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/widgets/app_error.dart';
import 'package:weekly_report/widgets/app_loading.dart';

class BusinessunitChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewBusinessunitViewModel bu = context.watch<ViewBusinessunitViewModel>();

    if (bu.loading) {
      return AppLoading();
    }
    if (bu.error != null) {
      // hide text
      return Text(
        'test',
        style: TextStyle(color: Colors.transparent),
      );
    }

    if (bu.businessunitListModel.isEmpty) {
      return Center(
        child: Text('No data found'),
      );
    }
    return SfCircularChart(
      legend: Legend(isVisible: true),
      series: <CircularSeries>[
        PieSeries<ChartModel, String>(
            dataLabelSettings: DataLabelSettings(isVisible: true),
            dataSource: bu.chartData,
            xValueMapper: (data, _) => data.name,
            yValueMapper: (data, _) => data.count)
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
