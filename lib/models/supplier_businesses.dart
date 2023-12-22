part '../parts/supplier_businesses.dart';

class SupplierBusinesses {
  String id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? partnerId;
  String? refCode;
  String? type;
  String? regNumber;
  String? profileName;
  String? profileNameEng;
  String? purchaseType;
  String? productCategoryType;
  String? logo;
  String? businessStatus;

  SupplierBusinesses({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.refCode,
    this.type,
    this.regNumber,
    this.profileName,
    this.profileNameEng,
    this.businessStatus,
    this.purchaseType,
    this.partnerId,
    this.productCategoryType,
    this.logo,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$SupplierBusinessesFromJson(json);

  factory SupplierBusinesses.fromJson(Map<String, dynamic> json) =>
      _$SupplierBusinessesFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierBusinessesToJson(this);
}
