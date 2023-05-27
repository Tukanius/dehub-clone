part of "../models/unit_space_labels.dart";

UnitSpaceLabels _$UnitSpaceLabelsFromJson(Map<String, dynamic> json) {
  return UnitSpaceLabels(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$UnitSpaceLabelsToJson(UnitSpaceLabels instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
