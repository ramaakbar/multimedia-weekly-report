import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:weekly_report/models/weekly_model.dart';
import 'package:weekly_report/view_models/archive_view_model.dart';
import 'package:provider/provider.dart';

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
              columnName: 'no',
            ),
            DataGridCell(
              value: data.businessUnit,
              columnName: 'businessUnit',
            ),

            // DataGridCell(
            //   value: data.woNumber,
            //   columnName: 'woNo',
            // ),
            DataGridCell(
              value: data.projectName,
              columnName: 'projectName',
            ),
            // DataGridCell(
            //   value: data.activity,
            //   columnName: 'activity',
            // ),
            DataGridCell(
              // value: '${data.progress}%',
              value: data.progress == null ? null : '${data.progress} %',
              columnName: 'progress',
            ),
            // DataGridCell(
            //   value:
            //       DateFormat('MM/dd/yyyy').format(data.dateSubmit as DateTime),
            //   columnName: 'submitOn',
            // ),
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
              columnName: 'action',
            ),
            DataGridCell(
              value: data.workArea,
              columnName: 'workArea',
            ),
            // DataGridCell(
            //   value: data.name,
            //   columnName: 'crew',
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
