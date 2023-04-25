part of "../models/districts.dart";

Districts _$DistrictsFromJson(Map<String, dynamic> json) {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;
  String? provinceId;

  if (json['id'] != null) id = json['id'];
  if (json['createdAt'] != null) createdAt = json['createdAt'];
  if (json['updatedAt'] != null) updatedAt = json['updatedAt'];
  if (json['deletedAt'] != null) deletedAt = json['deletedAt'];
  if (json['name'] != null) name = json['name'];
  if (json['provinceId'] != null) provinceId = json['provinceId'];

  return Districts(
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    name: name,
    provinceId: provinceId,
  );
}

Map<String, dynamic> _$DistrictsToJson(Districts instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.provinceId != null) json['provinceId'] = instance.provinceId;

  return json;
}
