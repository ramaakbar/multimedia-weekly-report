import 'package:flutter/material.dart';
import 'package:weekly_report/models/weekly_error.dart';
import 'package:weekly_report/models/archive_model.dart';
import 'package:weekly_report/repo/api_status.dart';
import 'package:weekly_report/repo/weekly_services.dart';
import 'package:weekly_report/utils/archive_datatable_source.dart';

class ArchiveViewModel extends ChangeNotifier {
  late ArchiveDatatableSource archiveDataSource;

  bool _loading = false;
  WeeklyError? _error;
  List<Datum> _archiveListModel = [];

  bool get loading => _loading;
  List<Datum> get archiveListModel => _archiveListModel;
  WeeklyError? get error => _error;

  ArchiveViewModel() {
    getArchiveList();
  }

  void search(String value) {
    archiveDataSource = ArchiveDatatableSource(
        data: archiveListModel
            .where((element) =>
                element.woNumber!.toLowerCase().contains(value) ||
                element.projectName!.toLowerCase().contains(value) ||
                element.name!.toLowerCase().contains(value))
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

  setArchiveList(List<Datum> archiveListModel) {
    // filter data based on date range
    _archiveListModel = archiveListModel;
    // .where((element) =>
    //     element.dateSubmit!
    //         .isAfter(_dateRange.start.subtract(const Duration(days: 1))) &&
    //     element.dateSubmit!
    //         .isBefore(_dateRange.end.add(const Duration(days: 1))))
    // .toList();
    archiveDataSource = ArchiveDatatableSource(data: _archiveListModel);
    notifyListeners();
  }

  getArchiveList() async {
    setloading(true);
    var response = await WeeklyServices.getArchive();
    if (response is Success) {
      setArchiveList(response.response as List<Datum>);
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
