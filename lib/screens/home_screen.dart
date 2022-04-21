import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/screens/new_wo.dart';
import 'package:weekly_report/view_models/new_wo_view_model.dart';
import 'package:weekly_report/view_models/weekly_view_model.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/widgets/refresh_icon.dart';
import 'package:weekly_report/widgets/wo_table.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeeklyViewModel weeklyViewModel = context.watch<WeeklyViewModel>();
    NewWoViewModel newWo = context.watch<NewWoViewModel>();
    // newWo.reset();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          RefreshIcon(),
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
              onChanged: (value) => weeklyViewModel.search(value),
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
                  onPressed: () => {weeklyViewModel.previousDateRange()},
                  child: Row(
                    children: const [
                      Icon(Icons.chevron_left),
                      // Text('Previous'),
                    ],
                  ),
                ),
                Text(
                  '${DateFormat('MM/dd/yyyy').format(weeklyViewModel.dateRange.start)} - ${DateFormat('MM/dd/yyyy').format(weeklyViewModel.dateRange.end)}',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () => {weeklyViewModel.nextDateRange()},
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
              child: WoTable(),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async => {
      //     newWo.setController(weeklyViewModel
      //         .weeklyListModel[weeklyViewModel.weeklyListModel.length - 1]),
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => NewWo(),
      //       ),
      //     ),
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
