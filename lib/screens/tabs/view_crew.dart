import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/view_models/view_crew_view_model.dart';
import 'package:weekly_report/widgets/crew_chart.dart';
import 'package:weekly_report/widgets/crew_table.dart';

class ViewCrew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewCrewViewModel viewCrewViewModel = context.watch<ViewCrewViewModel>();
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
                  'Weekly Report by Crew',
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
                  onPressed: () => {viewCrewViewModel.previousDateRange()},
                  child: Row(
                    children: const [
                      Icon(Icons.chevron_left),
                      // Text('Previous'),
                    ],
                  ),
                ),
                Text(
                  '${DateFormat('MM/dd/yyyy').format(viewCrewViewModel.dateRange.start)} - ${DateFormat('MM/dd/yyyy').format(viewCrewViewModel.dateRange.end)}',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () => {viewCrewViewModel.nextDateRange()},
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

                CrewTable(),
          ),
          CrewChart()
        ],
      )),
    );
  }
}
