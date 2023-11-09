part '../parts/business_network.dart';

class BusinessNetwork {
  int? count;
  List<BusinessNetwork>? rows;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? partnerId;
  String? regNumber;
  String? stateRegNum;
  String? legalEntityType;
  String? partnerName;
  String? partnerNameEng;
  String? refCode;
  String? businessSectorId;
  String? businessSubSectorId;
  String? type;
  String? purchaseType;
  String? productCategoryType;
  String? serviceCategoryType;
  String? businessStatus;
  bool? isDefault;
  bool? isVatPayer;
  String? partnerEmail;
  String? partnerEmail2;
  String? partnerPhone;
  String? partnerPhone2;
  String? profileName;
  String? profileNameEng;
  String? logo;
  String? profileInfo;
  bool? isAnchorBusiness;
  BusinessNetwork? partner;
  BusinessNetwork? businessSector;
  BusinessNetwork? businessSubSector;
  String? name;
  BusinessNetwork? inAcc;
  String? businessId;
  List<String>? businessIds;
  String? regUserId;
  String? bankName;
  String? number;
  String? shortName;
  String? currency;
  bool? isVerified;
  bool? isActive;
  double? balance;
  BusinessNetwork? outAcc;
  BusinessNetwork? paymentTerm;
  String? modifiedUserId;
  String? termRule;
  String? orderConfirmTerm;
  int? expireDayCount;
  int? month;
  int? paymentDay;
  String? description;
  bool? isMain;
  bool? isOpen;
  BusinessNetwork? coBusinessCategory;
  bool? isParent;
  BusinessNetwork? coBusinessPriority;
  String? coBusinessClassDesc;
  BusinessNetwork? coBusinessClassSetUser;
  String? avatar;
  String? lastName;
  String? firstName;
  BusinessNetwork? coBusinessRegion;
  String? coBusinessClassSetDate;
  BusinessNetwork? coBusinessDirection;
  String? coBusinessAreaDesc;
  BusinessNetwork? coBusinessAreaSetUser;
  String? coBusinessAreaSetDate;
  BusinessNetwork? coBusinessStaff;
  BusinessNetwork? coBusinessStaff2;
  String? coBusinessStaffDesc;
  BusinessNetwork? coBusinessStaffSetUser;
  String? coBusinessStaffSetDate;
  BusinessNetwork? staff;
  BusinessNetwork? branch;
  String? businessNameEng;
  String? businessName;
  BusinessNetwork? financeStaff;
  String? phone;
  String? email;
  List<BusinessNetwork>? staffs;
  BusinessNetwork? businessInAcc;
  BusinessNetwork? businessOutAcc;
  List<BusinessNetwork>? branches;
  String? nameEng;
  String? branchStatus;
  bool? isSupplier;
  bool? isBuyer;
  String? provinceId;
  String? districtId;
  String? khorooId;
  String? khoroolol;
  String? khotkhonBair;
  String? khashaaDavkhar;
  String? khaalgaDugaar;
  String? branchAddress;
  double? locationLat;
  double? locationLng;
  BusinessNetwork? businessStaff;
  BusinessNetwork? businessStaff2;
  BusinessNetwork? areaRegion;
  BusinessNetwork? areaDirection;
  String? businessStaffId;
  String? businessStaff2Id;
  String? coBusinessStaffId;
  String? businessStaffDesc;
  String? condition;
  String? configType;
  String? paymentTermId;
  String? paymentTermStartDate;
  String? paymentTermEndDate;
  String? areaRegionId;
  String? areaDirectionId;
  String? areaDesc;
  String? country;
  String? equityType;
  String? userPhone;
  String? userEmail;
  String? toMessage;
  String? province;
  String? district;
  String? khoroo;
  BusinessNetwork? classificationCategory;
  BusinessNetwork? classificationPriority;

  String? classificationCategoryId;
  String? classificationPriorityId;
  String? classificationDesc;

  BusinessNetwork({
    this.classificationCategoryId,
    this.classificationPriorityId,
    this.classificationDesc,
    this.classificationCategory,
    this.classificationPriority,
    this.province,
    this.district,
    this.khoroo,
    this.businessNameEng,
    this.equityType,
    this.userPhone,
    this.userEmail,
    this.toMessage,
    this.country,
    this.areaRegionId,
    this.areaDirectionId,
    this.areaDesc,
    this.paymentTermId,
    this.paymentTermStartDate,
    this.paymentTermEndDate,
    this.configType,
    this.condition,
    this.businessStaffId,
    this.businessStaff2Id,
    this.coBusinessStaffId,
    this.businessStaffDesc,
    this.areaRegion,
    this.areaDirection,
    this.businessStaff,
    this.businessStaff2,
    this.financeStaff,
    this.phone,
    this.email,
    this.staffs,
    this.businessInAcc,
    this.businessOutAcc,
    this.branches,
    this.nameEng,
    this.branchStatus,
    this.isSupplier,
    this.isBuyer,
    this.provinceId,
    this.districtId,
    this.khorooId,
    this.khoroolol,
    this.khotkhonBair,
    this.khashaaDavkhar,
    this.khaalgaDugaar,
    this.branchAddress,
    this.locationLat,
    this.locationLng,
    this.businessName,
    this.count,
    this.rows,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.partnerId,
    this.regNumber,
    this.stateRegNum,
    this.legalEntityType,
    this.partnerName,
    this.partnerNameEng,
    this.refCode,
    this.businessSectorId,
    this.businessSubSectorId,
    this.type,
    this.purchaseType,
    this.productCategoryType,
    this.serviceCategoryType,
    this.businessStatus,
    this.isDefault,
    this.isVatPayer,
    this.partnerEmail,
    this.partnerEmail2,
    this.partnerPhone,
    this.partnerPhone2,
    this.profileName,
    this.profileNameEng,
    this.logo,
    this.profileInfo,
    this.isAnchorBusiness,
    this.partner,
    this.businessSector,
    this.businessSubSector,
    this.name,
    this.inAcc,
    this.businessId,
    this.businessIds,
    this.regUserId,
    this.bankName,
    this.number,
    this.shortName,
    this.currency,
    this.isVerified,
    this.isActive,
    this.balance,
    this.outAcc,
    this.paymentTerm,
    this.modifiedUserId,
    this.termRule,
    this.orderConfirmTerm,
    this.expireDayCount,
    this.month,
    this.paymentDay,
    this.description,
    this.isMain,
    this.isOpen,
    this.coBusinessCategory,
    this.isParent,
    this.coBusinessPriority,
    this.coBusinessClassDesc,
    this.coBusinessClassSetUser,
    this.avatar,
    this.lastName,
    this.firstName,
    this.coBusinessRegion,
    this.coBusinessClassSetDate,
    this.coBusinessDirection,
    this.coBusinessAreaDesc,
    this.coBusinessAreaSetUser,
    this.coBusinessAreaSetDate,
    this.coBusinessStaff,
    this.coBusinessStaff2,
    this.coBusinessStaffDesc,
    this.coBusinessStaffSetUser,
    this.coBusinessStaffSetDate,
    this.staff,
    this.branch,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$BusinessNetworkFromJson(json);

  factory BusinessNetwork.fromJson(Map<String, dynamic> json) =>
      _$BusinessNetworkFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessNetworkToJson(this);
}
