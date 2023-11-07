part '../parts/business.dart';

class Business {
  int? count;
  List<Business>? rows;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? refCode;
  String? type;
  String? profileName;
  String? profileNameEng;
  String? businessSectorId;
  String? businessSubSectorId;
  bool? isDefault;
  String? purchaseType;
  String? productCategoryType;
  String? serviceCategoryType;
  String? logo;
  String? profileInfo;
  bool? isAnchorBusiness;
  String? businessStatus;
  String? partnerId;
  String? regNumber;
  String? partnerName;
  String? partnerNameEng;
  String? partnerEmail;
  String? partnerEmail2;
  String? partnerPhone;
  String? partnerPhone2;
  String? legalEntityType;
  Business? partner;
  String? regUserId;
  String? ownerUserId;
  String? registerStatus;
  String? registrationType;
  String? classification;
  String? partnerCategory;
  String? equityType;
  String? country;
  String? businessName;
  String? businessNameEng;
  String? web;
  String? email;
  String? email2;
  String? phone;
  String? phone2;
  String? fbLink;
  String? province;
  String? district;
  String? khoroo;
  String? khoroolol;
  String? khotkhonBair;
  String? khashaaDavkhar;
  String? khaalgaDugaar;
  String? businessAddress;
  double? locationLat;
  double? locationLng;
  Business? staff;
  String? firstName;
  String? lastName;
  String? avatar;
  String? toMessage;
  bool? send;
  List<String>? receiverIds;
  DateTime? start;
  DateTime? end;
  List<Business>? stats;
  String? name;
  double? percent;

  String? description;
  String? businessId;
  String? modifiedUserId;
  int? expireDayCount;
  String? paymentDay;
  String? condition;
  String? configType;
  int? advancePercent;
  int? confirmationDay;
  bool? isMain;
  bool? isOpen;
  bool? isActive;

  Business({
    this.description,
    this.businessId,
    this.modifiedUserId,
    this.expireDayCount,
    this.paymentDay,
    this.condition,
    this.configType,
    this.advancePercent,
    this.confirmationDay,
    this.isMain,
    this.isOpen,
    this.isActive,
    this.percent,
    this.name,
    this.start,
    this.end,
    this.stats,
    this.toMessage,
    this.send,
    this.receiverIds,
    this.count,
    this.rows,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.refCode,
    this.type,
    this.profileName,
    this.profileNameEng,
    this.businessSectorId,
    this.businessSubSectorId,
    this.isDefault,
    this.purchaseType,
    this.productCategoryType,
    this.serviceCategoryType,
    this.logo,
    this.profileInfo,
    this.isAnchorBusiness,
    this.businessStatus,
    this.partnerId,
    this.regNumber,
    this.partnerName,
    this.partnerNameEng,
    this.partnerEmail,
    this.partnerEmail2,
    this.partnerPhone,
    this.partnerPhone2,
    this.legalEntityType,
    this.partner,
    this.regUserId,
    this.ownerUserId,
    this.registerStatus,
    this.registrationType,
    this.classification,
    this.partnerCategory,
    this.equityType,
    this.country,
    this.businessName,
    this.businessNameEng,
    this.web,
    this.email,
    this.email2,
    this.phone,
    this.phone2,
    this.fbLink,
    this.province,
    this.district,
    this.khoroo,
    this.khoroolol,
    this.khotkhonBair,
    this.khashaaDavkhar,
    this.khaalgaDugaar,
    this.businessAddress,
    this.locationLat,
    this.locationLng,
    this.staff,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  static $fromJson(Map<String, dynamic> json) => _$BusinessFromJson(json);

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}
