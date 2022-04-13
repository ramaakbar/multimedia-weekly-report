import 'package:flutter/material.dart';
import 'package:weekly_report/widgets/filter_select.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Archives'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterSelect(
              dropdownValue: 'Nama Proyek',
              selectList: ['Nama Proyek', 'Deskripsi Proyek', 'WO No.'],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
