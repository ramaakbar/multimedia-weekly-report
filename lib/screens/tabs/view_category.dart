import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weekly_report/models/chart_model.dart';
import 'package:weekly_report/models/report_category_model.dart';
import 'package:weekly_report/view_models/view_category_view_model.dart';
import 'package:weekly_report/widgets/category_chart.dart';
import 'package:weekly_report/widgets/category_table.dart';
import 'package:weekly_report/widgets/refresh_icon.dart';

class ViewCategory extends StatelessWidget {
  final List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];
  @override
  Widget build(BuildContext context) {
    ViewCategoryViewModel viewCategoryViewModel =
        context.watch<ViewCategoryViewModel>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Multimedia Report YTD Completed WO',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () =>
                        {viewCategoryViewModel.previousDateRange()},
                    child: Row(
                      children: const [
                        Icon(Icons.chevron_left),
                        // Text('Previous'),
                      ],
                    ),
                  ),
                  Text(
                    '${DateFormat('MM/dd/yyyy').format(viewCategoryViewModel.dateRange.start)} - ${DateFormat('MM/dd/yyyy').format(viewCategoryViewModel.dateRange.end)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () => {viewCategoryViewModel.nextDateRange()},
                    child: Row(
                      children: const [
                        // Text('Next'),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child:
                  // set  height to be the same as table content height

                  CategoryTable(),
            ),
            CategoryChart(),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
