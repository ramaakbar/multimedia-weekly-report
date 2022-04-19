// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:weekly_report/view_models/view_weekly_model.dart';

import 'package:weekly_report/view_models/weekly_view_model.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/widgets/app_loading.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xl;
import 'app_error.dart';
import 'package:weekly_report/utils/save_file_mobile_desktop.dart' as helper;

class ViewWeeklyTable extends StatelessWidget {
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    ViewWeeklyModel viewWeekly = context.watch<ViewWeeklyModel>();

    if (viewWeekly.loading) {
      return AppLoading();
    }
    if (viewWeekly.error != null) {
      return AppError(
        errortxt: viewWeekly.error?.message,
      );
    }

    if (viewWeekly.weeklyListModel.isEmpty) {
      return Center(
        child: Text('No data found'),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: Text('Export to PDF'),
                onPressed: () async {
                  final PdfDocument document =
                      _key.currentState!.exportToPdfDocument(
                    fitAllColumnsInOnePage: true,
                    cellExport: (details) {
                      if (details.cellType ==
                          DataGridExportCellType.columnHeader) {
                        details.pdfCell.style.backgroundBrush =
                            PdfBrushes.darkSlateBlue;
                        details.pdfCell.style.textBrush = PdfBrushes.white;
                      }
                    },
                  );
                  final List<int> bytes = document.save();
                  await helper.saveAndLaunchFile(bytes, 'Weekly Report.pdf');
                  document.dispose();
                }),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
                child: Text('Export to Excel'),
                onPressed: () async {
                  final xl.Workbook workbook =
                      _key.currentState!.exportToExcelWorkbook();
                  final List<int> bytes = workbook.saveAsStream();
                  workbook.dispose();
                  await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');
                }),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: SfDataGridTheme(
            data: SfDataGridThemeData(headerColor: const Color(0xFFF5F5F5)),
            child: SfDataGrid(
              key: _key,
              gridLinesVisibility: GridLinesVisibility.horizontal,
              headerGridLinesVisibility: GridLinesVisibility.horizontal,
              columnWidthMode: ColumnWidthMode.lastColumnFill,
              columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
              source: viewWeekly.viewWeeklyDataSource,
              columns: buildGridColumns(),
            ),
          ),
        ),
      ],
    );
  }

  List<GridColumn> buildGridColumns() => <GridColumn>[
        GridColumn(
          columnName: 'No',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('No')),
        ),
        GridColumn(
          columnName: 'Business Unit',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Business Unit')),
        ),

        // GridColumn(
        //   columnName: 'woNo',
        //   label: Container(
        //       padding: EdgeInsets.all(5),
        //       alignment: Alignment.centerLeft,
        //       child: buildLabel('WO No.')),
        // ),
        GridColumn(
          columnName: 'Project Name',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Project Name')),
        ),
        // GridColumn(
        //   columnName: 'activity',
        //   label: Container(
        //       padding: EdgeInsets.all(5),
        //       alignment: Alignment.centerLeft,
        //       child: buildLabel('Activity')),
        // ),
        GridColumn(
          columnName: 'Progress',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Progress')),
        ),
        // GridColumn(
        //   columnName: 'submitOn',
        //   label: Container(
        //       padding: EdgeInsets.all(5),
        //       alignment: Alignment.centerLeft,
        //       child: buildLabel('Submit on')),
        // ),
        // GridColumn(
        //   columnName: 'mHrs',
        //   label: Container(
        //       padding: EdgeInsets.all(5),
        //       alignment: Alignment.centerLeft,
        //       child: buildLabel('M-Hrs')),
        // ),
        // GridColumn(
        //   columnName: 'Id Ptfi',
        //   label: Container(
        //       padding: EdgeInsets.all(5),
        //       alignment: Alignment.centerLeft,
        //       child: buildLabel('ID No')),
        // ),
        GridColumn(
          columnName: 'Action',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Action')),
        ),
        GridColumn(
          columnName: 'Work Area',
          label: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: buildLabel('Work Area')),
        ),
        // GridColumn(
        //   columnName: 'crew',
        //   label: Container(
        //       padding: EdgeInsets.all(5),
        //       alignment: Alignment.centerLeft,
        //       child: buildLabel('Crew')),
        // ),
      ];

  Widget buildLabel(String text) => Text(
        text,
      );
}
