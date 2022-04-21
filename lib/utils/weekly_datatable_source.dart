import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:weekly_report/models/weekly_model.dart';

enum ProjectWoColumn {
  no,
  workArea,
  woNumber,
  projectName,
  activity,
  progress,
  dateSubmit,
  manHours,
  idPtfi,
  devAction,
  name,
}

class WeeklyDatatableSource extends DataGridSource {
  int i = 1;
  WeeklyDatatableSource({required List<Datum> data}) {
    _data = data
        .map<DataGridRow>(
          (data) => DataGridRow(cells:
              // ProjectWoColumn.values
              //     .map((e) => DataGridCell(columnName: e.toString(), value: data))
              //     .toList(),
              [
            DataGridCell(
              value: i++,
              columnName: 'no',
            ),
            DataGridCell(
              value: data.workArea,
              columnName: 'workArea',
            ),
            DataGridCell(
              value: data.woNumber,
              columnName: 'woNo',
            ),
            DataGridCell(
              value: data.projectName,
              columnName: 'projectName',
            ),
            DataGridCell(
              value: data.activity,
              columnName: 'activity',
            ),
            DataGridCell(
              value:
                  DateFormat('MM/dd/yyyy').format(data.dateSubmit as DateTime),
              columnName: 'submitOn',
            ),
            DataGridCell(
              value: data.manHours,
              columnName: 'mHrs',
            ),
            DataGridCell(
              value: data.idPtfi,
              columnName: 'idNo',
            ),
            DataGridCell(
              value: data.devAction,
              columnName: 'action',
            ),
            DataGridCell(
              value: data.name,
              columnName: 'crew',
            ),
            DataGridCell(
              value: data.requestor,
              columnName: 'requestor',
            ),
            DataGridCell(
              // value: '${data.progress}%',
              value: data.progress == null ? null : '${data.progress} %',
              columnName: 'progress',
            ),
          ]),
        )
        .toList();
  }
  late List<DataGridRow> _data = [];
  List<DataGridRow> get rows => _data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) => DataGridRowAdapter(
          cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          padding: EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: Text(
            dataGridCell.value.toString(),
          ),
        );
      }).toList());
}
