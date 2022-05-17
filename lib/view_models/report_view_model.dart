import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/models/weekly_error.dart';
import 'package:weekly_report/repo/api_status.dart';
import 'package:weekly_report/repo/weekly_services.dart';
import 'package:weekly_report/models/crewReport_model.dart' as cr;

class ReportViewModel extends ChangeNotifier {
  String? _selectedCrew = null;
  cr.Datum? _selectedWo;
  List _crewList = [];
  bool _loading = false;
  WeeklyError? _error;
  // DateTimeRange _dateRange = DateTimeRange(
  //     start: DateTime.now(), end: DateTime.now().add(Duration(days: 7)));
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  List<cr.Datum> _weeklyListModel = [];
  Map data = {};
  final _actionController = TextEditingController();
  final _hoursController = TextEditingController();
  final _progressController = TextEditingController();
  final _activityController = TextEditingController();

  // DateTimeRange get dateRange => _dateRange;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  String? get selectedCrew => _selectedCrew;
  cr.Datum? get selectedWo => _selectedWo;
  List get crewList => _crewList;
  List<cr.Datum> get weeklyListModel => _weeklyListModel;
  bool get loading => _loading;
  WeeklyError? get error => _error;
  get actionController => _actionController;
  get hoursController => _hoursController;
  get progressController => _progressController;
  get activityController => _activityController;

  ReportViewModel() {
    getCrewList();
    getWeeklyList();
    _actionController.text = '';
    _hoursController.text = '';
    _activityController.text = '';
  }

  setSelectedWo(cr.Datum wo) {
    _selectedWo = wo;
    // _actionController.text = wo.devAction?.toString() ?? 'null';
    // _hoursController.text = wo.manHours.toString();
    _progressController.text = wo.progress.toString();
    // _activityController.text = wo.activity?.toString() ?? 'null';
    notifyListeners();
  }

  void setSelectedCrew(final String item) {
    _selectedCrew = item;
    getWeeklyList();
    notifyListeners();
  }

  getCrewList() async {
    if (crewList.isEmpty) {
      var response = await WeeklyServices.getCrew();
      if (response is Success) {
        _crewList = response.response as List;

        notifyListeners();
      }
    }
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

  // pickDateRange(BuildContext context, dateRange) async {
  //   DateTimeRange? newDateRange = await showDateRangePicker(
  //       context: context,
  //       firstDate: DateTime(1900),
  //       lastDate: DateTime(2100),
  //       initialDateRange: dateRange);
  //   if (newDateRange == null) return;
  //   _dateRange = newDateRange;
  //   notifyListeners();
  // }
  pickDateStart(BuildContext context, date) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDate == null) return;
    _startDate = newDate;
    getWeeklyList();
    notifyListeners();
  }

  pickDateEnd(BuildContext context, date) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDate == null) return;
    _endDate = newDate;
    getWeeklyList();
    notifyListeners();
  }

  setWeeklyList(List<cr.Datum> weeklyListModel) {
    // _weeklyListModel = weeklyListModel;
    // filter data based on date range
    _weeklyListModel = weeklyListModel
        .where(
          (element) =>
              element.name == selectedCrew && element.woNumber != 'text',
          // element.dateSubmit!
          //     .isAfter(_startDate.subtract(const Duration(days: 1))) &&
          // element.dateSubmit!
          //     .isBefore(_endDate.add(const Duration(days: 1)))
          // ,
        )
        .toList();
    // print(_weeklyListModel);
    notifyListeners();
  }

  getWeeklyList() async {
    setloading(true);

    var response = await WeeklyServices.getCrewReport();
    if (response is Success) {
      setWeeklyList(response.response as List<cr.Datum>);
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

  // delete weekly
  deleteWeekly(String id) async {
    var response = await WeeklyServices.deleteWeekly(id);
    return response;
  }

  // update weekly
  updateWeekly() async {
    data.addAll({
      'id': _selectedWo?.id,
      'id_ptfi': selectedCrew,
      'wo_number': _selectedWo?.woNumber,
      'dev_action':
          int.parse(_progressController.text) < 100 ? 'Continue' : 'Done',
      'man_hours': _hoursController.text,
      'progress': _progressController.text,
      'activity': _activityController.text,
      'date_submit': DateFormat('yyyy/MM/dd').format(DateTime.now()),
    });
    var response = await WeeklyServices.updateWeekly(data);
    _actionController.text = '';
    _hoursController.text = '';
    _activityController.text = '';
    getWeeklyList();
    return response;
  }
}
