import 'package:dehub/models/business_staffs.dart';

part '../parts/partner.dart';

class Partner {
  Partner? partner;
  String? id;
  DateTime? createdAt;
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
  String? province;
  String? name;
  String? district;
  String? khoroo;
  Partner? employeeUnit;
  bool? isAdmin;
  String? registrationType;
  String? username;
  String? sessionId;
  String? partnerId;
  String? businessId;
  String? currentBusinessId;
  String? registerNo;
  String? familyName;
  String? firstName;
  String? lastName;
  String? avatar;
  String? departmentUnitId;
  String? departmentSubUnitId;
  String? employeeUnitId;
  String? userStatus;
  Partner? currentBusiness;
  String? partnerName;
  String? partnerNameEng;
  String? businessSectorId;
  String? businessSubSectorId;
  String? purchaseType;
  String? productCategoryType;
  String? serviceCategoryType;
  String? businessStatus;
  bool? isDefault;
  String? partnerEmail;
  String? partnerEmail2;
  String? partnerPhone;
  String? partnerPhone2;
  String? profileName;
  String? profileNameEng;
  String? profileInfo;
  bool? isAnchorBusiness;
  List<BusinessStaffs>? businessStaffs;
  Partner? user;
  bool? isSysUser;
  bool? isAppUser;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  bool? isDanVerified;
  String? loginType;
  String? identityCardFront;
  String? identityCardBack;
  bool? hasPassword;
  bool? hasPin;
  String? nameEng;
  String? branchStatus;
  String? branchAddress;
  Partner? regUser;
  List<Partner>? buyers;
  List<Partner>? suppliers;
  List<Partner>? profileBanners;
  Partner? businessSector;
  Partner? businessSubSector;
  Partner? warehouseUser;
  String? warehouseStatus;
  String? url;
  bool? isMain;
  List<String>? buyerIds;
  List<String>? supplierIds;
  String? warehouseName;
  String? warehouseUserId;

  Partner? departmentUnit;

  Partner({
    this.departmentUnit,
    this.warehouseUserId,
    this.warehouseName,
    this.supplierIds,
    this.buyerIds,
    this.isMain,
    this.url,
    this.warehouseStatus,
    this.warehouseUser,
    this.businessSubSector,
    this.businessSector,
    this.nameEng,
    this.branchStatus,
    this.branchAddress,
    this.regUser,
    this.buyers,
    this.suppliers,
    this.profileBanners,
    this.user,
    this.employeeUnit,
    this.partner,
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
    this.isAdmin,
    this.registrationType,
    this.username,
    this.sessionId,
    this.partnerId,
    this.businessId,
    this.currentBusinessId,
    this.registerNo,
    this.familyName,
    this.firstName,
    this.lastName,
    this.avatar,
    this.departmentUnitId,
    this.departmentSubUnitId,
    this.employeeUnitId,
    this.userStatus,
    this.currentBusiness,
    this.partnerName,
    this.partnerNameEng,
    this.businessSectorId,
    this.businessSubSectorId,
    this.purchaseType,
    this.productCategoryType,
    this.serviceCategoryType,
    this.businessStatus,
    this.isDefault,
    this.partnerEmail,
    this.partnerEmail2,
    this.partnerPhone,
    this.partnerPhone2,
    this.profileName,
    this.profileNameEng,
    this.profileInfo,
    this.isAnchorBusiness,
    this.businessStaffs,
  });

  static $fromJson(Map<String, dynamic> json) => _$PartnerFromJson(json);
  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerToJson(this);
}
