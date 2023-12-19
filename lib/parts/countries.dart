part of '../models/countries.dart';

Countries _$CountriesFromJson(Map<String, dynamic> json) {
  return Countries(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    nameEng: json['nameEng'] != null ? json['nameEng'] as String : null,
  );
}

Map<String, dynamic> _$CountriesToJson(Countries instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.nameEng != null) json['nameEng'] = instance.nameEng;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
