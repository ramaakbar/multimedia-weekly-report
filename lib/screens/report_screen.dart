import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/view_models/report_view_model.dart';
import 'package:weekly_report/widgets/add_icon.dart';
import 'package:weekly_report/widgets/refresh_icon.dart';
import 'package:weekly_report/widgets/report_list.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReportViewModel report = context.watch<ReportViewModel>();
    report.getCrewList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Report'),
        actions: [
          RefreshIcon(),
          AddIcon(),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: CrewDropdown(),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      report.pickDateStart(context, report.startDate);
                    },
                    icon: Icon(Icons.date_range),
                    label: Text(
                      DateFormat('MM/dd/yyyy').format(report.startDate),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      report.pickDateEnd(context, report.endDate);
                    },
                    icon: Icon(Icons.date_range),
                    label: Text(
                      DateFormat('MM/dd/yyyy').format(report.endDate),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Current WO & Progress',
                style: Theme.of(context).textTheme.headline6),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ReportList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CrewDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (
      context,
      ReportViewModel crew,
      child,
    ) {
      return DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Crew',
        ),
        value: crew.selectedCrew,
        onChanged: <String>(String value) {
          crew.setSelectedCrew(value.toString());
        },
        items: crew.crewList
            .map((e) => DropdownMenuItem(child: Text(e.name), value: e.name))
            .toList(),
      );
    });
  }
}
