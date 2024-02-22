part of "../models/access_levels.dart";

AccessLevels _$AccessLevelsFromJson(Map<String, dynamic> json) {
  return AccessLevels(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$AccessLevelsToJson(AccessLevels instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
