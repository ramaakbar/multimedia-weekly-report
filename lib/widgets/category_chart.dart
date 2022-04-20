import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weekly_report/models/chart_model.dart';
import 'package:weekly_report/view_models/view_category_view_model.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/widgets/app_error.dart';
import 'package:weekly_report/widgets/app_loading.dart';

class CategoryChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewCategoryViewModel cat = context.watch<ViewCategoryViewModel>();

    if (cat.loading) {
      return AppLoading();
    }
    if (cat.error != null) {
      // hide text
      return Text(
        'test',
        style: TextStyle(color: Colors.transparent),
      );
    }

    if (cat.categoryListModel.isEmpty) {
      return Center(
        child: Text('No data found'),
      );
    }
    return SfCircularChart(
      legend: Legend(isVisible: true),
      series: <CircularSeries>[
        PieSeries<ChartModel, String>(
            dataLabelSettings: DataLabelSettings(isVisible: true),
            dataSource: cat.chartData,
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
