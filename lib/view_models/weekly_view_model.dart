import 'package:flutter/material.dart';
import 'package:weekly_report/models/weekly_error.dart';
import 'package:weekly_report/models/weekly_model.dart';
import 'package:weekly_report/repo/api_status.dart';
import 'package:weekly_report/repo/weekly_services.dart';
import 'package:weekly_report/utils/weekly_datatable_source.dart';

class WeeklyViewModel extends ChangeNotifier {
  late WeeklyDatatableSource weeklyDataSource;

  bool _loading = false;
  WeeklyError? _error;
  List<Datum> _weeklyListModel = [];
  DateTime _date = DateTime.now().subtract(Duration(days: 7));
  // DateTime _date =
  //     DateTime(DateTime.now().year, 4, 6).subtract(Duration(days: 7));
  DateTimeRange _dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, 1, 5),
      end: DateTime(DateTime.now().year, 1, 5).add(Duration(days: 7)));

  bool get loading => _loading;
  List<Datum> get weeklyListModel => _weeklyListModel;
  WeeklyError? get error => _error;
  DateTimeRange get dateRange => _dateRange;

  WeeklyViewModel() {
    getWeeklyList();
    calcDate();
  }

  void calcDate() {
    // if (_date.isAfter(_dateRange.start.subtract(const Duration(days: 1))) &&
    //     _date.isBefore(_dateRange.end.add(const Duration(days: 1)))) {
    //   _dateRange =
    //       DateTimeRange(start: _date, end: _date.add(const Duration(days: 7)));
    // } else {
    //   _dateRange = DateTimeRange(
    //       start: _dateRange.start.add(Duration(days: 7)),
    //       end: _dateRange.end.add(Duration(days: 7)));
    // }
    //14
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
    weeklyDataSource = WeeklyDatatableSource(
        data: weeklyListModel
            .where((element) =>
                element.woNumber!.toLowerCase().contains(value) ||
                element.workArea!.toLowerCase().contains(value) ||
                element.projectName!.toLowerCase().contains(value) ||
                element.name!.toLowerCase().contains(value))
            .toList());

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

  setWeeklyList(List<Datum> weeklyListModel) {
    // _weeklyListModel = weeklyListModel;
    // filter data based on date range
    _weeklyListModel = weeklyListModel
        .where((element) =>
            element.dateSubmit!
                .isAfter(_dateRange.start.subtract(const Duration(days: 1))) &&
            element.dateSubmit!
                .isBefore(_dateRange.end.add(const Duration(days: 1))))
        .toList();
    weeklyDataSource = WeeklyDatatableSource(data: _weeklyListModel);
    notifyListeners();
  }

  getWeeklyList() async {
    setloading(true);
    var response = await WeeklyServices.getWeekly();
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
