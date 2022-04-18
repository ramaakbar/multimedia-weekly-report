import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/view_models/view_weekly_model.dart';

import 'package:weekly_report/widgets/view_weekly_table.dart';
import 'package:provider/provider.dart';

class WeeklyReportScreen extends StatelessWidget {
  const WeeklyReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewWeeklyModel weekly = context.watch<ViewWeeklyModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Report'),
        actions: [
          IconButton(
            onPressed: () => {weekly.getWeeklyList()},
            icon: Icon(Icons.refresh),
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'CSV', 'Excel', 'PDF'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20, 20, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => weekly.search(value),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => {weekly.previousDateRange()},
                  child: Row(
                    children: const [
                      Icon(Icons.chevron_left),
                      // Text('Previous'),
                    ],
                  ),
                ),
                Text(
                  '${DateFormat('MM/dd/yyyy').format(weekly.dateRange.start)} - ${DateFormat('MM/dd/yyyy').format(weekly.dateRange.end)}',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () => {weekly.nextDateRange()},
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
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ViewWeeklyTable(),
            ),
          ),
        ],
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'PDF':
        print('pdf');
        break;
      case 'Settings':
        break;
    }
  }
}
