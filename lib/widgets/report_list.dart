import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/view_models/report_view_model.dart';
import 'package:provider/provider.dart';

import 'app_error.dart';
import 'app_loading.dart';

class ReportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ReportViewModel report = context.watch<ReportViewModel>();
    if (report.loading) {
      return AppLoading();
    }
    if (report.error != null) {
      return AppError(
        errortxt: report.error?.message,
      );
    }

    if (report.weeklyListModel.isEmpty) {
      return Center(
        child: Text('No data found'),
      );
    }
    return ListView.builder(
      itemCount: report.weeklyListModel.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(report.weeklyListModel[index].woNumber!,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          title: Text(
            '${report.weeklyListModel[index].projectName} - ${report.weeklyListModel[index].progress}%',
          ),
          subtitle: Text(
              '${DateFormat('MM/dd/yyyy').format(report.weeklyListModel[index].startDate!).toString()} - ${DateFormat('MM/dd/yyyy').format(report.weeklyListModel[index].endDate!).toString()}'),
          trailing: PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text('Update'),
                value: 'Edit',
              ),
              PopupMenuItem(
                child: Text('Delete', style: TextStyle(color: Colors.red)),
                value: 'Delete',
              ),
            ];
          }, onSelected: (value) {
            if (value == 'Edit') {
              report.setSelectedWo(report.weeklyListModel[index]);
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Center(
                      child: SingleChildScrollView(child: updateDialog())));
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text('Delete'),
                        content:
                            Text('Are you sure you want to delete this item?'),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
                            onPressed: () {
                              report.deleteWeekly(
                                  report.weeklyListModel[index].woNumber!);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
            }
          }),
        );
      },
    );
  }
}

class updateDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // make text field controller
    return Consumer(builder: (
      context,
      ReportViewModel report,
      child,
    ) {
      return AlertDialog(
        title: Text('Update WO'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: report.actionController,
                decoration: InputDecoration(
                  labelText: 'Dev. Action',
                  border: OutlineInputBorder(),
                )),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: report.hoursController,
                decoration: InputDecoration(
                  labelText: 'Manhours',
                  border: OutlineInputBorder(),
                )),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: report.progressController,
                decoration: InputDecoration(
                  labelText: 'Progress %',
                  border: OutlineInputBorder(),
                )),
            SizedBox(
              height: 20,
            ),
            TextField(
                maxLines: 4,
                controller: report.activityController,
                decoration: InputDecoration(
                  labelText: 'Activity',
                  border: OutlineInputBorder(),
                )),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Update'),
            onPressed: () {
              report.updateWeekly();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
