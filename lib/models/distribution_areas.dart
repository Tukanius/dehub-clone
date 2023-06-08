part '../parts/distribution_areas.dart';

class DistributionAreas {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? businessId;
  String? regUserId;
  String? parentId;
  bool? isParent;
  String? refCode;
  String? name;
  String? description;

  DistributionAreas({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.businessId,
    this.regUserId,
    this.parentId,
    this.isParent,
    this.refCode,
    this.name,
    this.description,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$DistributionAreasFromJson(json);

  factory DistributionAreas.fromJson(Map<String, dynamic> json) =>
      _$DistributionAreasFromJson(json);

  Map<String, dynamic> toJson() => _$DistributionAreasToJson(this);
}
