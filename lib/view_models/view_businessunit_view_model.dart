import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/models/chart_model.dart';
import 'package:weekly_report/models/report_businessunit_model.dart';
import 'package:weekly_report/models/weekly_error.dart';
import 'package:weekly_report/repo/api_status.dart';
import 'package:weekly_report/repo/weekly_services.dart';
import 'package:weekly_report/utils/view_businessunit_datatable_source.dart';

class ViewBusinessunitViewModel extends ChangeNotifier {
  late ViewBusinessunitDatatableSource viewBusinessunitDatatableSource;

  bool _loading = false;
  WeeklyError? _error;
  List<Datum> _businessunitListModel = [];
  DateTime _date = DateTime.now().subtract(Duration(days: 7));
  DateTimeRange _dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, 1, 5),
      end: DateTime(DateTime.now().year, 1, 5).add(Duration(days: 7)));
  int sum = 0;
  List<ChartModel> _chartData = [];

  bool get loading => _loading;
  List<Datum> get businessunitListModel => _businessunitListModel;
  WeeklyError? get error => _error;
  DateTimeRange get dateRange => _dateRange;

  List<ChartModel> get chartData => _chartData;
  void setChartData(List<ChartModel> chartData) {
    _chartData = chartData;
    notifyListeners();
  }

  ViewBusinessunitViewModel() {
    getReportBusiness();
    calcDate();
  }

  void sumCount() {
    sum = 0;
    for (int i = 0; i < _businessunitListModel.length; i++) {
      sum += int.parse(_businessunitListModel[i].count);
    }
  }

  void calcDate() {
    while (
        (!_dateRange.start.isAfter(_date.subtract(const Duration(days: 1))))) {
      _dateRange = DateTimeRange(
          start: _dateRange.start.add(Duration(days: 7)),
          end: _dateRange.end.add(Duration(days: 7)));
    }
    getReportBusiness();

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
    getReportBusiness();

    notifyListeners();
  }

  previousDateRange() {
    _dateRange = DateTimeRange(
        start: _dateRange.start.subtract(Duration(days: 7)),
        end: _dateRange.end.subtract(Duration(days: 7)));
    getReportBusiness();

    notifyListeners();
  }

  setReportBusinessList(List<Datum> businessListModel) {
    // _weeklyListModel = weeklyListModel;
    // filter data based on date range
    _businessunitListModel = businessListModel;
    // print(_categoryListModel);
    viewBusinessunitDatatableSource =
        ViewBusinessunitDatatableSource(data: _businessunitListModel);

    setChartData([]);
    if (businessunitListModel.isNotEmpty) {
      for (int i = 0; i < _businessunitListModel.length; i++) {
        _chartData.add(ChartModel(
            name: _businessunitListModel[i].businessUnit,
            count: int.parse(_businessunitListModel[i].count)));
      }
    }

    sumCount();
    notifyListeners();
  }

  getReportBusiness() async {
    setloading(true);
    Map par = {
      "startDate": DateFormat('yyyy/MM/dd').format(_dateRange.start),
      "endDate": DateFormat('yyyy/MM/dd').format(_dateRange.end),
    };
    var response = await WeeklyServices.getReportBusinessUnit(par);
    if (response is Success) {
      setReportBusinessList(response.response as List<Datum>);
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
