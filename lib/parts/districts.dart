part of "../models/districts.dart";

Districts _$DistrictsFromJson(Map<String, dynamic> json) {
  return Districts(
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    provinceId:
        json['provinceId'] != null ? json['provinceId'] as String : null,
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
