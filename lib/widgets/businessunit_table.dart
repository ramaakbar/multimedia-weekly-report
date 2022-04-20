import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/view_models/view_businessunit_view_model.dart';

import 'package:weekly_report/widgets/app_loading.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'app_error.dart';

class BusinessunitTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewBusinessunitViewModel bu = context.watch<ViewBusinessunitViewModel>();
    if (bu.loading) {
      return AppLoading();
    }
    if (bu.error != null) {
      return AppError(
        errortxt: bu.error?.message,
      );
    }

    if (bu.businessunitListModel.isEmpty) {
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
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
        source: bu.viewBusinessunitDatatableSource,
        // set footer sum of count column;
        footer: Center(child: Text('Total: ${bu.sum}')),
        footerFrozenRowsCount: 1,
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
          columnName: 'category',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Business Unit')),
        ),
        GridColumn(
          columnName: 'count',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Count')),
        )
      ];

  Widget buildLabel(String text) => Text(
        text,
      );
}
