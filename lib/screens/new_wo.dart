import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_report/models/karyawan_model.dart';
import 'package:weekly_report/view_models/new_wo_view_model.dart';
import 'package:provider/provider.dart';
import 'package:weekly_report/widgets/refresh_icon.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;

class NewWo extends StatelessWidget {
  const NewWo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewWoViewModel newWo = context.watch<NewWoViewModel>();
    // newWo.getWorkAreaList();
    // newWo.getCrewList();
    // newWo.getBusinessList();
    newWo.getRequestorList();
    return Scaffold(
      appBar: AppBar(
        title: Text('New Multimedia WO'),
        actions: [
          RefreshIcon(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: newWo.woController,
              decoration: InputDecoration(
                labelText: 'WO Number',
                errorText: newWo.woNumber.error.isNotEmpty
                    ? newWo.woNumber.error
                    : null,
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                newWo.changeWoNumber(value);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Text('Start Date', style: TextStyle(fontSize: 16)),
                      OutlinedButton.icon(
                        onPressed: () {
                          newWo.pickDateStart(context, newWo.startDate);
                        },
                        icon: Icon(Icons.date_range),
                        label: Text(
                          DateFormat('MM/dd/yyyy').format(newWo.startDate),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Text('End Date', style: TextStyle(fontSize: 16)),
                      OutlinedButton.icon(
                        onPressed: () {
                          newWo.pickDateEnd(context, newWo.endDate);
                        },
                        icon: Icon(Icons.date_range),
                        label: Text(
                          DateFormat('MM/dd/yyyy').format(newWo.endDate),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            RequestorDropdown(),
            // TextField(
            //   decoration: InputDecoration(
            //     labelText: 'Requestor ID',
            //     errorText: newWo.requestorId.error.isNotEmpty
            //         ? newWo.requestorId.error
            //         : null,
            //     border: OutlineInputBorder(),
            //   ),
            //   onChanged: (String value) {
            //     newWo.changeRequestorId(value);
            //   },
            // ),
            const SizedBox(
              height: 20.0,
            ),
            BusinessUnitDropdown(),
            const SizedBox(
              height: 20.0,
            ),
            WorkAreaDropdown(),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Project Name',
                errorText: newWo.projectName.error.isNotEmpty
                    ? newWo.projectName.error
                    : null,
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                newWo.changeProjectName(value);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            CrewDropdown(),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                bool woAdded = newWo.submitData();
                if (!woAdded) {
                  return;
                }
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

// class RequestorDropdown extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (
//       context,
//       NewWoViewModel newWo,
//       child,
//     ) {
//       return DropdownButtonFormField(
//         decoration: const InputDecoration(
//           border: OutlineInputBorder(),
//           labelText: 'Requestor',
//         ),
//         value: newWo.selectedRequestor,
//         onChanged: <String>(String value) {
//           newWo.setSelectedRequestor(value.toString());
//         },
//         items: newWo.requestorList
//             .map((e) => DropdownMenuItem(
//                 child: Text('${e.username}'), value: e.username))
//             .toList(),
//       );
//     });
//   }
// }

class RequestorDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (
      context,
      NewWoViewModel newWo,
      child,
    ) {
      return DropdownSearch<Datum>(
          // decoration: const InputDecoration(
          //   border: OutlineInputBorder(),
          //   labelText: 'Requestor',
          // ),
          label: 'Requestor',
          mode: Mode.DIALOG,
          showSearchBox: true,
          // showSelectedItem: true,

          onChanged: <String>(String value) {
            newWo.setSelectedRequestor(value.toString());
          },
          dropdownBuilder: (context, selectedItem, test) =>
              Text(selectedItem?.username ?? 'Select Requestor'),
          popupItemBuilder: (context, item, isSelected) =>
              ListTile(title: Text(item.username)),
          onFind: (text) async {
            var url =
                Uri.parse('http://10.0.2.2:40/weekly_api/api/get_karyawan.php');
            var response = await http.get(url);

            if (response.statusCode != 200) {
              return [];
            }
            List req = karyawanFromJson(response.body).data;
            List<Datum> allModelReq = [];

            req.forEach((element) {
              //mengubah data json ke model
              allModelReq.add(Datum(
                idPtfi: element.idPtfi,
                username: element.username,
              ));
            });
            return allModelReq;
          });
    });
  }
}

class WorkAreaDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (
      context,
      NewWoViewModel newWo,
      child,
    ) {
      return DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Work Area',
        ),
        value: newWo.selectedWorkArea,
        onChanged: <String>(String value) {
          newWo.setSelectedWorkArea(value.toString());
        },
        items: newWo.workAreaList
            .map((e) => DropdownMenuItem(
                child: Text('${e.workCode} | ${e.workArea}'),
                value: e.workArea))
            .toList(),
      );
    });
  }
}

class CrewDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (
      context,
      NewWoViewModel crew,
      child,
    ) {
      return DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Assign to',
        ),
        value: crew.selectedCrew,
        onChanged: <String>(String value) {
          crew.setSelectedCrew(value.toString());
        },
        items: crew.crewList
            .map((e) => DropdownMenuItem(child: Text(e.name), value: e.idPtfi))
            .toList(),
      );
    });
  }
}

class BusinessUnitDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (
      context,
      NewWoViewModel businessUnit,
      child,
    ) {
      return DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Business Unit',
        ),
        value: businessUnit.selectedBusinessUnit,
        onChanged: <String>(String value) {
          businessUnit.setSelectedBusinessUnit(value.toString());
        },
        items: businessUnit.businessUnitList
            .map((e) => DropdownMenuItem(child: Text(e.name), value: e.name))
            .toList(),
      );
    });
  }
}
