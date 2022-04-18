import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:weekly_report/view_models/weekly_view_model.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/widgets/app_loading.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'app_error.dart';

class WoTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WeeklyViewModel weeklyViewModel = context.watch<WeeklyViewModel>();
    // final dataSource = weeklyViewModel.weeklyDataSource;
    if (weeklyViewModel.loading) {
      return AppLoading();
    }
    if (weeklyViewModel.error != null) {
      return AppError(
        errortxt: weeklyViewModel.error?.message,
      );
    }

    if (weeklyViewModel.weeklyListModel.isEmpty) {
      return Center(
        child: Text('No data found'),
      );
    }
    return SfDataGridTheme(
      data: SfDataGridThemeData(headerColor: const Color(0xFFF5F5F5)),
      child: SfDataGrid(
        gridLinesVisibility: GridLinesVisibility.horizontal,
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
        source: weeklyViewModel.weeklyDataSource,
        columns: buildGridColumns(),
      ),
    );
  }

  List<GridColumn> buildGridColumns() => <GridColumn>[
        GridColumn(
          columnName: 'no',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('No')),
        ),
        GridColumn(
          columnName: 'workArea',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Work Area')),
        ),
        GridColumn(
          columnName: 'woNo',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('WO No.')),
        ),
        GridColumn(
          columnName: 'projectName',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Project Name')),
        ),
        GridColumn(
          columnName: 'activity',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Activity')),
        ),
        GridColumn(
          columnName: 'progress',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Progress')),
        ),
        GridColumn(
          columnName: 'submitOn',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Submit on')),
        ),
        GridColumn(
          columnName: 'mHrs',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('M-Hrs')),
        ),
        GridColumn(
          columnName: 'idNo',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('ID No')),
        ),
        GridColumn(
          columnName: 'action',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Action')),
        ),
        GridColumn(
          columnName: 'crew',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Crew')),
        ),
      ];

  Widget buildLabel(String text) => Text(
        text,
      );
}
