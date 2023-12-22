part of '../models/supp.dart';

Suppliers _$SuppliersFromJson(Map<String, dynamic> json) {
  return Suppliers(
    id: json['id'] as String,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    isDehub: json['isDehub'] != null ? json['isDehub'] as bool : null,
    isPublic: json['isPublic'] != null ? json['isPublic'] as bool : null,
  );
}

Map<String, dynamic> _$SuppliersToJson(Suppliers instance) {
  Map<String, dynamic> json = {};

  json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.isPublic != null) json['isPublic'] = instance.isPublic;
  if (instance.isDehub != null) json['isDehub'] = instance.isDehub;

  return json;
}
