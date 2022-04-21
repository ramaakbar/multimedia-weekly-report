import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:weekly_report/models/report_crew_model.dart';

class ViewCrewDatatableSource extends DataGridSource {
  int i = 1;
  ViewCrewDatatableSource({required List<Datum> data}) {
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
              columnName: 'category',
            ),
            DataGridCell(
              value: data.count,
              columnName: 'count',
            )
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
