part of "../models/business_sectors.dart";

BusinessSectors _$BusinessSectorsFromJson(Map<String, dynamic> json) {
  return BusinessSectors(
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    parentId: json['parentId'] != null ? json['parentId'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    isPublic: json['isPublic'] != null ? json['isPublic'] as bool : null,
  );
}

Map<String, dynamic> _$BusinessSectorsToJson(BusinessSectors instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.parentId != null) json['parentId'] = instance.parentId;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.isPublic != null) json['isPublic'] = instance.isPublic;

  return json;
}
