import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/models/workarea_model.dart';
import 'package:weekly_report/view_models/new_wo_view_model.dart';
import 'package:weekly_report/widgets/filter_select.dart';
import 'package:provider/provider.dart';

class NewWo extends StatelessWidget {
  const NewWo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewWoViewModel newWo = context.watch<NewWoViewModel>();
    newWo.getWorkAreaList();
    newWo.getCrewList();
    newWo.getBusinessList();
    return Scaffold(
      appBar: AppBar(
        title: Text('New Multimedia WO'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'WO Number',
                errorText: newWo.woNumber.error.isNotEmpty
                    ? newWo.woNumber.error
                    : null,
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                newWo.changeWoNumber(value);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Text('Start Date', style: TextStyle(fontSize: 16)),
                      OutlinedButton.icon(
                        onPressed: () {
                          newWo.pickDateRange(context, newWo.dateRange);
                        },
                        icon: Icon(Icons.date_range),
                        label: Text(
                          DateFormat('MM/dd/yyyy')
                              .format(newWo.dateRange.start),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Text('End Date', style: TextStyle(fontSize: 16)),
                      OutlinedButton.icon(
                        onPressed: () {
                          newWo.pickDateRange(context, newWo.dateRange);
                        },
                        icon: Icon(Icons.date_range),
                        label: Text(
                          DateFormat('MM/dd/yyyy').format(newWo.dateRange.end),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Requestor ID',
                errorText: newWo.requestorId.error.isNotEmpty
                    ? newWo.requestorId.error
                    : null,
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                newWo.changeRequestorId(value);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            BusinessUnitDropdown(),
            const SizedBox(
              height: 20.0,
            ),
            WorkAreaDropdown(),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Project Name',
                errorText: newWo.projectName.error.isNotEmpty
                    ? newWo.projectName.error
                    : null,
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                newWo.changeProjectName(value);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            CrewDropdown(),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                bool woAdded = newWo.submitData();
                if (!woAdded) {
                  return;
                }
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

class WorkAreaDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (
      context,
      NewWoViewModel newWo,
      child,
    ) {
      return DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Work Area',
        ),
        value: newWo.selectedWorkArea,
        onChanged: <String>(String value) {
          newWo.setSelectedWorkArea(value.toString());
        },
        items: newWo.workAreaList
            .map((e) =>
                DropdownMenuItem(child: Text(e.workArea), value: e.workArea))
            .toList(),
      );
    });
  }
}

class CrewDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (
      context,
      NewWoViewModel crew,
      child,
    ) {
      return DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Assign to',
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

class BusinessUnitDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (
      context,
      NewWoViewModel businessUnit,
      child,
    ) {
      return DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Business Unit',
        ),
        value: businessUnit.selectedBusinessUnit,
        onChanged: <String>(String value) {
          businessUnit.setSelectedBusinessUnit(value.toString());
        },
        items: businessUnit.businessUnitList
            .map((e) => DropdownMenuItem(child: Text(e.name), value: e.name))
            .toList(),
      );
    });
  }
}