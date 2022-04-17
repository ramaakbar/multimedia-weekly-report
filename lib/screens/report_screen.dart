import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/view_models/report_view_model.dart';
import 'package:weekly_report/widgets/filter_select.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReportViewModel report = context.watch<ReportViewModel>();
    report.getCrewList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CrewDropdown(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        report.pickDateRange(context, report.dateRange),
                    child: Text(DateFormat('MM/dd/yyyy')
                        .format(report.dateRange.start)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        report.pickDateRange(context, report.dateRange),
                    child: Text(
                        DateFormat('MM/dd/yyyy').format(report.dateRange.end)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('Current WO & Progress',
                style: Theme.of(context).textTheme.headline6),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Workorder $index'),
                    subtitle: Text('Subtitle $index'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  );
                },
              ),
            ),
          ],
        ),
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
            .map((e) => DropdownMenuItem(child: Text(e.name), value: e.idPtfi))
            .toList(),
      );
    });
  }
}
