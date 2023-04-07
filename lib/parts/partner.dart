part of '../models/partner.dart';

Partner _$PartnerFromJson(Map<String, dynamic> json) {
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
  String? locationLat;
  String? locationLng;
  bool? isAnchor;
  bool? isBuyer;
  bool? isSupplier;
  bool? isConfirmed;
  Partner? province;
  String? name;
  Partner? district;
  Partner? khoroo;

  if (json['id'] != null) id = json['id'];
  if (json['createdAt'] != null) createdAt = json['createdAt'];
  if (json['updatedAt'] != null) updatedAt = json['updatedAt'];
  if (json['deletedAt'] != null) deletedAt = json['deletedAt'];
  if (json['legalEntityType'] != null)
    legalEntityType = json['legalEntityType'];
  if (json['equityType'] != null) equityType = json['equityType'];
  if (json['partnerCategory'] != null)
    partnerCategory = json['partnerCategory'];
  if (json['ownerUserId'] != null) ownerUserId = json['ownerUserId'];
  if (json['country'] != null) country = json['country'];
  if (json['refCode'] != null) refCode = json['refCode'];
  if (json['regUserId'] != null) regUserId = json['regUserId'];
  if (json['registerStatus'] != null) registerStatus = json['registerStatus'];
  if (json['contractStatus'] != null) contractStatus = json['contractStatus'];
  if (json['partnerStatus'] != null) partnerStatus = json['partnerStatus'];
  if (json['type'] != null) type = json['type'];
  if (json['classification'] != null) classification = json['classification'];
  if (json['businessName'] != null) businessName = json['businessName'];
  if (json['businessNameEng'] != null)
    businessNameEng = json['businessNameEng'];
  if (json['stateRegNum'] != null) stateRegNum = json['stateRegNum'];
  if (json['stateRegDate'] != null) stateRegDate = json['stateRegDate'];
  if (json['regNumber'] != null) regNumber = json['regNumber'];
  if (json['isVatPayer'] != null) isVatPayer = json['isVatPayer'];
  if (json['web'] != null) web = json['web'];
  if (json['email'] != null) email = json['email'];
  if (json['email2'] != null) email2 = json['email2'];
  if (json['phone'] != null) phone = json['phone'];
  if (json['phone2'] != null) phone2 = json['phone2'];
  if (json['fbLink'] != null) fbLink = json['fbLink'];
  if (json['logo'] != null) logo = json['logo'];
  if (json['provinceId'] != null) provinceId = json['provinceId'];
  if (json['districtId'] != null) districtId = json['districtId'];
  if (json['khorooId'] != null) khorooId = json['khorooId'];
  if (json['khotkhonBair'] != null) khotkhonBair = json['khotkhonBair'];
  if (json['khoroolol'] != null) khoroolol = json['khoroolol'];
  if (json['khashaaDavkhar'] != null) khashaaDavkhar = json['khashaaDavkhar'];
  if (json['khaalgaDugaar'] != null) khaalgaDugaar = json['khaalgaDugaar'];
  if (json['businessAddress'] != null)
    businessAddress = json['businessAddress'];
  if (json['locationLat'] != null) locationLat = json['locationLat'];
  if (json['locationLng'] != null) locationLng = json['locationLng'];
  if (json['isAnchor'] != null) isAnchor = json['isAnchor'];
  if (json['isBuyer'] != null) isBuyer = json['isBuyer'];
  if (json['isSupplier'] != null) isSupplier = json['isSupplier'];
  if (json['isConfirmed'] != null) isConfirmed = json['isConfirmed'];
  if (json['province'] != null) {
    province = Partner.fromJson(json['province'] as Map<String, dynamic>);
  }
  ;
  if (json['name'] != null) name = json['name'];
  if (json['district'] != null) {
    district = Partner.fromJson(json['district'] as Map<String, dynamic>);
  }
  ;
  if (json['khoroo'] != null) {
    khoroo = Partner.fromJson(json['khoroo'] as Map<String, dynamic>);
  }
  ;

  return Partner(
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    legalEntityType: legalEntityType,
    equityType: equityType,
    partnerCategory: partnerCategory,
    ownerUserId: ownerUserId,
    country: country,
    refCode: refCode,
    regUserId: regUserId,
    registerStatus: registerStatus,
    contractStatus: contractStatus,
    partnerStatus: partnerStatus,
    type: type,
    classification: classification,
    businessName: businessName,
    businessNameEng: businessNameEng,
    stateRegNum: stateRegNum,
    stateRegDate: stateRegDate,
    regNumber: regNumber,
    isVatPayer: isVatPayer,
    web: web,
    email: email,
    email2: email2,
    phone: phone,
    phone2: phone2,
    fbLink: fbLink,
    logo: logo,
    provinceId: provinceId,
    districtId: districtId,
    khorooId: khorooId,
    khotkhonBair: khotkhonBair,
    khoroolol: khoroolol,
    khashaaDavkhar: khashaaDavkhar,
    khaalgaDugaar: khaalgaDugaar,
    businessAddress: businessAddress,
    locationLat: locationLat,
    locationLng: locationLng,
    isAnchor: isAnchor,
    isBuyer: isBuyer,
    isSupplier: isSupplier,
    isConfirmed: isConfirmed,
    province: province,
    name: name,
    district: district,
    khoroo: khoroo,
  );
}

Map<String, dynamic> _$PartnerToJson(Partner instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.legalEntityType != null)
    json['legalEntityType'] = instance.legalEntityType;
  if (instance.equityType != null) json['equityType'] = instance.equityType;
  if (instance.partnerCategory != null)
    json['partnerCategory'] = instance.partnerCategory;
  if (instance.ownerUserId != null) json['ownerUserId'] = instance.ownerUserId;
  if (instance.country != null) json['country'] = instance.country;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.registerStatus != null)
    json['registerStatus'] = instance.registerStatus;
  if (instance.contractStatus != null)
    json['contractStatus'] = instance.contractStatus;
  if (instance.partnerStatus != null)
    json['partnerStatus'] = instance.partnerStatus;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.classification != null)
    json['classification'] = instance.classification;
  if (instance.businessName != null)
    json['businessName'] = instance.businessName;
  if (instance.businessNameEng != null)
    json['businessNameEng'] = instance.businessNameEng;
  if (instance.stateRegNum != null) json['stateRegNum'] = instance.stateRegNum;
  if (instance.stateRegDate != null)
    json['stateRegDate'] = instance.stateRegDate;
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
  if (instance.khotkhonBair != null)
    json['khotkhonBair'] = instance.khotkhonBair;
  if (instance.khoroolol != null) json['khoroolol'] = instance.khoroolol;
  if (instance.khashaaDavkhar != null)
    json['khashaaDavkhar'] = instance.khashaaDavkhar;
  if (instance.khaalgaDugaar != null)
    json['khaalgaDugaar'] = instance.khaalgaDugaar;
  if (instance.businessAddress != null)
    json['businessAddress'] = instance.businessAddress;
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
