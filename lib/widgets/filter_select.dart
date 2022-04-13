import 'package:flutter/material.dart';

class FilterSelect extends StatelessWidget {
  String dropdownValue = '';
  List<String> selectList = [];

  FilterSelect(
      {Key? key, required this.dropdownValue, required this.selectList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Filter',
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
