import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/models/validation_item.dart';
import 'package:weekly_report/models/workarea_model.dart';
import 'package:weekly_report/models/karyawan_model.dart' as karyawan;
import 'package:weekly_report/repo/api_status.dart';
import 'package:weekly_report/repo/weekly_services.dart';
import 'package:weekly_report/models/weekly_model.dart' as wm;

class NewWoViewModel extends ChangeNotifier {
  ValidationItem _woNumber = ValidationItem('', '');
  // DateTimeRange _dateRange = DateTimeRange(
  //     start: DateTime.now(), end: DateTime.now().add(Duration(days: 7)));
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  // ValidationItem _requestorId = ValidationItem('', '');
  String? _selectedWorkArea;
  String? _selectedBusinessUnit;
  String? _selectedCrew;
  String? _selectedRequestor;
  // ValidationItem _requestorName = ValidationItem('', '');
  ValidationItem _projectName = ValidationItem('', '');
  final _woController = TextEditingController();

  Map data = {};
  List<karyawan.Datum> _requestorList = [];
  List<Datum> _workAreaList = [];
  List _crewList = [];
  List _businessUnitList = [];

  NewWoViewModel() {
    _selectedRequestor = null;
    _selectedWorkArea = null;
    _selectedCrew = null;
    _selectedBusinessUnit = null;
    getWorkAreaList();
    getCrewList();
    getBusinessList();
    getRequestorList();
  }

  void reset() {
    // _requestorId = ValidationItem('', '');
    _projectName = ValidationItem('', '');
    getWorkAreaList();
    getCrewList();
    getBusinessList();
    getRequestorList();
  }

  //geters
  ValidationItem get woNumber => _woNumber;
  // DateTimeRange get dateRange => _dateRange;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  // ValidationItem get requestorId => _requestorId;
  String? get selectedRequestor => _selectedRequestor;
  String? get selectedWorkArea => _selectedWorkArea;
  String? get selectedBusinessUnit => _selectedBusinessUnit;
  String? get selectedCrew => _selectedCrew;
  get woController => _woController;

  // set wo number text field to the latest wo number
  void setController(wm.Datum wo) {
    // get the latest wo Number from list of wo + 1
    // _woController.text = wo.woNumber!.split('/')[0] +
    //     '/' +
    //     (int.parse(wo.woNumber!.split('/')[1]) + 1).toString();
    _woController.text = (int.parse(wo.woNumber!) + 1).toString();

    _woNumber = ValidationItem(_woController.text, '');
  }

  void setSelectedRequestor(final String item) {
    // _selectedRequestor = null;
    _selectedRequestor = item;
    notifyListeners();
  }

  void setSelectedWorkArea(final String item) {
    // _selectedWorkArea = null;
    _selectedWorkArea = item;
    notifyListeners();
  }

  void setSelectedCrew(final String item) {
    // _selectedCrew = null;
    _selectedCrew = item;
    notifyListeners();
  }

  void setSelectedBusinessUnit(final String item) {
    // _selectedBusinessUnit = null;
    _selectedBusinessUnit = item;
    notifyListeners();
  }

  // ValidationItem get requestorName => _requestorName;

  ValidationItem get projectName => _projectName;
  List<karyawan.Datum> get requestorList => _requestorList;
  List<Datum> get workAreaList => _workAreaList;
  List get businessUnitList => _businessUnitList;

  List get crewList => _crewList;
  bool get isValid {
    if (woNumber.value != '' &&
        // _requestorId.value != '' &&
        _projectName.value != '' &&
        _selectedWorkArea != null) {
      return true;
    } else {
      return false;
    }
  }

  getRequestorList() async {
    if (requestorList.isEmpty) {
      var response = await WeeklyServices.getKaryawan();
      if (response is Success) {
        _requestorList = response.response as List<karyawan.Datum>;
        // _selectedRequestor = _requestorList[0].;

        notifyListeners();
      }
    }
  }

  bool reqSearch(String value) {
    return _requestorList.any((element) =>
        element.username.toLowerCase().contains(value.toLowerCase()));
  }

  getWorkAreaList() async {
    if (workAreaList.isEmpty) {
      var response = await WeeklyServices.getWorkArea();
      if (response is Success) {
        _workAreaList = response.response as List<Datum>;
        // _selectedWorkArea = _workAreaList[0].workArea;

        notifyListeners();
      }
    }
  }

  getCrewList() async {
    if (crewList.isEmpty) {
      var response = await WeeklyServices.getCrew();
      if (response is Success) {
        _crewList = response.response as List;
        // _selectedCrew = _crewList[0].idPtfi;

        notifyListeners();
      }
    }
  }

  getBusinessList() async {
    if (businessUnitList.isEmpty) {
      var response = await WeeklyServices.getBusiness();
      if (response is Success) {
        _businessUnitList = response.response as List;
        // _selectedBusinessUnit = _businessUnitList[0].name;

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
        'start_date': DateFormat('yyyy/MM/dd').format(_startDate),
        'end_date': DateFormat('yyyy/MM/dd').format(_endDate),
        'requestor_name': _selectedRequestor,
        'business_unit': _selectedBusinessUnit,
        'work_area': selectedWorkArea,
        'project_name': _projectName.value,
        'assigned': selectedCrew,
        "progress": 0,
        "id_ptfi": selectedCrew,
        "activity": null,
        "dev_action": null,
        "man_hours": null,
        'date_submit': DateFormat('yyyy/MM/dd').format(DateTime.now()),
      });
      // print(data);
      var response = WeeklyServices.postWeekly(data);
      _startDate = DateTime.now();
      _endDate = DateTime.now();
      _selectedRequestor = null;
      _selectedWorkArea = null;
      _selectedCrew = null;
      _selectedBusinessUnit = null;
      return true;
    } else {
      // _woNumber = ValidationItem(woNumber.value, 'WO Number must be filled');
      // _requestorId =
      //     ValidationItem(requestorId.value, 'Requestor ID must be filled');

      _projectName =
          ValidationItem(projectName.value, 'Project Name must be filled');

      notifyListeners();
      return false;
    }
  }
}
