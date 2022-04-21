import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/screens/template.dart';
import 'package:weekly_report/view_models/archive_view_model.dart';
import 'package:weekly_report/view_models/bottom_nav_view_model.dart';
import 'package:weekly_report/view_models/new_wo_view_model.dart';
import 'package:weekly_report/view_models/report_view_model.dart';
import 'package:weekly_report/view_models/view_businessunit_view_model.dart';
import 'package:weekly_report/view_models/view_category_view_model.dart';
import 'package:weekly_report/view_models/view_crew_view_model.dart';
import 'package:weekly_report/view_models/view_weekly_model.dart';
import 'package:weekly_report/view_models/weekly_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavViewModel()),
        ChangeNotifierProvider(create: (_) => ReportViewModel()),
        ChangeNotifierProvider(create: (_) => WeeklyViewModel()),
        ChangeNotifierProvider(create: (_) => NewWoViewModel()),
        ChangeNotifierProvider(create: (_) => ArchiveViewModel()),
        ChangeNotifierProvider(create: (_) => ViewWeeklyModel()),
        ChangeNotifierProvider(create: (_) => ViewCategoryViewModel()),
        ChangeNotifierProvider(create: (_) => ViewBusinessunitViewModel()),
        ChangeNotifierProvider(create: (_) => ViewCrewViewModel()),
      ],
      child: MaterialApp(
        title: 'Weekly Report',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Template(),
      ),
    );
  }
}
