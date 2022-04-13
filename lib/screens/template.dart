import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/view_models/bottom_nav_view_model.dart';

class Template extends StatelessWidget {
  const Template({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNavViewModel nav = context.watch<BottomNavViewModel>();
    return Scaffold(
      body: nav.currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.source),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Archives',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Weekly Report',
          ),
        ],
        currentIndex: nav.currentTab,
        onTap: (int idx) {
          nav.setCurrentTab(idx);
        },
      ),
    );
  }
}
