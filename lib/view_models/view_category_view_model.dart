import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/models/chart_model.dart';
import 'package:weekly_report/models/report_category_model.dart';
import 'package:weekly_report/models/weekly_error.dart';
import 'package:weekly_report/repo/api_status.dart';
import 'package:weekly_report/repo/weekly_services.dart';
import 'package:weekly_report/screens/tabs/view_category.dart';
import 'package:weekly_report/utils/view_category_datatable_source.dart';

class ViewCategoryViewModel extends ChangeNotifier {
  late ViewCategoryDatatableSource viewCategoryDatatableSource;

  bool _loading = false;
  WeeklyError? _error;
  List<Datum> _categoryListModel = [];
  DateTime _date = DateTime.now().subtract(Duration(days: 7));
  DateTimeRange _dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, 1, 6),
      end: DateTime(DateTime.now().year, 1, 5).add(Duration(days: 7)));
  int sum = 0;
  List<ChartModel> _chartData = [];

  bool get loading => _loading;
  List<Datum> get categoryListModel => _categoryListModel;
  WeeklyError? get error => _error;
  DateTimeRange get dateRange => _dateRange;

  List<ChartModel> get chartData => _chartData;
  void setChartData(List<ChartModel> chartData) {
    _chartData = chartData;
    notifyListeners();
  }

  // int get sum => _sum;
  // int set sum(int value) {
  //   _sum = value;
  //   notifyListeners();
  // }

  ViewCategoryViewModel() {
    getReportCategory();
    calcDate();
  }

  // void function sum of count column categorylist model data
  void sumCount() {
    sum = 0;
    for (int i = 0; i < _categoryListModel.length; i++) {
      sum += int.parse(_categoryListModel[i].count);
    }
  }

  void calcDate() {
    while (
        (!_dateRange.start.isAfter(_date.subtract(const Duration(days: 1))))) {
      _dateRange = DateTimeRange(
          start: _dateRange.start.add(Duration(days: 7)),
          end: _dateRange.end.add(Duration(days: 7)));
    }
    getReportCategory();

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
    getReportCategory();

    notifyListeners();
  }

  previousDateRange() {
    _dateRange = DateTimeRange(
        start: _dateRange.start.subtract(Duration(days: 7)),
        end: _dateRange.end.subtract(Duration(days: 7)));
    getReportCategory();

    notifyListeners();
  }

  setReportCategoryList(List<Datum> categoryListModel) {
    // _weeklyListModel = weeklyListModel;
    // filter data based on date range
    _categoryListModel = categoryListModel;
    // print(_categoryListModel);
    viewCategoryDatatableSource =
        ViewCategoryDatatableSource(data: _categoryListModel);

    setChartData([]);
    if (categoryListModel.isNotEmpty) {
      for (int i = 0; i < _categoryListModel.length; i++) {
        _chartData.add(ChartModel(
            name: _categoryListModel[i].workArea,
            count: int.parse(_categoryListModel[i].count)));
      }
    }

    sumCount();
    notifyListeners();
  }

  getReportCategory() async {
    setloading(true);
    Map par = {
      "startDate": DateFormat('yyyy/MM/dd').format(_dateRange.start),
      "endDate": DateFormat('yyyy/MM/dd').format(_dateRange.end),
    };
    var response = await WeeklyServices.getReportCategory(par);
    if (response is Success) {
      setReportCategoryList(response.response as List<Datum>);
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
