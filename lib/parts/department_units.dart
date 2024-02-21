part of "../models/department_units.dart";

DepartmentUnits _$DepartmentUnitsFromJson(Map<String, dynamic> json) {
  return DepartmentUnits(
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    parentId: json['parentId'] != null ? json['parentId'] as String : null,
    isPublic: json['isPublic'] != null ? json['isPublic'] as bool : null,
  );
}

Map<String, dynamic> _$DepartmentUnitsToJson(DepartmentUnits instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.parentId != null) json['parentId'] = instance.parentId;
  if (instance.isPublic != null) json['isPublic'] = instance.isPublic;

  return json;
}
