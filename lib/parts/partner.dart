part of '../models/partner.dart';

Partner _$PartnerFromJson(Map<String, dynamic> json) {
  return Partner(
    user: json['user'] != null
        ? Partner.fromJson(json['user'] as Map<String, dynamic>)
        : null,
    employeeUnit: json['employeeUnit'] != null
        ? Partner.fromJson(json['employeeUnit'] as Map<String, dynamic>)
        : null,
    partner: json['partner'] != null
        ? Partner.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'].toString())
        : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    warehouseUserId: json['warehouseUserId'] != null
        ? json['warehouseUserId'] as String
        : null,
    warehouseName:
        json['warehouseName'] != null ? json['warehouseName'] as String : null,
    isMain: json['isMain'] != null ? json['isMain'] as bool : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    legalEntityType: json['legalEntityType'] != null
        ? json['legalEntityType'] as String
        : null,
    equityType:
        json['equityType'] != null ? json['equityType'] as String : null,
    partnerCategory: json['partnerCategory'] != null
        ? json['partnerCategory'] as String
        : null,
    ownerUserId:
        json['ownerUserId'] != null ? json['ownerUserId'] as String : null,
    url: json['url'] != null ? json['url'] as String : null,
    country: json['country'] != null ? json['country'] as String : null,
    warehouseStatus: json['warehouseStatus'] != null
        ? json['warehouseStatus'] as String
        : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    registerStatus: json['registerStatus'] != null
        ? json['registerStatus'] as String
        : null,
    contractStatus: json['contractStatus'] != null
        ? json['contractStatus'] as String
        : null,
    partnerStatus:
        json['partnerStatus'] != null ? json['partnerStatus'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    classification: json['classification'] != null
        ? json['classification'] as String
        : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    businessNameEng: json['businessNameEng'] != null
        ? json['businessNameEng'] as String
        : null,
    stateRegNum:
        json['stateRegNum'] != null ? json['stateRegNum'] as String : null,
    stateRegDate:
        json['stateRegDate'] != null ? json['stateRegDate'] as String : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    isVatPayer: json['isVatPayer'] != null ? json['isVatPayer'] as bool : null,
    web: json['web'] != null ? json['web'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    email2: json['email2'] != null ? json['email2'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    phone2: json['phone2'] != null ? json['phone2'] as String : null,
    fbLink: json['fbLink'] != null ? json['fbLink'] as String : null,
    logo: json['logo'] != null ? json['logo'] as String : null,
    provinceId:
        json['provinceId'] != null ? json['provinceId'] as String : null,
    districtId:
        json['districtId'] != null ? json['districtId'] as String : null,
    khorooId: json['khorooId'] != null ? json['khorooId'] as String : null,
    khotkhonBair:
        json['khotkhonBair'] != null ? json['khotkhonBair'] as String : null,
    khoroolol: json['khoroolol'] != null ? json['khoroolol'] as String : null,
    khashaaDavkhar: json['khashaaDavkhar'] != null
        ? json['khashaaDavkhar'] as String
        : null,
    khaalgaDugaar:
        json['khaalgaDugaar'] != null ? json['khaalgaDugaar'] as String : null,
    businessAddress: json['businessAddress'] != null
        ? json['businessAddress'] as String
        : null,
    locationLat: json['locationLat'] != null
        ? double.parse('${json['locationLat']}')
        : null,
    locationLng: json['locationLng'] != null
        ? double.parse('${json['locationLng']}')
        : null,
    isAnchor: json['isAnchor'] != null ? json['isAnchor'] as bool : null,
    isBuyer: json['isBuyer'] != null ? json['isBuyer'] as bool : null,
    isSupplier: json['isSupplier'] != null ? json['isSupplier'] as bool : null,
    isConfirmed:
        json['isConfirmed'] != null ? json['isConfirmed'] as bool : null,
    province: json['province'] != null ? json['province'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    district: json['district'] != null ? json['district'] as String : null,
    khoroo: json['khoroo'] != null ? json['khoroo'] as String : null,
    isAdmin: json['isAdmin'] != null ? json['isAdmin'] as bool : null,
    registrationType: json['registrationType'] != null
        ? json['registrationType'] as String
        : null,
    username: json['username'] != null ? json['username'] as String : null,
    sessionId: json['sessionId'] != null ? json['sessionId'] as String : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    currentBusinessId: json['currentBusinessId'] != null
        ? json['currentBusinessId'] as String
        : null,
    registerNo:
        json['registerNo'] != null ? json['registerNo'] as String : null,
    familyName:
        json['familyName'] != null ? json['familyName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    departmentUnitId: json['departmentUnitId'] != null
        ? json['departmentUnitId'] as String
        : null,
    departmentSubUnitId: json['departmentSubUnitId'] != null
        ? json['departmentSubUnitId'] as String
        : null,
    employeeUnitId: json['employeeUnitId'] != null
        ? json['employeeUnitId'] as String
        : null,
    userStatus:
        json['userStatus'] != null ? json['userStatus'] as String : null,
    currentBusiness: json['currentBusiness'] != null
        ? Partner.fromJson(json['currentBusiness'] as Map<String, dynamic>)
        : null,
    businessSubSector: json['businessSubSector'] != null
        ? Partner.fromJson(json['businessSubSector'] as Map<String, dynamic>)
        : null,
    businessSector: json['businessSector'] != null
        ? Partner.fromJson(json['businessSector'] as Map<String, dynamic>)
        : null,
    partnerName:
        json['partnerName'] != null ? json['partnerName'] as String : null,
    partnerNameEng: json['partnerNameEng'] != null
        ? json['partnerNameEng'] as String
        : null,
    businessSectorId: json['businessSectorId'] != null
        ? json['businessSectorId'] as String
        : null,
    businessSubSectorId: json['businessSubSectorId'] != null
        ? json['businessSubSectorId'] as String
        : null,
    purchaseType:
        json['purchaseType'] != null ? json['purchaseType'] as String : null,
    productCategoryType: json['productCategoryType'] != null
        ? json['productCategoryType'] as String
        : null,
    serviceCategoryType: json['serviceCategoryType'] != null
        ? json['serviceCategoryType'] as String
        : null,
    businessStatus: json['businessStatus'] != null
        ? json['businessStatus'] as String
        : null,
    isDefault: json['isDefault'] != null ? json['isDefault'] as bool : null,
    partnerEmail:
        json['partnerEmail'] != null ? json['partnerEmail'] as String : null,
    partnerEmail2:
        json['partnerEmail2'] != null ? json['partnerEmail2'] as String : null,
    partnerPhone:
        json['partnerPhone'] != null ? json['partnerPhone'] as String : null,
    partnerPhone2:
        json['partnerPhone2'] != null ? json['partnerPhone2'] as String : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
    profileNameEng: json['profileNameEng'] != null
        ? json['profileNameEng'] as String
        : null,
    profileInfo:
        json['profileInfo'] != null ? json['profileInfo'] as String : null,
    isAnchorBusiness: json['isAnchorBusiness'] != null
        ? json['isAnchorBusiness'] as bool
        : null,
    businessStaffs: json['businessStaffs'] != null
        ? (json['businessStaffs'] as List)
            .map((e) => BusinessStaffs.fromJson(e))
            .toList()
        : null,
    nameEng: json['nameEng'] != null ? json['nameEng'] as String : null,
    branchStatus:
        json['branchStatus'] != null ? json['branchStatus'] as String : null,
    branchAddress:
        json['branchAddress'] != null ? json['branchAddress'] as String : null,
    regUser: json['regUser'] != null
        ? Partner.fromJson(json['regUser'] as Map<String, dynamic>)
        : null,
    warehouseUser: json['warehouseUser'] != null
        ? Partner.fromJson(json['warehouseUser'] as Map<String, dynamic>)
        : null,
    buyers: json['buyers'] != null
        ? (json['buyers'] as List).map((e) => Partner.fromJson(e)).toList()
        : null,
    suppliers: json['suppliers'] != null
        ? (json['suppliers'] as List).map((e) => Partner.fromJson(e)).toList()
        : null,
    profileBanners: json['profileBanners'] != null
        ? (json['profileBanners'] as List)
            .map((e) => Partner.fromJson(e))
            .toList()
        : null,
    buyerIds: json['buyerIds'] != null
        ? (json['buyerIds'] as List).map((e) => e as String).toList()
        : null,
    supplierIds: json['supplierIds'] != null
        ? (json['supplierIds'] as List).map((e) => e as String).toList()
        : null,
  );
}

Map<String, dynamic> _$PartnerToJson(Partner instance) {
  Map<String, dynamic> json = {};

  if (instance.warehouseUser != null) {
    json['warehouseUser'] = instance.warehouseUser;
  }
  if (instance.supplierIds != null) {
    json['supplierIds'] = instance.supplierIds;
  }
  if (instance.buyerIds != null) {
    json['buyerIds'] = instance.buyerIds;
  }
  if (instance.warehouseStatus != null) {
    json['warehouseStatus'] = instance.warehouseStatus;
  }
  if (instance.nameEng != null) json['nameEng'] = instance.nameEng;
  if (instance.branchStatus != null) {
    json['branchStatus'] = instance.branchStatus;
  }
  if (instance.branchAddress != null) {
    json['branchAddress'] = instance.branchAddress;
  }
  if (instance.warehouseUserId != null) {
    json['warehouseUserId'] = instance.warehouseUserId;
  }
  if (instance.warehouseName != null) {
    json['warehouseName'] = instance.warehouseName;
  }
  if (instance.businessSubSector != null) {
    json['businessSubSector'] = instance.businessSubSector;
  }
  if (instance.businessSector != null) {
    json['businessSector'] = instance.businessSector;
  }
  if (instance.regUser != null) json['regUser'] = instance.regUser;
  if (instance.isMain != null) json['isMain'] = instance.isMain;
  if (instance.buyers != null) json['buyers'] = instance.buyers;
  if (instance.suppliers != null) json['suppliers'] = instance.suppliers;
  if (instance.profileBanners != null) {
    json['profileBanners'] = instance.profileBanners;
  }

  if (instance.employeeUnit != null) {
    json['employeeUnit'] = instance.employeeUnit;
  }
  if (instance.currentBusinessId != null) {
    json['currentBusinessId'] = instance.currentBusinessId;
  }
  if (instance.departmentUnitId != null) {
    json['departmentUnitId'] = instance.departmentUnitId;
  }
  if (instance.departmentSubUnitId != null) {
    json['departmentSubUnitId'] = instance.departmentSubUnitId;
  }
  if (instance.employeeUnitId != null) {
    json['employeeUnitId'] = instance.employeeUnitId;
  }
  if (instance.userStatus != null) json['userStatus'] = instance.userStatus;
  if (instance.partnerName != null) json['partnerName'] = instance.partnerName;
  if (instance.partnerNameEng != null) {
    json['partnerNameEng'] = instance.partnerNameEng;
  }
  if (instance.businessSectorId != null) {
    json['businessSectorId'] = instance.businessSectorId;
  }
  if (instance.businessSubSectorId != null) {
    json['businessSubSectorId'] = instance.businessSubSectorId;
  }
  if (instance.purchaseType != null) {
    json['purchaseType'] = instance.purchaseType;
  }
  if (instance.productCategoryType != null) {
    json['productCategoryType'] = instance.productCategoryType;
  }
  if (instance.serviceCategoryType != null) {
    json['serviceCategoryType'] = instance.serviceCategoryType;
  }
  if (instance.businessStatus != null) {
    json['businessStatus'] = instance.businessStatus;
  }
  if (instance.businessStaffs != null) {
    json['businessStaffs'] = instance.businessStaffs;
  }
  if (instance.isAnchorBusiness != null) {
    json['isAnchorBusiness'] = instance.isAnchorBusiness;
  }
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.partnerEmail != null) {
    json['partnerEmail'] = instance.partnerEmail;
  }
  if (instance.partnerEmail2 != null) {
    json['partnerEmail2'] = instance.partnerEmail2;
  }
  if (instance.partnerPhone != null) {
    json['partnerPhone'] = instance.partnerPhone;
  }
  if (instance.partnerPhone2 != null) {
    json['partnerPhone2'] = instance.partnerPhone2;
  }
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.profileInfo != null) json['profileInfo'] = instance.profileInfo;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.familyName != null) json['familyName'] = instance.familyName;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.isAdmin != null) json['isAdmin'] = instance.isAdmin;
  if (instance.username != null) json['username'] = instance.username;
  if (instance.sessionId != null) json['sessionId'] = instance.sessionId;
  if (instance.profileNameEng != null) {
    json['profileNameEng'] = instance.profileNameEng;
  }
  if (instance.currentBusiness != null) {
    json['currentBusiness'] = instance.currentBusiness;
  }
  if (instance.user != null) json['user'] = instance.user;
  if (instance.registrationType != null) {
    json['registrationType'] = instance.registrationType;
  }
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.legalEntityType != null) {
    json['legalEntityType'] = instance.legalEntityType;
  }
  if (instance.equityType != null) json['equityType'] = instance.equityType;
  if (instance.partnerCategory != null) {
    json['partnerCategory'] = instance.partnerCategory;
  }
  if (instance.ownerUserId != null) json['ownerUserId'] = instance.ownerUserId;
  if (instance.country != null) json['country'] = instance.country;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.registerStatus != null) {
    json['registerStatus'] = instance.registerStatus;
  }
  if (instance.contractStatus != null) {
    json['contractStatus'] = instance.contractStatus;
  }
  if (instance.partnerStatus != null) {
    json['partnerStatus'] = instance.partnerStatus;
  }
  if (instance.type != null) json['type'] = instance.type;
  if (instance.classification != null) {
    json['classification'] = instance.classification;
  }
  if (instance.businessName != null) {
    json['businessName'] = instance.businessName;
  }
  if (instance.businessNameEng != null) {
    json['businessNameEng'] = instance.businessNameEng;
  }
  if (instance.stateRegNum != null) json['stateRegNum'] = instance.stateRegNum;
  if (instance.url != null) json['url'] = instance.url;
  if (instance.stateRegDate != null) {
    json['stateRegDate'] = instance.stateRegDate;
  }
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.isVatPayer != null) json['isVatPayer'] = instance.isVatPayer;
  if (instance.web != null) json['web'] = instance.web;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.email2 != null) json['email2'] = instance.email2;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.phone2 != null) json['phone2'] = instance.phone2;
  if (instance.fbLink != null) json['fbLink'] = instance.fbLink;
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.provinceId != null) json['provinceId'] = instance.provinceId;
  if (instance.districtId != null) json['districtId'] = instance.districtId;
  if (instance.khorooId != null) json['khorooId'] = instance.khorooId;
  if (instance.khotkhonBair != null) {
    json['khotkhonBair'] = instance.khotkhonBair;
  }
  if (instance.khoroolol != null) json['khoroolol'] = instance.khoroolol;
  if (instance.khashaaDavkhar != null) {
    json['khashaaDavkhar'] = instance.khashaaDavkhar;
  }
  if (instance.khaalgaDugaar != null) {
    json['khaalgaDugaar'] = instance.khaalgaDugaar;
  }
  if (instance.businessAddress != null) {
    json['businessAddress'] = instance.businessAddress;
  }
  if (instance.locationLat != null) json['locationLat'] = instance.locationLat;
  if (instance.locationLng != null) json['locationLng'] = instance.locationLng;
  if (instance.isAnchor != null) json['isAnchor'] = instance.isAnchor;
  if (instance.isBuyer != null) json['isBuyer'] = instance.isBuyer;
  if (instance.isSupplier != null) json['isSupplier'] = instance.isSupplier;
  if (instance.isConfirmed != null) json['isConfirmed'] = instance.isConfirmed;
  if (instance.province != null) json['province'] = instance.province;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.district != null) json['district'] = instance.district;
  if (instance.khoroo != null) json['khoroo'] = instance.khoroo;

  return json;
}
