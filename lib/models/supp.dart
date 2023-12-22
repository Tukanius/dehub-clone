part '../parts/supp.dart';

class Suppliers {
  String id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? businessId;
  String? name;
  bool? isPublic;
  bool? isDehub;

  Suppliers({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.businessId,
    this.name,
    this.isPublic,
    this.isDehub,
  });

  static $fromJson(Map<String, dynamic> json) => _$SuppliersFromJson(json);

  factory Suppliers.fromJson(Map<String, dynamic> json) =>
      _$SuppliersFromJson(json);

  Map<String, dynamic> toJson() => _$SuppliersToJson(this);
}
