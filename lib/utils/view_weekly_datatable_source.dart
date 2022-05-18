import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:weekly_report/models/report_weekly_model.dart';

class ViewWeeklyDatatableSource extends DataGridSource {
  int i = 1;
  ViewWeeklyDatatableSource({required List<Datum> data}) {
    _data = data
        .map<DataGridRow>(
          (data) => DataGridRow(cells:
              // ProjectWoColumn.values
              //     .map((e) => DataGridCell(columnName: e.toString(), value: data))
              //     .toList(),
              [
            DataGridCell(
              value: i++,
              columnName: 'No',
            ),
            DataGridCell(
              value: data.name,
              columnName: 'assign',
            ),
            DataGridCell(
              value: data.dateSubmit,
              columnName: 'submitDate',
            ),
            DataGridCell(
              value: data.businessUnit,
              columnName: 'Business Unit',
            ),

            // DataGridCell(
            //   value: data.woNumber,
            //   columnName: 'woNo',
            // ),
            DataGridCell(
              value: data.projectName,
              columnName: 'Project Name',
            ),
            // DataGridCell(
            //   value: data.activity,
            //   columnName: 'activity',
            // ),
            DataGridCell(
              // value: '${data.progress}%',
              value: data.progress == null ? null : '${data.progress} %',
              columnName: 'Progress',
            ),

            // DataGridCell(
            //   value: data.manHours,
            //   columnName: 'mHrs',
            // ),
            // DataGridCell(
            //   value: data.idPtfi,
            //   columnName: 'Id Ptfi',
            // ),
            DataGridCell(
              value: data.devAction,
              columnName: 'Action',
            ),
            // DataGridCell(
            //   value: data.workArea,
            //   columnName: 'Work Area',
            // ),
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
