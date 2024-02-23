part of "../models/actions.dart";

Actions _$ActionsFromJson(Map<String, dynamic> json) {
  return Actions(
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    module: json['module'] != null ? json['module'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
  );
}

Map<String, dynamic> _$ActionsToJson(Actions instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.module != null) json['module'] = instance.module;
  if (instance.description != null) json['description'] = instance.description;

  return json;
}
