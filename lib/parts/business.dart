part of '../models/business.dart';

Business _$BusinessFromJson(Map<String, dynamic> json) {
  return Business(
    count: json['count'] != null ? int.parse(json['count'].toString()) : null,
    rows: json['rows'] != null
        ? (json['rows'] as List).map((e) => Business.fromJson(e)).toList()
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
    profileNameEng: json['profileNameEng'] != null
        ? json['profileNameEng'] as String
        : null,
    businessSectorId: json['businessSectorId'] != null
        ? json['businessSectorId'] as String
        : null,
    businessSubSectorId: json['businessSubSectorId'] != null
        ? json['businessSubSectorId'] as String
        : null,
    isDefault: json['isDefault'] != null ? json['isDefault'] as bool : null,
    purchaseType:
        json['purchaseType'] != null ? json['purchaseType'] as String : null,
    productCategoryType: json['productCategoryType'] != null
        ? json['productCategoryType'] as String
        : null,
    serviceCategoryType: json['serviceCategoryType'] != null
        ? json['serviceCategoryType'] as String
        : null,
    logo: json['logo'] != null ? json['logo'] as String : null,
    profileInfo:
        json['profileInfo'] != null ? json['profileInfo'] as String : null,
    isAnchorBusiness: json['isAnchorBusiness'] != null
        ? json['isAnchorBusiness'] as bool
        : null,
    businessStatus: json['businessStatus'] != null
        ? json['businessStatus'] as String
        : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    partnerName:
        json['partnerName'] != null ? json['partnerName'] as String : null,
    partnerNameEng: json['partnerNameEng'] != null
        ? json['partnerNameEng'] as String
        : null,
    partnerEmail:
        json['partnerEmail'] != null ? json['partnerEmail'] as String : null,
    partnerEmail2:
        json['partnerEmail2'] != null ? json['partnerEmail2'] as String : null,
    partnerPhone:
        json['partnerPhone'] != null ? json['partnerPhone'] as String : null,
    partnerPhone2:
        json['partnerPhone2'] != null ? json['partnerPhone2'] as String : null,
    legalEntityType: json['legalEntityType'] != null
        ? json['legalEntityType'] as String
        : null,
    partner: json['partner'] != null
        ? Business.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    ownerUserId:
        json['ownerUserId'] != null ? json['ownerUserId'] as String : null,
    registerStatus: json['registerStatus'] != null
        ? json['registerStatus'] as String
        : null,
    registrationType: json['registrationType'] != null
        ? json['registrationType'] as String
        : null,
    classification: json['classification'] != null
        ? json['classification'] as String
        : null,
    partnerCategory: json['partnerCategory'] != null
        ? json['partnerCategory'] as String
        : null,
    equityType:
        json['equityType'] != null ? json['equityType'] as String : null,
    country: json['country'] != null ? json['country'] as String : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    businessNameEng: json['businessNameEng'] != null
        ? json['businessNameEng'] as String
        : null,
    web: json['web'] != null ? json['web'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    email2: json['email2'] != null ? json['email2'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    phone2: json['phone2'] != null ? json['phone2'] as String : null,
    fbLink: json['fbLink'] != null ? json['fbLink'] as String : null,
    province: json['province'] != null ? json['province'] as String : null,
    district: json['district'] != null ? json['district'] as String : null,
    khoroo: json['khoroo'] != null ? json['khoroo'] as String : null,
    khoroolol: json['khoroolol'] != null ? json['khoroolol'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    khotkhonBair:
        json['khotkhonBair'] != null ? json['khotkhonBair'] as String : null,
    khashaaDavkhar: json['khashaaDavkhar'] != null
        ? json['khashaaDavkhar'] as String
        : null,
    khaalgaDugaar:
        json['khaalgaDugaar'] != null ? json['khaalgaDugaar'] as String : null,
    businessAddress: json['businessAddress'] != null
        ? json['businessAddress'] as String
        : null,
    locationLat: json['locationLat'] != null
        ? double.parse(json['locationLat'].toString())
        : null,
    percent: json['percent'] != null
        ? double.parse(json['percent'].toString())
        : null,
    locationLng: json['locationLng'] != null
        ? double.parse(json['locationLng'].toString())
        : null,
    staff: json['staff'] != null
        ? Business.fromJson(json['staff'] as Map<String, dynamic>)
        : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    toMessage: json['toMessage'] != null ? json['toMessage'] as String : null,
    send: json['send'] != null ? json['send'] as bool : null,
    receiverIds: json['receiverIds'] != null
        ? (json['receiverIds'] as List).map((e) => e as String).toList()
        : null,
    start:
        json['start'] != null ? DateTime.parse(json['start'].toString()) : null,
    end: json['end'] != null ? DateTime.parse(json['end'].toString()) : null,
    stats: json['stats'] != null
        ? (json['stats'] as List).map((e) => Business.fromJson(e)).toList()
        : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    modifiedUserId: json['modifiedUserId'] != null
        ? json['modifiedUserId'] as String
        : null,
    expireDayCount: json['expireDayCount'] != null
        ? int.parse(json['expireDayCount'].toString())
        : null,
    paymentDay: json['paymentDay'] != null
        ? int.parse(json['paymentDay'].toString())
        : null,
    condition: json['condition'] != null ? json['condition'] as String : null,
    configType:
        json['configType'] != null ? json['configType'] as String : null,
    advancePercent: json['advancePercent'] != null
        ? int.parse(json['advancePercent'].toString())
        : null,
    confirmationDay: json['confirmationDay'] != null
        ? int.parse(json['confirmationDay'].toString())
        : null,
    isMain: json['isMain'] != null ? json['isMain'] as bool : null,
    isOpen: json['isOpen'] != null ? json['isOpen'] as bool : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
  );
}

Map<String, dynamic> _$BusinessToJson(Business instance) {
  Map<String, dynamic> json = {};

  if (instance.toMessage != null) json['toMessage'] = instance.toMessage;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.modifiedUserId != null)
    json['modifiedUserId'] = instance.modifiedUserId;
  if (instance.expireDayCount != null)
    json['expireDayCount'] = instance.expireDayCount;
  if (instance.paymentDay != null) json['paymentDay'] = instance.paymentDay;
  if (instance.condition != null) json['condition'] = instance.condition;
  if (instance.configType != null) json['configType'] = instance.configType;
  if (instance.advancePercent != null)
    json['advancePercent'] = instance.advancePercent;
  if (instance.confirmationDay != null)
    json['confirmationDay'] = instance.confirmationDay;
  if (instance.isMain != null) json['isMain'] = instance.isMain;
  if (instance.isOpen != null) json['isOpen'] = instance.isOpen;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.start != null) json['start'] = instance.start;
  if (instance.end != null) json['end'] = instance.end;
  if (instance.stats != null) json['stats'] = instance.stats;
  if (instance.send != null) json['send'] = instance.send;
  if (instance.receiverIds != null) json['receiverIds'] = instance.receiverIds;
  if (instance.count != null) json['count'] = instance.count;
  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.profileNameEng != null)
    json['profileNameEng'] = instance.profileNameEng;
  if (instance.businessSectorId != null)
    json['businessSectorId'] = instance.businessSectorId;
  if (instance.businessSubSectorId != null)
    json['businessSubSectorId'] = instance.businessSubSectorId;
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.purchaseType != null)
    json['purchaseType'] = instance.purchaseType;
  if (instance.productCategoryType != null)
    json['productCategoryType'] = instance.productCategoryType;
  if (instance.serviceCategoryType != null)
    json['serviceCategoryType'] = instance.serviceCategoryType;
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.profileInfo != null) json['profileInfo'] = instance.profileInfo;
  if (instance.isAnchorBusiness != null)
    json['isAnchorBusiness'] = instance.isAnchorBusiness;
  if (instance.businessStatus != null)
    json['businessStatus'] = instance.businessStatus;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.partnerName != null) json['partnerName'] = instance.partnerName;
  if (instance.partnerNameEng != null)
    json['partnerNameEng'] = instance.partnerNameEng;
  if (instance.partnerEmail != null)
    json['partnerEmail'] = instance.partnerEmail;
  if (instance.partnerEmail2 != null)
    json['partnerEmail2'] = instance.partnerEmail2;
  if (instance.partnerPhone != null)
    json['partnerPhone'] = instance.partnerPhone;
  if (instance.partnerPhone2 != null)
    json['partnerPhone2'] = instance.partnerPhone2;
  if (instance.legalEntityType != null)
    json['legalEntityType'] = instance.legalEntityType;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.ownerUserId != null) json['ownerUserId'] = instance.ownerUserId;
  if (instance.registerStatus != null)
    json['registerStatus'] = instance.registerStatus;
  if (instance.registrationType != null)
    json['registrationType'] = instance.registrationType;
  if (instance.classification != null)
    json['classification'] = instance.classification;
  if (instance.partnerCategory != null)
    json['partnerCategory'] = instance.partnerCategory;
  if (instance.equityType != null) json['equityType'] = instance.equityType;
  if (instance.country != null) json['country'] = instance.country;
  if (instance.businessName != null)
    json['businessName'] = instance.businessName;
  if (instance.businessNameEng != null)
    json['businessNameEng'] = instance.businessNameEng;
  if (instance.web != null) json['web'] = instance.web;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.email2 != null) json['email2'] = instance.email2;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.phone2 != null) json['phone2'] = instance.phone2;
  if (instance.fbLink != null) json['fbLink'] = instance.fbLink;
  if (instance.province != null) json['province'] = instance.province;
  if (instance.district != null) json['district'] = instance.district;
  if (instance.khoroo != null) json['khoroo'] = instance.khoroo;
  if (instance.khoroolol != null) json['khoroolol'] = instance.khoroolol;
  if (instance.khotkhonBair != null)
    json['khotkhonBair'] = instance.khotkhonBair;
  if (instance.khashaaDavkhar != null)
    json['khashaaDavkhar'] = instance.khashaaDavkhar;
  if (instance.khaalgaDugaar != null)
    json['khaalgaDugaar'] = instance.khaalgaDugaar;
  if (instance.businessAddress != null)
    json['businessAddress'] = instance.businessAddress;
  if (instance.locationLat != null) json['locationLat'] = instance.locationLat;
  if (instance.locationLng != null) json['locationLng'] = instance.locationLng;
  if (instance.staff != null) json['staff'] = instance.staff;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.percent != null) json['percent'] = instance.percent;

  return json;
}
