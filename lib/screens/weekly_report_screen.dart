import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/screens/tabs/view_weekly.dart';
import 'package:weekly_report/view_models/view_weekly_model.dart';

import 'package:weekly_report/widgets/view_weekly_table.dart';
import 'package:provider/provider.dart';

class WeeklyReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Weekly Report'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Weekly'),
                Tab(text: 'Category'),
                Tab(text: 'Business'),
                Tab(text: 'Crew'),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              ViewWeekly(),
              Center(
                child: Text("It's rainy here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
            ],
          ),
        ));
  }
}
