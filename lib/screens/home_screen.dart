import 'package:flutter/material.dart';
import 'package:weekly_report/screens/new_wo.dart';
import 'package:weekly_report/widgets/filter_select.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multimedia Weekly Report'),
        actions: [
          IconButton(
            onPressed: () => {
              // showSearch(context: context, delegate: CustomSearchDelegate())
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
        child: Column(children: [
          FilterSelect(
            dropdownValue: 'Weekly Period',
            selectList: ['Weekly Period', 'Daily Period'],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => {},
                child: Row(
                  children: const [
                    Icon(Icons.chevron_left),
                    // Text('Previous'),
                  ],
                ),
              ),
              const Text(
                '3/30/2022 - 4/6/2022',
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () => {},
                child: Row(
                  children: const [
                    // Text('Next'),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewWo(),
            ),
          ),
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
