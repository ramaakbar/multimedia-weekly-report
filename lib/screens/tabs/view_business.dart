import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/view_models/view_businessunit_view_model.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/widgets/businessunit_chart.dart';
import 'package:weekly_report/widgets/businessunit_table.dart';

class ViewBusiness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewBusinessunitViewModel viewBusinessunitViewModel =
        context.watch<ViewBusinessunitViewModel>();

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
                    'YTD Completed WO by BU',
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
                        {viewBusinessunitViewModel.previousDateRange()},
                    child: Row(
                      children: const [
                        Icon(Icons.chevron_left),
                        // Text('Previous'),
                      ],
                    ),
                  ),
                  Text(
                    '${DateFormat('MM/dd/yyyy').format(viewBusinessunitViewModel.dateRange.start)} - ${DateFormat('MM/dd/yyyy').format(viewBusinessunitViewModel.dateRange.end)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () =>
                        {viewBusinessunitViewModel.nextDateRange()},
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

                  BusinessunitTable(),
            ),
            BusinessunitChart(),
          ],
        ),
      ),
    );
  }
}
