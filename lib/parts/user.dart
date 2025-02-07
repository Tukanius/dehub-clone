part of '../models/user.dart';

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    pin: json['pin'] != null ? json['pin'] as String : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'].toString())
        : null,
    user: json['user'] != null
        ? User.fromJson(json['user'] as Map<String, dynamic>)
        : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    sessionId: json['sessionId'] != null ? json['sessionId'] as String : null,
    partnerRef:
        json['partnerRef'] != null ? json['partnerRef'] as String : null,
    businessRef:
        json['businessRef'] != null ? json['businessRef'] as String : null,
    clientType:
        json['clientType'] != null ? json['clientType'] as String : null,
    financeRoleStatus: json['financeRoleStatus'] != null
        ? json['financeRoleStatus'] as String
        : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    module: json['module'] != null ? json['module'] as String : null,
    clientCode:
        json['clientCode'] != null ? json['clientCode'] as String : null,
    icon: json['icon'] != null ? json['icon'] as String : null,
    hasRole: json['hasRole'] != null ? json['hasRole'] as bool : null,
    email: json['email'] != null ? json['email'] as String : null,
    bank: json['bank'] != null ? json['bank'] as String : null,
    branchName:
        json['branchName'] != null ? json['branchName'] as String : null,
    username: json['username'] != null ? json['username'] as String : null,
    systemAction:
        json['systemAction'] != null ? json['systemAction'] as String : null,
    roleName: json['roleName'] != null ? json['roleName'] as String : null,
    link: json['link'] != null ? json['link'] as String : null,
    isAdmin: json['isAdmin'] != null ? json['isAdmin'] as bool : null,
    businessStaffs: json['businessStaffs'] != null
        ? (json['businessStaffs'] as List)
            .map((e) => BusinessStaffs.fromJson(e))
            .toList()
        : null,
    permissions: json['permissions'] != null
        ? (json['permissions'] as List).map((e) => User.fromJson(e)).toList()
        : null,
    roles: json['roles'] != null
        ? (json['roles'] as List).map((e) => User.fromJson(e)).toList()
        : null,
    roleIds: json['roleIds'] != null
        ? (json['roleIds'] as List).map((e) => e as String).toList()
        : null,
    urls: json['urls'] != null
        ? (json['urls'] as List).map((e) => e as String).toList()
        : null,
    socialLinks: json['socialLinks'] != null
        ? (json['socialLinks'] as List).map((e) => User.fromJson(e)).toList()
        : null,
    userRoles: json['userRoles'] != null
        ? (json['userRoles'] as List).map((e) => User.fromJson(e)).toList()
        : null,
    isEmailVerified: json['isEmailVerified'] != null
        ? json['isEmailVerified'] as bool
        : null,
    emailVerifiedDate: json['emailVerifiedDate'] != null
        ? json['emailVerifiedDate'] as String
        : null,
    oldPin: json['oldPin'] != null ? json['oldPin'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    isPhoneVerified: json['isPhoneVerified'] != null
        ? json['isPhoneVerified'] as bool
        : null,
    phoneVerifiedDate: json['phoneVerifiedDate'] != null
        ? json['phoneVerifiedDate'] as String
        : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    sessionScope:
        json['sessionScope'] != null ? json['sessionScope'] as String : null,
    expiryHours: json['expiryHours'] != null
        ? double.parse(json['expiryHours'].toString())
        : null,
    userSuspended:
        json['userSuspended'] != null ? json['userSuspended'] as bool : null,
    passwordExpired: json['passwordExpired'] != null
        ? json['passwordExpired'] as bool
        : null,
    passwordNeedChange: json['passwordNeedChange'] != null
        ? json['passwordNeedChange'] as bool
        : null,
    userTerminated:
        json['userTerminated'] != null ? json['userTerminated'] as bool : null,
    expiryDate:
        json['expiryDate'] != null ? json['expiryDate'] as String : null,
    userStatus:
        json['userStatus'] != null ? json['userStatus'] as String : null,
    registerStatus: json['registerStatus'] != null
        ? json['registerStatus'] as String
        : null,
    userStatusDate: json['userStatusDate'] != null
        ? json['userStatusDate'] as String
        : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    // partner: json['partner'] != null
    //     ? Partner.fromJson(json['partner'] as Map<String, dynamic>)
    //     : null,
    verifyExpiryDate: json['verifyExpiryDate'] != null
        ? json['verifyExpiryDate'] as String
        : null,
    hasPin: json['hasPin'] != null ? json['hasPin'] as bool : null,
    currentBusinessId: json['currentBusinessId'] != null
        ? json['currentBusinessId'] as String
        : null,
    loginType: json['loginType'] != null ? json['loginType'] as String : null,
    identityCardFront: json['identityCardFront'] != null
        ? json['identityCardFront'] as String
        : null,
    identityCardBack: json['identityCardBack'] != null
        ? json['identityCardBack'] as String
        : null,
    isSysUser: json['isSysUser'] != null ? json['isSysUser'] as bool : null,
    isAppUser: json['isAppUser'] != null ? json['isAppUser'] as bool : null,
    userId: json['userId'] != null ? json['userId'] as String : null,
    tokenType: json['tokenType'] != null ? json['tokenType'] as String : null,
    accessToken:
        json['accessToken'] != null ? json['accessToken'] as String : null,
    refreshToken:
        json['refreshToken'] != null ? json['refreshToken'] as String : null,
    sessionState:
        json['sessionState'] != null ? json['sessionState'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    password: json['password'] != null ? json['password'] as String : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    registerNo:
        json['registerNo'] != null ? json['registerNo'] as String : null,
    familyName:
        json['familyName'] != null ? json['familyName'] as String : null,
    roleId: json['roleId'] != null ? json['roleId'] as String : null,
    departmentUnitId: json['departmentUnitId'] != null
        ? json['departmentUnitId'] as String
        : null,
    departmentSubUnitId: json['departmentSubUnitId'] != null
        ? json['departmentSubUnitId'] as String
        : null,
    employeeUnitId: json['employeeUnitId'] != null
        ? json['employeeUnitId'] as String
        : null,
    url: json['url'] != null ? Uri.parse(json['url'].toString()) : null,
    roleEnableDate: json['roleEnableDate'] != null
        ? json['roleEnableDate'] as String
        : null,
    roleDisableDate: json['roleDisableDate'] != null
        ? json['roleDisableDate'] as String
        : null,
    phone2: json['phone2'] != null ? json['phone2'] as String : null,
    email2: json['email2'] != null ? json['email2'] as String : null,
    isDanVerified:
        json['isDanVerified'] != null ? json['isDanVerified'] as bool : null,
    hasPassword:
        json['hasPassword'] != null ? json['hasPassword'] as bool : null,
    currentBusiness: json['currentBusiness'] != null
        ? User.fromJson(json['currentBusiness'] as Map<String, dynamic>)
        : null,
    financeRole: json['financeRole'] != null
        ? User.fromJson(json['financeRole'] as Map<String, dynamic>)
        : null,
    business: json['business'] != null
        ? User.fromJson(json['business'] as Map<String, dynamic>)
        : null,
    role: json['role'] != null
        ? User.fromJson(json['role'] as Map<String, dynamic>)
        : null,
    partner: json['partner'] != null
        ? User.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    stateRegNum: json['stateRegNum'] != null
        ? double.parse(json['stateRegNum'].toString())
        : null,
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
    isConfirmed:
        json['isConfirmed'] != null ? json['isConfirmed'] as bool : null,
    isAnchorBusiness: json['isAnchorBusiness'] != null
        ? json['isAnchorBusiness'] as bool
        : null,

    verifyId: json['verifyId'] != null ? json['verifyId'] as String : null,
    otpCode: json['otpCode'] != null ? json['otpCode'] as String : null,
    message: json['message'] != null ? json['message'] as String : null,
    expiryIn: json['expiryIn'] != null
        ? int.parse(json['expiryIn'].toString())
        : null,
    level: json['level'] != null ? int.parse(json['level'].toString()) : null,
    otpCharset:
        json['otpCharset'] != null ? json['otpCharset'] as String : null,
    otpMethod: json['otpMethod'] != null ? json['otpMethod'] as String : null,
    oldPassword:
        json['oldPassword'] != null ? json['oldPassword'] as String : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    file: json['file'] != null ? json['file'] as File : null,
    danVerifiedDate: json['danVerifiedDate'] != null
        ? DateTime.parse(json['danVerifiedDate'].toString())
        : null,
    usageType: json['usageType'] != null ? json['usageType'] as String : null,
    departmentUnit: json['departmentUnit'] != null
        ? User.fromJson(json['departmentUnit'] as Map<String, dynamic>)
        : null,
    regUser: json['regUser'] != null
        ? User.fromJson(json['regUser'] as Map<String, dynamic>)
        : null,
    departmentSubUnit: json['departmentSubUnit'] != null
        ? User.fromJson(json['departmentSubUnit'] as Map<String, dynamic>)
        : null,
    branch: json['branch'] != null
        ? User.fromJson(json['branch'] as Map<String, dynamic>)
        : null,
    employeeUnit: json['employeeUnit'] != null
        ? User.fromJson(json['employeeUnit'] as Map<String, dynamic>)
        : null,
    branchId: json['branchId'] != null ? json['branchId'] as String : null,
    accessLevel:
        json['accessLevel'] != null ? json['accessLevel'] as String : null,
    startDate: json['startDate'] != null ? json['startDate'] as String : null,
    endDate: json['endDate'] != null ? json['endDate'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    roleStatus:
        json['roleStatus'] != null ? json['roleStatus'] as String : null,
    menu: json['menu'] != null ? json['menu'] as String : null,
    portal: json['portal'] != null ? json['portal'] as String : null,
    isView: json['isView'] != null ? json['isView'] as bool : null,
    isCreate: json['isCreate'] != null ? json['isCreate'] as bool : null,
    isEdit: json['isEdit'] != null ? json['isEdit'] as bool : null,
    isReview: json['isReview'] != null ? json['isReview'] as bool : null,
    isDelete: json['isDelete'] != null ? json['isDelete'] as bool : null,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  Map<String, dynamic> json = {};

  if (instance.menu != null) json['menu'] = instance.menu;
  if (instance.portal != null) json['portal'] = instance.portal;
  if (instance.isView != null) json['isView'] = instance.isView;
  if (instance.isCreate != null) json['isCreate'] = instance.isCreate;
  if (instance.isEdit != null) json['isEdit'] = instance.isEdit;
  if (instance.isReview != null) json['isReview'] = instance.isReview;
  if (instance.isDelete != null) json['isDelete'] = instance.isDelete;
  if (instance.danVerifiedDate != null) {
    json['danVerifiedDate'] = instance.danVerifiedDate;
  }
  if (instance.permissions != null) {
    json['permissions'] = instance.permissions;
  }
  if (instance.roleIds != null) json['roleIds'] = instance.roleIds;
  if (instance.roles != null) json['roles'] = instance.roles;
  if (instance.clientCode != null) {
    json['clientCode'] = instance.clientCode;
  }
  if (instance.usageType != null) json['usageType'] = instance.usageType;
  if (instance.bank != null) json['bank'] = instance.bank;
  if (instance.icon != null) json['icon'] = instance.icon;
  if (instance.systemAction != null) {
    json['systemAction'] = instance.systemAction;
  }
  if (instance.roleName != null) json['roleName'] = instance.roleName;
  if (instance.module != null) json['module'] = instance.module;
  if (instance.business != null) json['business'] = instance.business;
  if (instance.role != null) json['role'] = instance.role;
  if (instance.departmentUnit != null) {
    json['departmentUnit'] = instance.departmentUnit;
  }
  if (instance.departmentSubUnit != null) {
    json['departmentSubUnit'] = instance.departmentSubUnit;
  }
  if (instance.employeeUnit != null) {
    json['employeeUnit'] = instance.employeeUnit;
  }
  if (instance.branchId != null) json['branchId'] = instance.branchId;
  if (instance.link != null) json['link'] = instance.link;
  if (instance.accessLevel != null) json['accessLevel'] = instance.accessLevel;
  if (instance.startDate != null) json['startDate'] = instance.startDate;
  if (instance.endDate != null) json['endDate'] = instance.endDate;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.roleStatus != null) json['roleStatus'] = instance.roleStatus;

  if (instance.businessName != null) {
    json["businessName"] = instance.businessName;
  }
  if (instance.socialLinks != null) json["socialLinks"] = instance.socialLinks;
  if (instance.regUser != null) json["regUser"] = instance.regUser;
  if (instance.isAdmin != null) json["isAdmin"] = instance.isAdmin;
  if (instance.userRoles != null) json["userRoles"] = instance.userRoles;
  if (instance.hasRole != null) json["hasRole"] = instance.hasRole;
  if (instance.urls != null) json["urls"] = instance.urls;
  if (instance.businessRef != null) json["businessRef"] = instance.businessRef;
  if (instance.clientType != null) json["clientType"] = instance.clientType;
  if (instance.partnerRef != null) json["partnerRef"] = instance.partnerRef;
  if (instance.file != null) json["file"] = instance.file;
  if (instance.oldPin != null) json["oldPin"] = instance.oldPin;
  if (instance.url != null) json["url"] = instance.url;
  if (instance.verifyId != null) json["verifyId"] = instance.verifyId;
  if (instance.otpCode != null) json["otpCode"] = instance.otpCode;
  if (instance.message != null) json["message"] = instance.message;
  if (instance.expiryIn != null) json["expiryIn"] = instance.expiryIn;
  if (instance.otpCharset != null) json["otpCharset"] = instance.otpCharset;
  if (instance.otpMethod != null) json["otpMethod"] = instance.otpMethod;
  if (instance.oldPassword != null) json["oldPassword"] = instance.oldPassword;
  if (instance.roleDisableDate != null) {
    json["roleDisableDate"] = instance.roleDisableDate;
  }
  if (instance.emailVerifiedDate != null) {
    json["emailVerifiedDate"] = instance.emailVerifiedDate;
  }
  if (instance.code != null) json['code'] = instance.code;
  if (instance.branch != null) json['branch'] = instance.branch;
  if (instance.password != null) json['password'] = instance.password;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;
  if (instance.familyName != null) json['familyName'] = instance.familyName;
  if (instance.roleId != null) json['roleId'] = instance.roleId;
  if (instance.departmentUnitId != null) {
    json['departmentUnitId'] = instance.departmentUnitId;
  }
  if (instance.financeRoleStatus != null) {
    json['financeRoleStatus'] = instance.financeRoleStatus;
  }
  if (instance.departmentSubUnitId != null) {
    json['departmentSubUnitId'] = instance.departmentSubUnitId;
  }
  if (instance.employeeUnitId != null) {
    json['employeeUnitId'] = instance.employeeUnitId;
  }
  if (instance.roleEnableDate != null) {
    json['roleEnableDate'] = instance.roleEnableDate;
  }
  if (instance.phone2 != null) json['phone2'] = instance.phone2;
  if (instance.level != null) json['level'] = instance.level;
  if (instance.email2 != null) json['email2'] = instance.email2;
  if (instance.isDanVerified != null) {
    json['isDanVerified'] = instance.isDanVerified;
  }
  if (instance.hasPassword != null) json['hasPassword'] = instance.hasPassword;
  if (instance.currentBusiness != null) {
    json['currentBusiness'] = instance.currentBusiness;
  }
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.stateRegNum != null) json['stateRegNum'] = instance.stateRegNum;
  if (instance.legalEntityType != null) {
    json['legalEntityType'] = instance.legalEntityType;
  }
  if (instance.partnerName != null) json['partnerName'] = instance.partnerName;
  if (instance.partnerNameEng != null) {
    json['partnerNameEng'] = instance.partnerNameEng;
  }
  if (instance.financeRole != null) {
    json['financeRole'] = instance.financeRole;
  }
  if (instance.refCode != null) json['refCode'] = instance.refCode;
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
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.businessStaffs != null) {
    json['businessStaffs'] = instance.businessStaffs;
  }
  if (instance.isVatPayer != null) json['isVatPayer'] = instance.isVatPayer;
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
  if (instance.profileNameEng != null) {
    json['profileNameEng'] = instance.profileNameEng;
  }
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.profileInfo != null) json['profileInfo'] = instance.profileInfo;
  if (instance.isConfirmed != null) json['isConfirmed'] = instance.isConfirmed;
  if (instance.isAnchorBusiness != null) {
    json['isAnchorBusiness'] = instance.isAnchorBusiness;
  }
  if (instance.id != null) json['id'] = instance.id;
  if (instance.branchName != null) json['branchName'] = instance.branchName;
  if (instance.pin != null) json['pin'] = instance.pin;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.sessionId != null) json['sessionId'] = instance.sessionId;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.username != null) json['username'] = instance.username;
  if (instance.isEmailVerified != null) {
    json['isEmailVerified'] = instance.isEmailVerified;
  }
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.isPhoneVerified != null) {
    json['isPhoneVerified'] = instance.isPhoneVerified;
  }
  if (instance.phoneVerifiedDate != null) {
    json['phoneVerifiedDate'] = instance.phoneVerifiedDate;
  }
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.sessionScope != null) {
    json['sessionScope'] = instance.sessionScope;
  }
  if (instance.expiryHours != null) json['expiryHours'] = instance.expiryHours;
  if (instance.userSuspended != null) {
    json['userSuspended'] = instance.userSuspended;
  }
  if (instance.passwordExpired != null) {
    json['passwordExpired'] = instance.passwordExpired;
  }
  if (instance.passwordNeedChange != null) {
    json['passwordNeedChange'] = instance.passwordNeedChange;
  }
  if (instance.userTerminated != null) {
    json['userTerminated'] = instance.userTerminated;
  }
  if (instance.expiryDate != null) json['expiryDate'] = instance.expiryDate;
  if (instance.userStatus != null) json['userStatus'] = instance.userStatus;
  if (instance.registerStatus != null) {
    json['registerStatus'] = instance.registerStatus;
  }
  if (instance.userStatusDate != null) {
    json['userStatusDate'] = instance.userStatusDate;
  }
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.verifyExpiryDate != null) {
    json['verifyExpiryDate'] = instance.verifyExpiryDate;
  }
  if (instance.hasPin != null) json['hasPin'] = instance.hasPin;
  if (instance.currentBusinessId != null) {
    json['currentBusinessId'] = instance.currentBusinessId;
  }
  if (instance.loginType != null) json['loginType'] = instance.loginType;
  if (instance.identityCardFront != null) {
    json['identityCardFront'] = instance.identityCardFront;
  }
  if (instance.identityCardBack != null) {
    json['identityCardBack'] = instance.identityCardBack;
  }
  if (instance.isSysUser != null) json['isSysUser'] = instance.isSysUser;
  if (instance.isAppUser != null) json['isAppUser'] = instance.isAppUser;
  // if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.userId != null) json['userId'] = instance.userId;
  if (instance.tokenType != null) json['tokenType'] = instance.tokenType;
  if (instance.accessToken != null) json['accessToken'] = instance.accessToken;
  if (instance.refreshToken != null) {
    json['refreshToken'] = instance.refreshToken;
  }
  if (instance.sessionState != null) {
    json['sessionState'] = instance.sessionState;
  }
  if (instance.user != null) json['user'] = instance.user;

  return json;
}
