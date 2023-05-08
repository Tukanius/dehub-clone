part '../parts/business_sectors.dart';

class BusinessSectors {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? refCode;
  String? partnerId;
  String? parentId;
  String? name;
  bool? isPublic;

  BusinessSectors({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.refCode,
    this.partnerId,
    this.parentId,
    this.name,
    this.isPublic,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$BusinessSectorsFromJson(json);

  factory BusinessSectors.fromJson(Map<String, dynamic> json) =>
      _$BusinessSectorsFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessSectorsToJson(this);
}
