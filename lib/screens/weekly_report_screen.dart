import 'package:flutter/material.dart';
import 'package:weekly_report/screens/tabs/view_business.dart';
import 'package:weekly_report/screens/tabs/view_category.dart';
import 'package:weekly_report/screens/tabs/view_crew.dart';
import 'package:weekly_report/screens/tabs/view_weekly.dart';
import 'package:weekly_report/widgets/refresh_icon.dart';

class WeeklyReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
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
            actions: [RefreshIcon()],
          ),
          body: TabBarView(
            children: <Widget>[
              ViewWeekly(),
              ViewCategory(),
              ViewBusiness(),
              ViewCrew(),
            ],
          ),
        ));
  }
}
