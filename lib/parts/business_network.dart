part of '../models/business_network.dart';

BusinessNetwork _$BusinessNetworkFromJson(Map<String, dynamic> json) {
  return BusinessNetwork(
    count: json['count'] != null ? int.parse(json['count'].toString()) : null,
    rows: json['rows'] != null
        ? (json['rows'] as List)
            .map((e) => BusinessNetwork.fromJson(e))
            .toList()
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    stateRegNum:
        json['stateRegNum'] != null ? json['stateRegNum'] as String : null,
    legalEntityType: json['legalEntityType'] != null
        ? json['legalEntityType'] as String
        : null,
    partnerName:
        json['partnerName'] != null ? json['partnerName'] as String : null,
    partnerNameEng: json['partnerNameEng'] != null
        ? json['partnerNameEng'] as String
        : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    businessSectorId: json['businessSectorId'] != null
        ? json['businessSectorId'] as String
        : null,
    businessSubSectorId: json['businessSubSectorId'] != null
        ? json['businessSubSectorId'] as String
        : null,
    type: json['type'] != null ? json['type'] as String : null,
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
    isVatPayer: json['isVatPayer'] != null ? json['isVatPayer'] as bool : null,
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
    logo: json['logo'] != null ? json['logo'] as String : null,
    profileInfo:
        json['profileInfo'] != null ? json['profileInfo'] as String : null,
    isAnchorBusiness: json['isAnchorBusiness'] != null
        ? json['isAnchorBusiness'] as bool
        : null,
    partner: json['partner'] != null
        ? BusinessNetwork.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    businessSector: json['businessSector'] != null
        ? BusinessNetwork.fromJson(
            json['businessSector'] as Map<String, dynamic>)
        : null,
    businessSubSector: json['businessSubSector'] != null
        ? BusinessNetwork.fromJson(
            json['businessSubSector'] as Map<String, dynamic>)
        : null,
    name: json['name'] != null ? json['name'] as String : null,
    inAcc: json['inAcc'] != null
        ? BusinessNetwork.fromJson(json['inAcc'] as Map<String, dynamic>)
        : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    bankName: json['bankName'] != null ? json['bankName'] as String : null,
    number: json['number'] != null ? json['number'] as String : null,
    shortName: json['shortName'] != null ? json['shortName'] as String : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    isVerified: json['isVerified'] != null ? json['isVerified'] as bool : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    balance: json['balance'] != null
        ? double.parse(json['balance'].toString())
        : null,
    outAcc: json['outAcc'] != null
        ? BusinessNetwork.fromJson(json['outAcc'] as Map<String, dynamic>)
        : null,
    paymentTerm: json['paymentTerm'] != null
        ? BusinessNetwork.fromJson(json['paymentTerm'] as Map<String, dynamic>)
        : null,
    modifiedUserId: json['modifiedUserId'] != null
        ? json['modifiedUserId'] as String
        : null,
    termRule: json['termRule'] != null ? json['termRule'] as String : null,
    orderConfirmTerm: json['orderConfirmTerm'] != null
        ? json['orderConfirmTerm'] as String
        : null,
    expireDayCount: json['expireDayCount'] != null
        ? int.parse(json['expireDayCount'].toString())
        : null,
    month: json['month'] != null ? int.parse(json['month'].toString()) : null,
    paymentDay:
        json['paymentDay'] != null ? json['paymentDay'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    isMain: json['isMain'] != null ? json['isMain'] as bool : null,
    isOpen: json['isOpen'] != null ? json['isOpen'] as bool : null,
    coBusinessCategory: json['coBusinessCategory'] != null
        ? BusinessNetwork.fromJson(
            json['coBusinessCategory'] as Map<String, dynamic>)
        : null,
    isParent: json['isParent'] != null ? json['isParent'] as bool : null,
    coBusinessPriority: json['coBusinessPriority'] != null
        ? BusinessNetwork.fromJson(
            json['coBusinessPriority'] as Map<String, dynamic>)
        : null,
    coBusinessClassDesc: json['coBusinessClassDesc'] != null
        ? json['coBusinessClassDesc'] as String
        : null,
    coBusinessClassSetUser: json['coBusinessClassSetUser'] != null
        ? BusinessNetwork.fromJson(
            json['coBusinessClassSetUser'] as Map<String, dynamic>)
        : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    coBusinessRegion: json['coBusinessRegion'] != null
        ? BusinessNetwork.fromJson(
            json['coBusinessRegion'] as Map<String, dynamic>)
        : null,
    coBusinessClassSetDate: json['coBusinessClassSetDate'] != null
        ? json['coBusinessClassSetDate'] as String
        : null,
    coBusinessDirection: json['coBusinessDirection'] != null
        ? BusinessNetwork.fromJson(
            json['coBusinessDirection'] as Map<String, dynamic>)
        : null,
    coBusinessAreaDesc: json['coBusinessAreaDesc'] != null
        ? json['coBusinessAreaDesc'] as String
        : null,
    coBusinessAreaSetUser: json['coBusinessAreaSetUser'] != null
        ? BusinessNetwork.fromJson(
            json['coBusinessAreaSetUser'] as Map<String, dynamic>)
        : null,
    coBusinessAreaSetDate: json['coBusinessAreaSetDate'] != null
        ? json['coBusinessAreaSetDate'] as String
        : null,
    coBusinessStaff: json['coBusinessStaff'] != null
        ? BusinessNetwork.fromJson(
            json['coBusinessStaff'] as Map<String, dynamic>)
        : null,
    coBusinessStaff2: json['coBusinessStaff2'] != null
        ? BusinessNetwork.fromJson(
            json['coBusinessStaff2'] as Map<String, dynamic>)
        : null,
    coBusinessStaffDesc: json['coBusinessStaffDesc'] != null
        ? json['coBusinessStaffDesc'] as String
        : null,
    coBusinessStaffSetUser: json['coBusinessStaffSetUser'] != null
        ? BusinessNetwork.fromJson(
            json['coBusinessStaffSetUser'] as Map<String, dynamic>)
        : null,
    coBusinessStaffSetDate: json['coBusinessStaffSetDate'] != null
        ? json['coBusinessStaffSetDate'] as String
        : null,
    staff: json['staff'] != null
        ? BusinessNetwork.fromJson(json['staff'] as Map<String, dynamic>)
        : null,
    branch: json['branch'] != null
        ? BusinessNetwork.fromJson(json['branch'] as Map<String, dynamic>)
        : null,
    financeStaff: json['financeStaff'] != null
        ? BusinessNetwork.fromJson(json['financeStaff'] as Map<String, dynamic>)
        : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    staffs: json['staffs'] != null
        ? (json['staffs'] as List)
            .map((e) => BusinessNetwork.fromJson(e))
            .toList()
        : null,
    businessInAcc: json['businessInAcc'] != null
        ? BusinessNetwork.fromJson(
            json['businessInAcc'] as Map<String, dynamic>)
        : null,
    businessOutAcc: json['businessOutAcc'] != null
        ? BusinessNetwork.fromJson(
            json['businessOutAcc'] as Map<String, dynamic>)
        : null,
    branches: json['branches'] != null
        ? (json['branches'] as List)
            .map((e) => BusinessNetwork.fromJson(e))
            .toList()
        : null,
    nameEng: json['nameEng'] != null ? json['nameEng'] as String : null,
    branchStatus:
        json['branchStatus'] != null ? json['branchStatus'] as String : null,
    isSupplier: json['isSupplier'] != null ? json['isSupplier'] as bool : null,
    isBuyer: json['isBuyer'] != null ? json['isBuyer'] as bool : null,
    provinceId:
        json['provinceId'] != null ? json['provinceId'] as String : null,
    districtId:
        json['districtId'] != null ? json['districtId'] as String : null,
    khorooId: json['khorooId'] != null ? json['khorooId'] as String : null,
    khoroolol: json['khoroolol'] != null ? json['khoroolol'] as String : null,
    khotkhonBair:
        json['khotkhonBair'] != null ? json['khotkhonBair'] as String : null,
    khashaaDavkhar: json['khashaaDavkhar'] != null
        ? json['khashaaDavkhar'] as String
        : null,
    khaalgaDugaar:
        json['khaalgaDugaar'] != null ? json['khaalgaDugaar'] as String : null,
    branchAddress:
        json['branchAddress'] != null ? json['branchAddress'] as String : null,
    locationLat: json['locationLat'] != null
        ? double.parse(json['locationLat'].toString())
        : null,
    locationLng: json['locationLng'] != null
        ? double.parse(json['locationLng'].toString())
        : null,
  );
}

Map<String, dynamic> _$BusinessNetworkToJson(BusinessNetwork instance) {
  Map<String, dynamic> json = {};

  if (instance.financeStaff != null)
    json['financeStaff'] = instance.financeStaff;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.staffs != null) json['staffs'] = instance.staffs;
  if (instance.businessInAcc != null)
    json['businessInAcc'] = instance.businessInAcc;
  if (instance.businessOutAcc != null)
    json['businessOutAcc'] = instance.businessOutAcc;
  if (instance.branches != null) json['branches'] = instance.branches;
  if (instance.nameEng != null) json['nameEng'] = instance.nameEng;
  if (instance.branchStatus != null)
    json['branchStatus'] = instance.branchStatus;
  if (instance.isSupplier != null) json['isSupplier'] = instance.isSupplier;
  if (instance.isBuyer != null) json['isBuyer'] = instance.isBuyer;
  if (instance.provinceId != null) json['provinceId'] = instance.provinceId;
  if (instance.districtId != null) json['districtId'] = instance.districtId;
  if (instance.khorooId != null) json['khorooId'] = instance.khorooId;
  if (instance.khoroolol != null) json['khoroolol'] = instance.khoroolol;
  if (instance.khotkhonBair != null)
    json['khotkhonBair'] = instance.khotkhonBair;
  if (instance.khashaaDavkhar != null)
    json['khashaaDavkhar'] = instance.khashaaDavkhar;
  if (instance.khaalgaDugaar != null)
    json['khaalgaDugaar'] = instance.khaalgaDugaar;
  if (instance.branchAddress != null)
    json['branchAddress'] = instance.branchAddress;
  if (instance.locationLat != null) json['locationLat'] = instance.locationLat;
  if (instance.locationLng != null) json['locationLng'] = instance.locationLng;
  if (instance.businessName != null)
    json['businessName'] = instance.businessName;
  if (instance.count != null) json['count'] = instance.count;
  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.stateRegNum != null) json['stateRegNum'] = instance.stateRegNum;
  if (instance.legalEntityType != null)
    json['legalEntityType'] = instance.legalEntityType;
  if (instance.partnerName != null) json['partnerName'] = instance.partnerName;
  if (instance.partnerNameEng != null)
    json['partnerNameEng'] = instance.partnerNameEng;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.businessSectorId != null)
    json['businessSectorId'] = instance.businessSectorId;
  if (instance.businessSubSectorId != null)
    json['businessSubSectorId'] = instance.businessSubSectorId;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.purchaseType != null)
    json['purchaseType'] = instance.purchaseType;
  if (instance.productCategoryType != null)
    json['productCategoryType'] = instance.productCategoryType;
  if (instance.serviceCategoryType != null)
    json['serviceCategoryType'] = instance.serviceCategoryType;
  if (instance.businessStatus != null)
    json['businessStatus'] = instance.businessStatus;
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.isVatPayer != null) json['isVatPayer'] = instance.isVatPayer;
  if (instance.partnerEmail != null)
    json['partnerEmail'] = instance.partnerEmail;
  if (instance.partnerEmail2 != null)
    json['partnerEmail2'] = instance.partnerEmail2;
  if (instance.partnerPhone != null)
    json['partnerPhone'] = instance.partnerPhone;
  if (instance.partnerPhone2 != null)
    json['partnerPhone2'] = instance.partnerPhone2;
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.profileNameEng != null)
    json['profileNameEng'] = instance.profileNameEng;
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.profileInfo != null) json['profileInfo'] = instance.profileInfo;
  if (instance.isAnchorBusiness != null)
    json['isAnchorBusiness'] = instance.isAnchorBusiness;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.businessSector != null)
    json['businessSector'] = instance.businessSector;
  if (instance.businessSubSector != null)
    json['businessSubSector'] = instance.businessSubSector;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.inAcc != null) json['inAcc'] = instance.inAcc;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.bankName != null) json['bankName'] = instance.bankName;
  if (instance.number != null) json['number'] = instance.number;
  if (instance.shortName != null) json['shortName'] = instance.shortName;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.isVerified != null) json['isVerified'] = instance.isVerified;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.balance != null) json['balance'] = instance.balance;
  if (instance.outAcc != null) json['outAcc'] = instance.outAcc;
  if (instance.paymentTerm != null) json['paymentTerm'] = instance.paymentTerm;
  if (instance.modifiedUserId != null)
    json['modifiedUserId'] = instance.modifiedUserId;
  if (instance.termRule != null) json['termRule'] = instance.termRule;
  if (instance.orderConfirmTerm != null)
    json['orderConfirmTerm'] = instance.orderConfirmTerm;
  if (instance.expireDayCount != null)
    json['expireDayCount'] = instance.expireDayCount;
  if (instance.month != null) json['month'] = instance.month;
  if (instance.paymentDay != null) json['paymentDay'] = instance.paymentDay;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.isMain != null) json['isMain'] = instance.isMain;
  if (instance.isOpen != null) json['isOpen'] = instance.isOpen;
  if (instance.coBusinessCategory != null)
    json['coBusinessCategory'] = instance.coBusinessCategory;
  if (instance.isParent != null) json['isParent'] = instance.isParent;
  if (instance.coBusinessPriority != null)
    json['coBusinessPriority'] = instance.coBusinessPriority;
  if (instance.coBusinessClassDesc != null)
    json['coBusinessClassDesc'] = instance.coBusinessClassDesc;
  if (instance.coBusinessClassSetUser != null)
    json['coBusinessClassSetUser'] = instance.coBusinessClassSetUser;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.coBusinessRegion != null)
    json['coBusinessRegion'] = instance.coBusinessRegion;
  if (instance.coBusinessClassSetDate != null)
    json['coBusinessClassSetDate'] = instance.coBusinessClassSetDate;
  if (instance.coBusinessDirection != null)
    json['coBusinessDirection'] = instance.coBusinessDirection;
  if (instance.coBusinessAreaDesc != null)
    json['coBusinessAreaDesc'] = instance.coBusinessAreaDesc;
  if (instance.coBusinessAreaSetUser != null)
    json['coBusinessAreaSetUser'] = instance.coBusinessAreaSetUser;
  if (instance.coBusinessAreaSetDate != null)
    json['coBusinessAreaSetDate'] = instance.coBusinessAreaSetDate;
  if (instance.coBusinessStaff != null)
    json['coBusinessStaff'] = instance.coBusinessStaff;
  if (instance.coBusinessStaff2 != null)
    json['coBusinessStaff2'] = instance.coBusinessStaff2;
  if (instance.coBusinessStaffDesc != null)
    json['coBusinessStaffDesc'] = instance.coBusinessStaffDesc;
  if (instance.coBusinessStaffSetUser != null)
    json['coBusinessStaffSetUser'] = instance.coBusinessStaffSetUser;
  if (instance.coBusinessStaffSetDate != null)
    json['coBusinessStaffSetDate'] = instance.coBusinessStaffSetDate;
  if (instance.staff != null) json['staff'] = instance.staff;
  if (instance.branch != null) json['branch'] = instance.branch;

  return json;
}
