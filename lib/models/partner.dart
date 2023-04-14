part '../parts/partner.dart';

class Partner {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? legalEntityType;
  String? equityType;
  String? partnerCategory;
  String? ownerUserId;
  String? country;
  String? refCode;
  String? regUserId;
  String? registerStatus;
  String? contractStatus;
  String? partnerStatus;
  String? type;
  String? classification;
  String? businessName;
  String? businessNameEng;
  String? stateRegNum;
  String? stateRegDate;
  String? regNumber;
  bool? isVatPayer;
  String? web;
  String? email;
  String? email2;
  String? phone;
  String? phone2;
  String? fbLink;
  String? logo;
  String? provinceId;
  String? districtId;
  String? khorooId;
  String? khotkhonBair;
  String? khoroolol;
  String? khashaaDavkhar;
  String? khaalgaDugaar;
  String? businessAddress;
  double? locationLat;
  double? locationLng;
  bool? isAnchor;
  bool? isBuyer;
  bool? isSupplier;
  bool? isConfirmed;
  Partner? province;
  String? name;
  Partner? district;
  Partner? khoroo;

  Partner({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.legalEntityType,
    this.equityType,
    this.partnerCategory,
    this.ownerUserId,
    this.country,
    this.refCode,
    this.regUserId,
    this.registerStatus,
    this.contractStatus,
    this.partnerStatus,
    this.type,
    this.classification,
    this.businessName,
    this.businessNameEng,
    this.stateRegNum,
    this.stateRegDate,
    this.regNumber,
    this.isVatPayer,
    this.web,
    this.email,
    this.email2,
    this.phone,
    this.phone2,
    this.fbLink,
    this.logo,
    this.provinceId,
    this.districtId,
    this.khorooId,
    this.khotkhonBair,
    this.khoroolol,
    this.khashaaDavkhar,
    this.khaalgaDugaar,
    this.businessAddress,
    this.locationLat,
    this.locationLng,
    this.isAnchor,
    this.isBuyer,
    this.isSupplier,
    this.isConfirmed,
    this.province,
    this.name,
    this.district,
    this.khoroo,
  });

  static $fromJson(Map<String, dynamic> json) => _$PartnerFromJson(json);
  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerToJson(this);
}
