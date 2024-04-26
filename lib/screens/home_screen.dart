import 'package:flutter/material.dart';

import 'data_table_screen.dart';
import 'sortable_table_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DataTableScreen()));
              },
              child: const Text('DataTableScreen'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SortableTableScreen()));
              },
              child: const Text('SortableTableScreen'),
            ),
          ],
        ),
      ),
    );
  }
}
