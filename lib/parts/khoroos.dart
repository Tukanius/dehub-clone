part of "../models/khoroos.dart";

Khoroos _$KhoroosFromJson(Map<String, dynamic> json) {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? districtId;
  String? name;

  if (json['id'] != null) id = json['id'];
  if (json['createdAt'] != null) createdAt = json['createdAt'];
  if (json['updatedAt'] != null) updatedAt = json['updatedAt'];
  if (json['deletedAt'] != null) deletedAt = json['deletedAt'];
  if (json['districtId'] != null) districtId = json['districtId'];
  if (json['name'] != null) name = json['name'];

  return Khoroos(
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    districtId: districtId,
    name: name,
  );
}

Map<String, dynamic> _$KhoroosToJson(Khoroos instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.districtId != null) json['districtId'] = instance.districtId;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
