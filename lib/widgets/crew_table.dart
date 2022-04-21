import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/view_models/view_category_view_model.dart';
import 'package:weekly_report/view_models/view_crew_view_model.dart';
import 'package:weekly_report/widgets/app_loading.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'app_error.dart';

class CrewTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewCrewViewModel crew = context.watch<ViewCrewViewModel>();
    if (crew.loading) {
      return AppLoading();
    }
    if (crew.error != null) {
      return AppError(
        errortxt: crew.error?.message,
      );
    }

    if (crew.crewListModel.isEmpty) {
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
        source: crew.viewCrewDatatableSource,
        // set footer sum of count column;
        footer: Center(child: Text('Total: ${crew.sum}')),
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
              child: buildLabel('Crew')),
        ),
        GridColumn(
          columnName: 'count',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Sum of WO')),
        )
      ];

  Widget buildLabel(String text) => Text(
        text,
      );
}
