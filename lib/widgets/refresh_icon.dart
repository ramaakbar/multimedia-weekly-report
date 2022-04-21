import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/view_models/archive_view_model.dart';
import 'package:weekly_report/view_models/new_wo_view_model.dart';
import 'package:weekly_report/view_models/report_view_model.dart';
import 'package:weekly_report/view_models/view_businessunit_view_model.dart';
import 'package:weekly_report/view_models/view_category_view_model.dart';
import 'package:weekly_report/view_models/view_crew_view_model.dart';
import 'package:weekly_report/view_models/view_weekly_model.dart';
import 'package:weekly_report/view_models/weekly_view_model.dart';

class RefreshIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {
        Provider.of<WeeklyViewModel>(context, listen: false).getWeeklyList();
        Provider.of<NewWoViewModel>(context, listen: false).reset();
        Provider.of<ReportViewModel>(context, listen: false).getWeeklyList();
        Provider.of<ReportViewModel>(context, listen: false).getCrewList();
        Provider.of<ArchiveViewModel>(context, listen: false).getArchiveList();
        Provider.of<ViewWeeklyModel>(context, listen: false).getWeeklyList();
        Provider.of<ViewCategoryViewModel>(context, listen: false)
            .getReportCategory();
        Provider.of<ViewBusinessunitViewModel>(context, listen: false)
            .getReportBusiness();
        Provider.of<ViewCrewViewModel>(context, listen: false).getReportCrew();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Refreshed'),
            duration: const Duration(milliseconds: 1500),
          ),
        );
      },
    );
  }
}
