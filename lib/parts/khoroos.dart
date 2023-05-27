part of "../models/khoroos.dart";

Khoroos _$KhoroosFromJson(Map<String, dynamic> json) {
  return Khoroos(
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    districtId:
        json['districtId'] != null ? json['districtId'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
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
