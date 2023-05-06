part of "../models/unit_space_labels.dart";

UnitSpaceLabels _$UnitSpaceLabelsFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return UnitSpaceLabels(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$UnitSpaceLabelsToJson(UnitSpaceLabels instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
