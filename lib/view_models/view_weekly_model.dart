import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:weekly_report/models/weekly_error.dart';
import 'package:weekly_report/models/report_weekly_model.dart';
import 'package:weekly_report/repo/api_status.dart';
import 'package:weekly_report/repo/weekly_services.dart';
import 'package:weekly_report/utils/view_weekly_datatable_source.dart';

class ViewWeeklyModel extends ChangeNotifier {
  late ViewWeeklyDatatableSource viewWeeklyDataSource;
  GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  bool _loading = false;
  WeeklyError? _error;
  List<Datum> _weeklyListModel = [];
  DateTime _date = DateTime.now().subtract(Duration(days: 7));
  DateTimeRange _dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, 1, 6),
      end: DateTime(DateTime.now().year, 1, 5).add(Duration(days: 7)));

  bool get loading => _loading;
  List<Datum> get weeklyListModel => _weeklyListModel;
  WeeklyError? get error => _error;
  DateTimeRange get dateRange => _dateRange;
  // GlobalKey get key => _key;

  ViewWeeklyModel() {
    getWeeklyList();
    calcDate();
  }

  // set key
  setKey(key) {
    this.key = key;
    ChangeNotifier;
  }

  void calcDate() {
    while (
        (!_dateRange.start.isAfter(_date.subtract(const Duration(days: 1))))) {
      _dateRange = DateTimeRange(
          start: _dateRange.start.add(Duration(days: 7)),
          end: _dateRange.end.add(Duration(days: 7)));
    }
    getWeeklyList();

    notifyListeners();
  }

  // make search weekly data source
  void search(String value) {
    viewWeeklyDataSource = ViewWeeklyDatatableSource(
        data: weeklyListModel
            .where((element) =>
                element.dateSubmit!.toString().contains(value) ||
                element.name!.toLowerCase().contains(value.toLowerCase()) ||
                element.businessUnit!.toLowerCase().contains(value) ||
                element.projectName!.toLowerCase().contains(value) ||
                element.progress!.toLowerCase().contains(value) ||
                element.devAction!.toLowerCase().contains(value))
            .toList());

    notifyListeners();
  }

  setloading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setError(WeeklyError error) {
    _error = error;
    notifyListeners();
  }

  unsetError() {
    _error = null;
    notifyListeners();
  }

  nextDateRange() {
    _dateRange = DateTimeRange(
        start: _dateRange.start.add(Duration(days: 7)),
        end: _dateRange.end.add(Duration(days: 7)));
    getWeeklyList();

    notifyListeners();
  }

  previousDateRange() {
    _dateRange = DateTimeRange(
        start: _dateRange.start.subtract(Duration(days: 7)),
        end: _dateRange.end.subtract(Duration(days: 7)));
    getWeeklyList();

    notifyListeners();
  }

  setWeeklyList(List<Datum> weeklyListModel) {
    // _weeklyListModel = weeklyListModel;
    // filter data based on date range
    _weeklyListModel = weeklyListModel;
    viewWeeklyDataSource = ViewWeeklyDatatableSource(data: _weeklyListModel);
    notifyListeners();
  }

  getWeeklyList() async {
    setloading(true);
    Map par = {
      "startDate": DateFormat('yyyy/MM/dd').format(_dateRange.start),
      "endDate": DateFormat('yyyy/MM/dd').format(_dateRange.end),
    };
    var response = await WeeklyServices.getReportWeekly(par);
    if (response is Success) {
      setWeeklyList(response.response as List<Datum>);
      unsetError();
    }
    if (response is Failure) {
      WeeklyError error = WeeklyError(
        code: response.code,
        message: response.errorResponse.toString(),
      );
      setError(error);
    }
    setloading(false);
  }
}
