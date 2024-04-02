// ignore_for_file: file_names

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../models/countryModel.dart';

class CountryApi {
  static const String baseUrl = 'https://restcountries.com/v3.1/all';

  static Future<List<Country>> getCountries() async {
    final Box<Country> box = await Hive.openBox<Country>('countries');

    if (box.isNotEmpty) {
      return box.values.toList();
    }

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);

      List<Country> countries =
          jsonList.map((json) => Country.fromJson(json)).toList();

      await box.addAll(countries);

      return countries;
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
