import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/models/validation_item.dart';
import 'package:weekly_report/models/workarea_model.dart';
import 'package:weekly_report/repo/api_status.dart';
import 'package:weekly_report/repo/weekly_services.dart';

class NewWoViewModel extends ChangeNotifier {
  ValidationItem _woNumber = ValidationItem('', '');
  DateTimeRange _dateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 7)));
  ValidationItem _requestorId = ValidationItem('', '');
  String? _selectedWorkArea;
  String? _selectedBusinessUnit;
  String? _selectedCrew;
  // ValidationItem _requestorName = ValidationItem('', '');
  ValidationItem _projectName = ValidationItem('', '');

  Map data = {};
  List<Datum> _workAreaList = [];
  List _crewList = [];
  List _businessUnitList = [];

  NewWoViewModel() {
    getWorkAreaList();
    getCrewList();
    getBusinessList();
  }

  void reset() {
    _woNumber = ValidationItem('', '');
    _requestorId = ValidationItem('', '');
    _projectName = ValidationItem('', '');
  }

  //geters
  ValidationItem get woNumber => _woNumber;
  DateTimeRange get dateRange => _dateRange;
  ValidationItem get requestorId => _requestorId;
  String? get selectedWorkArea => _selectedWorkArea;
  String? get selectedBusinessUnit => _selectedBusinessUnit;
  String? get selectedCrew => _selectedCrew;

  void setSelectedWorkArea(final String item) {
    _selectedWorkArea = item;
    notifyListeners();
  }

  void setSelectedCrew(final String item) {
    _selectedCrew = item;
    notifyListeners();
  }

  void setSelectedBusinessUnit(final String item) {
    _selectedBusinessUnit = item;
    notifyListeners();
  }

  // ValidationItem get requestorName => _requestorName;

  ValidationItem get projectName => _projectName;
  List<Datum> get workAreaList => _workAreaList;
  List get businessUnitList => _businessUnitList;

  List get crewList => _crewList;
  bool get isValid {
    if (woNumber.value != '' &&
        _requestorId.value != '' &&
        _projectName.value != '' &&
        _selectedWorkArea != null) {
      return true;
    } else {
      return false;
    }
  }

  getWorkAreaList() async {
    if (workAreaList.isEmpty) {
      var response = await WeeklyServices.getWorkArea();
      if (response is Success) {
        _workAreaList = response.response as List<Datum>;
        _selectedWorkArea = _workAreaList[0].workArea;

        notifyListeners();
      }
    }
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

  getBusinessList() async {
    if (businessUnitList.isEmpty) {
      var response = await WeeklyServices.getBusiness();
      if (response is Success) {
        _businessUnitList = response.response as List;
        _selectedBusinessUnit = _businessUnitList[0].name;

        notifyListeners();
      }
    }
  }

  //setters
  void changeWoNumber(String value) {
    if (value.length >= 2) {
      _woNumber = ValidationItem(value, '');
    } else {
      _woNumber = ValidationItem('', 'WO Number must be atleast 3 characters');
    }
    notifyListeners();
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

  void changeRequestorId(String value) {
    if (value.length >= 2) {
      _requestorId = ValidationItem(value, '');
    } else {
      _requestorId =
          ValidationItem('', 'Requestor ID must be atleast 3 characters');
    }
    notifyListeners();
  }

  void changeProjectName(String value) {
    if (value.length >= 2) {
      _projectName = ValidationItem(value, '');
    } else {
      _projectName =
          ValidationItem('', 'Project Name must be atleast 3 characters');
    }
    notifyListeners();
  }

  submitData() {
    if (isValid) {
      data.addAll({
        'wo_number': _woNumber.value,
        'start_date': DateFormat('yyyy/MM/dd').format(_dateRange.start),
        'end_date': DateFormat('yyyy/MM/dd').format(_dateRange.end),
        'requestor_name': _requestorId.value,
        'business_unit': _selectedBusinessUnit,
        'work_area': selectedWorkArea,
        'project_name': _projectName.value,
        'assigned': selectedCrew,
        "progress": null,
        "id_ptfi": selectedCrew,
        "activity": null,
        "dev_action": null,
        "man_hours": null,
        'date_submit': DateFormat('yyyy/MM/dd').format(DateTime.now()),
      });
      // print(data);
      var response = WeeklyServices.postWeekly(data);
      reset();
      return true;
    } else {
      _woNumber = ValidationItem(woNumber.value, 'WO Number must be filled');
      _requestorId =
          ValidationItem(requestorId.value, 'Requestor ID must be filled');

      _projectName =
          ValidationItem(projectName.value, 'Project Name must be filled');

      notifyListeners();
      return false;
    }
  }
}
