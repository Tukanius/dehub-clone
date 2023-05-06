part of "../models/item_status.dart";

ItemStatus _$ItemStatusFromJson(Map<String, dynamic> json) {
  String? code;
  String? name;

  if (json['code'] != null) code = json['code'];
  if (json['name'] != null) name = json['name'];

  return ItemStatus(
    code: code,
    name: name,
  );
}

Map<String, dynamic> _$ItemStatusToJson(ItemStatus instance) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
