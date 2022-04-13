import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/screens/template.dart';
import 'package:weekly_report/view_models/bottom_nav_view_model.dart';
import 'package:weekly_report/view_models/report_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BottomNavViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReportViewModel(),
        ),
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
