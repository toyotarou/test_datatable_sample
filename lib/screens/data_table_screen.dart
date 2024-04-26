import 'package:flutter/material.dart';

import '../model/country.dart';
import '../utils.dart';
import '../widget/flag_widget.dart';
import '../widget/scrollable_widget.dart';

class DataTableScreen extends StatefulWidget {
  const DataTableScreen({super.key});

  @override
  State<DataTableScreen> createState() => _DataTableScreenState();
}

class _DataTableScreenState extends State<DataTableScreen> {
  List<Country> countries = [];

  List<Country> selectedCountries = [];

  ///
  @override
  void initState() {
    super.initState();

    init();
  }

  ///
  Future<void> init() async {
    final countries = await Utils.loadCountries();

    setState(() => this.countries = countries);
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: countries.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Expanded(child: ScrollableWidget(child: buildDataTable())),
                  buildSubmit(),
                ],
              ),
            ),
    );
  }

  ///
  Widget buildDataTable() {
    final columns = ['Flag', 'Name', 'Native Name'];

    return DataTable(
      onSelectAll: (selectedAll) {
        setState(() => selectedCountries = selectedAll! ? countries : []);

        Utils.showSnackBar(context, 'All Selected: $selectedAll');
      },
      columns: getColumns(columns: columns),
      rows: getRows(countries: countries),
    );
  }

  ///
  List<DataColumn> getColumns({required List<String> columns}) {
    return columns.map((e) {
      return DataColumn(label: Text(e));
    }).toList();
  }

  ///
  List<DataRow> getRows({required List<Country> countries}) {
    return countries.map((e) {
      return DataRow(
        selected: selectedCountries.contains(e),
        onSelectChanged: (selected) {
          setState(() {
            final isAdding = selected != null && selected;

            isAdding ? selectedCountries.add(e) : selectedCountries.remove(e);
          });
        },
        cells: [
          DataCell(FlagWidget(code: e.code)),
          DataCell(Text(e.name)),
          DataCell(Text(e.nativeName)),
        ],
      );
    }).toList();
  }

  ///
  Widget buildSubmit() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        color: Colors.black,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            minimumSize: const Size.fromHeight(40),
          ),
          child: Text('Select ${selectedCountries.length} Countries'),
          onPressed: () {
            final names = selectedCountries.map((country) => country.name).join(', ');

            Utils.showSnackBar(context, 'Selected countries: $names');
          },
        ),
      );
}
