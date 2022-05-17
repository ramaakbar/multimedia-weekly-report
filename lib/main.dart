import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/screens/auth_screen.dart';
import 'package:weekly_report/screens/template.dart';
import 'package:weekly_report/view_models/archive_view_model.dart';
import 'package:weekly_report/view_models/auth.dart';
import 'package:weekly_report/view_models/bottom_nav_view_model.dart';
import 'package:weekly_report/view_models/new_wo_view_model.dart';
import 'package:weekly_report/view_models/report_view_model.dart';
import 'package:weekly_report/view_models/view_businessunit_view_model.dart';
import 'package:weekly_report/view_models/view_category_view_model.dart';
import 'package:weekly_report/view_models/view_crew_view_model.dart';
import 'package:weekly_report/view_models/view_weekly_model.dart';
import 'package:weekly_report/view_models/weekly_view_model.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final lightScheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  final darkScheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
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
        ChangeNotifierProvider(create: (_) => Auth()),
      ],
      child: Consumer<Auth>(
        builder: ((context, auth, child) => MaterialApp(
              title: 'Weekly Report',
              theme: lightScheme,
              home: auth.isAuth
                  ? Template()
                  : FutureBuilder(
                      future: auth.autoLogin(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Scaffold(
                            body: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return LoginScreen();
                        }
                      },
                    ),
            )),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
