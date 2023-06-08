part of '../models/distribution_areas.dart';

DistributionAreas _$DistributionAreasFromJson(Map<String, dynamic> json) {
  return DistributionAreas(
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    parentId: json['parentId'] != null ? json['parentId'] as String : null,
    isParent: json['isParent'] != null ? json['isParent'] as bool : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
  );
}

Map<String, dynamic> _$DistributionAreasToJson(DistributionAreas instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.parentId != null) json['parentId'] = instance.parentId;
  if (instance.isParent != null) json['isParent'] = instance.isParent;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.description != null) json['description'] = instance.description;

  return json;
}
