part '../parts/provinces.dart';

class Provinces {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;

  Provinces({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) => _$ProvincesFromJson(json);

  factory Provinces.fromJson(Map<String, dynamic> json) =>
      _$ProvincesFromJson(json);

  Map<String, dynamic> toJson() => _$ProvincesToJson(this);
}
