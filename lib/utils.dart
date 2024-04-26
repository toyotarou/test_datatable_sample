import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/country.dart';

mixin Utils {
  ///
  static Future<void> showSnackBar(BuildContext context, String text) async {
    final snackBar = SnackBar(content: Text(text));

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  ///
  static List<T> modelBuilder<M, T>(List<M> models, T Function(int index, M model) builder) =>
      models.asMap().map<int, T>((index, model) => MapEntry(index, builder(index, model))).values.toList();

  ///
  static Future<List<Country>> loadCountries() async {
    final data = await rootBundle.loadString('assets/country_codes.json');
    final countriesJson = json.decode(data);

    return countriesJson.keys.map<Country>((code) {
      final json = countriesJson[code];
      final newJson = json..addAll({'code': code.toLowerCase()});

      return Country.fromJson(newJson);
    }).toList()
      ..sort(Utils.ascendingSort);
  }

  ///
  static int ascendingSort(Country c1, Country c2) => c1.name.compareTo(c2.name);
}
