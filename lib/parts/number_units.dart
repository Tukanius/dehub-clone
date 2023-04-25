part of "../models/number_units.dart";

NumberUnits _$NumberUnitsFromJson(Map<String, dynamic> json) {
  String? code;
  String? value;

  if (json[code] != null) code = json['code'];
  if (json[value] != null) value = json['value'];

  return NumberUnits(
    code: code,
    value: value,
  );
}

Map<String, dynamic> _$NumberUnitsToJson(NumberUnits instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.value != null) json['value'] = instance.value;

  return json;
}
