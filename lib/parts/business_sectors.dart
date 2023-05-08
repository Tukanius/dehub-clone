part of "../models/business_sectors.dart";

BusinessSectors _$BusinessSectorsFromJson(Map<String, dynamic> json) {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? refCode;
  String? partnerId;
  String? parentId;
  String? name;
  bool? isPublic;

  if (json['id'] != null) id = json['id'];
  if (json['createdAt'] != null) createdAt = json['createdAt'];
  if (json['updatedAt'] != null) updatedAt = json['updatedAt'];
  if (json['deletedAt'] != null) deletedAt = json['deletedAt'];
  if (json['refCode'] != null) refCode = json['refCode'];
  if (json['partnerId'] != null) partnerId = json['partnerId'];
  if (json['parentId'] != null) parentId = json['parentId'];
  if (json['name'] != null) name = json['name'];
  if (json['isPublic'] != null) isPublic = json['isPublic'];

  return BusinessSectors(
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    refCode: refCode,
    partnerId: partnerId,
    parentId: parentId,
    name: name,
    isPublic: isPublic,
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
