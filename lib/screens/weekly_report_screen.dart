import 'package:flutter/material.dart';

class WeeklyReportScreen extends StatelessWidget {
  const WeeklyReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Report'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
