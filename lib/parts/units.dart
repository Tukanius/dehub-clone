part of '../models/units.dart';

Units _$UnitsFromJson(Map<String, dynamic> json) {
  return Units(
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    isPublic: json['isPublic'] != null ? json['isPublic'] as bool : null,
    isDehub: json['isDehub'] != null ? json['isDehub'] as bool : null,
  );
}

Map<String, dynamic> _$UnitsToJson(Units instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.isPublic != null) json['isPublic'] = instance.isPublic;
  if (instance.isDehub != null) json['isDehub'] = instance.isDehub;
  return json;
}
