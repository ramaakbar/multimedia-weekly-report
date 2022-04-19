import 'package:flutter/material.dart';
import 'package:weekly_report/widgets/archive_table.dart';
import 'package:weekly_report/widgets/filter_select.dart';
import 'package:weekly_report/widgets/refresh_icon.dart';
import 'package:weekly_report/widgets/wo_table.dart';
import 'package:weekly_report/view_models/archive_view_model.dart';
import 'package:provider/provider.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArchiveViewModel archive = context.watch<ArchiveViewModel>();
    // archive.getArchiveList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Archives'),
        actions: [
          RefreshIcon(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => archive.search(value),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ArchiveTable(),
            ),
          ],
        ),
      ),
    );
  }
}
