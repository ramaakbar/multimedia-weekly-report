import 'package:flutter/material.dart';
import 'package:weekly_report/repo/api_status.dart';
import 'package:weekly_report/repo/weekly_services.dart';

class ReportViewModel extends ChangeNotifier {
  String? _selectedCrew;
  List _crewList = [];
  DateTimeRange _dateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 7)));

  DateTimeRange get dateRange => _dateRange;
  String? get selectedCrew => _selectedCrew;
  List get crewList => _crewList;

  ReportViewModel() {
    getCrewList();
  }

  void setSelectedCrew(final String item) {
    _selectedCrew = item;
    notifyListeners();
  }

  getCrewList() async {
    if (crewList.isEmpty) {
      var response = await WeeklyServices.getCrew();
      if (response is Success) {
        _crewList = response.response as List;
        _selectedCrew = _crewList[0].idPtfi;

        notifyListeners();
      }
    }
  }

  pickDateRange(BuildContext context, dateRange) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateRange);
    if (newDateRange == null) return;
    _dateRange = newDateRange;
    notifyListeners();
  }
}
