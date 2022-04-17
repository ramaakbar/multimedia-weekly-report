import 'package:flutter/material.dart';

class FilterSelect extends StatelessWidget {
  String dropdownValue = '';
  List<String> selectList = [];
  String label = '';

  FilterSelect(
      {Key? key,
      required this.dropdownValue,
      required this.selectList,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        value: dropdownValue,
        items: selectList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) => dropdownValue = newValue!);
  }
}
