// ignore_for_file: file_names

import 'package:hive/hive.dart';

part 'countryModel.g.dart';

@HiveType(typeId: 0)
class Country extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String flag;

  @HiveField(2)
  final int pop;

  @HiveField(3)
  final String region;

  @HiveField(4)
  final String capital;

  @HiveField(5)
  final String nname;

  @HiveField(6)
  final String currencyName;

  @HiveField(7)
  final bool indep;

  @HiveField(8)
  final String languages;

  @HiveField(9)
  final String currencySymbol;

  @HiveField(10)
  final String map;

  Country({
    required this.name,
    required this.flag,
    required this.pop,
    required this.region,
    required this.capital,
    required this.currencyName,
    required this.indep,
    required this.nname,
    required this.languages,
    required this.currencySymbol,
    required this.map,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      flag: json['flags']['png'],
      pop: json['population'],
      region: json['region'],
      capital: _parseCapital(json['capital']),
      languages: _parseLanguage(json['languages']),
      nname: json['name']['official'],
      indep: json['independent'] ?? false,
      currencyName: _parseCurrencyName(json['currencies']),
      currencySymbol: _parseCurrencySymbol(json['currencies']),
      map: json['maps']['googleMaps'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'flag': flag,
      'pop': pop,
      'region': region,
      'capital': capital,
      'nname': nname,
      'currencyName': currencyName,
      'indep': indep,
      'languages': languages,
      'currencySymbol': currencySymbol,
      'map': map,
    };
  }

  static String _parseCapital(dynamic capitalData) {
    if (capitalData is String) {
      return capitalData;
    } else if (capitalData is List && capitalData.isNotEmpty) {
      return capitalData[0];
    }
    return '';
  }

  static String _parseLanguage(dynamic languagesData) {
    if (languagesData is String) {
      return languagesData;
    } else if (languagesData is Map<String, dynamic> &&
        languagesData.isNotEmpty) {
      return languagesData.values.first;
    }
    return '';
  }

  static String _parseCurrencyName(dynamic currenciesData) {
    if (currenciesData is String) {
      return currenciesData;
    } else if (currenciesData is Map<String, dynamic> &&
        currenciesData.isNotEmpty) {
      return currenciesData.values.first['name'] ?? '';
    }
    return '';
  }

  static String _parseCurrencySymbol(dynamic currenciesData) {
    if (currenciesData is String) {
      return '';
    } else if (currenciesData is Map<String, dynamic> &&
        currenciesData.isNotEmpty) {
      return currenciesData.values.first['symbol'] ?? '';
    }
    return '';
  }
}
