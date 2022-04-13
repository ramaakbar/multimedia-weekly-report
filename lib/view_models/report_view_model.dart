import 'package:flutter/material.dart';

class ReportViewModel extends ChangeNotifier {
  DateTimeRange _dateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 7)));

  DateTimeRange get dateRange => _dateRange;

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
