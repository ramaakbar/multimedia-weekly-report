import 'package:flutter/material.dart';
import 'package:weekly_report/screens/new_wo.dart';
import 'package:weekly_report/view_models/new_wo_view_model.dart';
import 'package:weekly_report/view_models/weekly_view_model.dart';
import 'package:provider/provider.dart';

class AddIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WeeklyViewModel weeklyViewModel = context.watch<WeeklyViewModel>();
    NewWoViewModel newWo = context.watch<NewWoViewModel>();
    return IconButton(
        onPressed: () async {
          if (weeklyViewModel.weeklyListModel.isNotEmpty) {
            newWo.setController(weeklyViewModel
                .weeklyListModel[weeklyViewModel.weeklyListModel.length - 1]);
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewWo(),
            ),
          );
        },
        icon: Icon(Icons.add));
  }
}
