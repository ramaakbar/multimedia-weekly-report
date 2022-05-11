import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:weekly_report/models/archive_model.dart';

enum ProjectWoColumn {
  no,
  woNumber,
  projectName,
  idPtfi,
  name,
}

class ArchiveDatatableSource extends DataGridSource {
  int i = 1;
  ArchiveDatatableSource({required List<Datum> data}) {
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
              value: data.woNumber,
              columnName: 'woNo',
            ),
            DataGridCell(
              value: data.projectName,
              columnName: 'projectName',
            ),
            DataGridCell(
              value: '${data.progress} %',
              columnName: 'progress',
            ),
            DataGridCell(
              value: data.assigned,
              columnName: 'idPtfi',
            ),
            DataGridCell(
              value: data.name,
              columnName: 'name',
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
