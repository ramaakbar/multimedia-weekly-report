import 'package:flutter/material.dart';
import 'package:weekly_report/screens/archive_screen.dart';
import 'package:weekly_report/screens/home_screen.dart';
import 'package:weekly_report/screens/report_screen.dart';
import 'package:weekly_report/screens/weekly_report_screen.dart';

class BottomNavViewModel extends ChangeNotifier {
  int _currentTab = 0;
  List<Widget> _screens = [
    HomeScreen(),
    ReportScreen(),
    ArchiveScreen(),
    WeeklyReportScreen()
  ];

  BottomNavViewModel() {}

  int get currentTab => _currentTab;
  get currentScreen => _screens[_currentTab];

  void setCurrentTab(int tab) {
    _currentTab = tab;
    notifyListeners();
  }
}
