part of "../models/number_units.dart";

NumberUnits _$NumberUnitsFromJson(Map<String, dynamic> json) {
  return NumberUnits(
    code: json['code'] != null ? json['code'] as String : null,
    value: json['value'] != null ? json['value'] as String : null,
  );
}

Map<String, dynamic> _$NumberUnitsToJson(NumberUnits instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.value != null) json['value'] = instance.value;

  return json;
}
