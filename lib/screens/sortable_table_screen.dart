import 'package:flutter/material.dart';

import '../model/country.dart';
import '../utils.dart';
import '../widget/scrollable_widget.dart';

class SortableTableScreen extends StatefulWidget {
  const SortableTableScreen({super.key});

  @override
  State<SortableTableScreen> createState() => _SortableTableScreenState();
}

class _SortableTableScreenState extends State<SortableTableScreen> {
  List<Country> countries = [];

  List<Country> selectedCountries = [];

  int? sortColumnIndex;
  bool isAscending = false;

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
                ],
              ),
            ),
    );
  }

  ///
  Widget buildDataTable() {
    final columns = ['Flag', 'Name', 'Native Name'];

    return DataTable(
      columns: getColumns(columns: columns),
      rows: getRows(countries: countries),
    );
  }

  ///
  List<DataColumn> getColumns({required List<String> columns}) =>
      columns.map((String column) => DataColumn(label: Text(column), onSort: onSort)).toList();

  ///
  List<DataRow> getRows({required List<Country> countries}) {
    return countries.map((e) {
      final cells = [e.code, e.name, e.nativeName];

      return DataRow(cells: getCells(cells));
    }).toList();
  }

  ///
  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) => DataCell(Text('$data'))).toList();

  ///
  Future<void> onSort(int columnIndex, bool ascending) async {
    if (columnIndex == 0) {
      countries.sort((country1, country2) => compareString(ascending, country1.code, country2.code));
    } else if (columnIndex == 1) {
      countries.sort((country1, country2) => compareString(ascending, country1.name, country2.name));
    } else if (columnIndex == 2) {
      countries.sort((country1, country2) => compareString(ascending, country1.nativeName, country2.nativeName));
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  ///
  int compareString(bool ascending, String value1, String value2) => ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
