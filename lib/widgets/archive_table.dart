import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:weekly_report/view_models/archive_view_model.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/widgets/app_loading.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'app_error.dart';

class ArchiveTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ArchiveViewModel archive = context.watch<ArchiveViewModel>();
    // WeeklyViewModel weeklyViewModel = context.watch<WeeklyViewModel>();
    // final dataSource = weeklyViewModel.weeklyDataSource;
    if (archive.loading) {
      return AppLoading();
    }
    if (archive.error != null) {
      return AppError(
        errortxt: archive.error?.message,
      );
    }

    if (archive.archiveListModel.isEmpty) {
      return Center(
        child: Text('No data found'),
      );
    }
    // return Text('test');
    return SfDataGridTheme(
      data: SfDataGridThemeData(headerColor: const Color(0xFFF5F5F5)),
      child: SfDataGrid(
        gridLinesVisibility: GridLinesVisibility.horizontal,
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        columnWidthMode: ColumnWidthMode.auto,
        columnWidthCalculationRange: ColumnWidthCalculationRange.visibleRows,
        source: archive.archiveDataSource,
        onQueryRowHeight: (details) {
          return details.getIntrinsicRowHeight(details.rowIndex);
        },
        // source: weeklyViewModel.weeklyDataSource,
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
          columnName: 'progress',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Progress')),
        ),
        GridColumn(
          columnName: 'idPtfi',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Crew ID')),
        ),
        GridColumn(
          columnName: 'name',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Crew Name')),
        ),
      ];

  Widget buildLabel(String text) => Text(
        text,
      );
}
