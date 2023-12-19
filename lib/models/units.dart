part '../parts/units.dart';

class Units {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? businessId;
  String? name;
  bool? isPublic;
  bool? isDehub;

  Units({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.businessId,
    this.name,
    this.isPublic,
    this.isDehub,
  });

  static $fromJson(Map<String, dynamic> json) => _$UnitsFromJson(json);

  factory Units.fromJson(Map<String, dynamic> json) => _$UnitsFromJson(json);

  Map<String, dynamic> toJson() => _$UnitsToJson(this);
}
