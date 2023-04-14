part of '../models/user.dart';

User _$UserFromJson(Map<String, dynamic> json) {
  String? id;
  User? user;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? type;
  String? sessionId;
  bool? isActive;
  String? email;
  String? username;
  bool? isEmailVerified;
  String? emailVerifiedDate;
  String? phone;
  bool? isPhoneVerified;
  String? phoneVerifiedDate;
  String? lastName;
  String? firstName;
  String? avatar;
  String? sessionScope;
  double? expiryHours;
  bool? userSuspended;
  bool? passwordExpired;
  bool? passwordNeedChange;
  bool? userTerminated;
  String? expiryDate;
  String? userStatus;
  String? registerStatus;
  String? userStatusDate;
  String? partnerId;
  String? verifyExpiryDate;
  bool? hasPin;
  String? currentBusinessId;
  String? loginType;
  String? identityCardFront;
  String? identityCardBack;
  bool? isSysUser;
  bool? isAppUser;
  String? userId;
  String? tokenType;
  String? accessToken;
  String? refreshToken;
  String? sessionState;

  String? code;
  String? password;
  String? regUserId;
  String? businessId;
  String? registerNo;
  String? familyName;
  String? roleId;
  String? departmentUnitId;
  String? departmentSubUnitId;
  String? employeeUnitId;
  String? roleEnableDate;
  String? roleDisableDate;
  String? phone2;
  String? email2;
  bool? isDanVerified;
  bool? hasPassword;
  String? employeeUnit;
  User? currentBusiness;
  double? regNumber;
  double? stateRegNum;
  String? legalEntityType;
  String? partnerName;
  String? partnerNameEng;
  String? refCode;
  String? businessSectorId;
  String? businessSubSectorId;
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
  bool? isConfirmed;
  bool? isAnchorBusiness;
  Partner? partner;
  List<BusinessStaffs>? businessStaffs;

  if (json['code'] != null) code = json['code'];
  if (json['phone'] != null) phone = json['phone'];
  if (json['partner'] != null) {
    partner = Partner.fromJson(json['partner'] as Map<String, dynamic>);
  }
  if (json['businessStaffs'] != null) {
    businessStaffs = (json['businessStaffs'] as List)
        .map((e) => BusinessStaffs.fromJson(e))
        .toList();
  }
  if (json['user'] != null) {
    user = User.fromJson(json['user'] as Map<String, dynamic>);
  }
  if (json['password'] != null) password = json['password'];
  if (json['regUserId'] != null) regUserId = json['regUserId'];
  if (json['businessId'] != null) businessId = json['businessId'];
  if (json['registerNo'] != null) registerNo = json['registerNo'];
  if (json['familyName'] != null) familyName = json['familyName'];
  if (json['roleId'] != null) roleId = json['roleId'];
  if (json['departmentUnitId'] != null)
    departmentUnitId = json['departmentUnitId'];
  if (json['departmentSubUnitId'] != null)
    departmentSubUnitId = json['departmentSubUnitId'];
  if (json['employeeUnitId'] != null) employeeUnitId = json['employeeUnitId'];
  if (json['roleEnableDate'] != null) roleEnableDate = json['roleEnableDate'];
  if (json['roleDisableDate'] != null)
    roleDisableDate = json['roleDisableDate'];
  if (json['phone2'] != null) phone2 = json['phone2'];
  if (json['email2'] != null) email2 = json['email2'];
  if (json['isDanVerified'] != null) isDanVerified = json['isDanVerified'];
  if (json['hasPassword'] != null) hasPassword = json['hasPassword'];
  if (json['employeeUnit'] != null) employeeUnit = json['employeeUnit'];
  if (json['currentBusiness'] != null) {
    currentBusiness =
        User.fromJson(json['currentBusiness'] as Map<String, dynamic>);
  }

  if (json['regNumber'] != null)
    regNumber = double.parse(json['regNumber'].toString());
  if (json['stateRegNum'] != null)
    stateRegNum = double.parse(json['stateRegNum'].toString());
  if (json['legalEntityType'] != null)
    legalEntityType = json['legalEntityType'];
  if (json['partnerName'] != null) partnerName = json['partnerName'];
  if (json['partnerNameEng'] != null) partnerNameEng = json['partnerNameEng'];
  if (json['refCode'] != null) refCode = json['refCode'];
  if (json['businessSectorId'] != null)
    businessSectorId = json['businessSectorId'];
  if (json['businessSubSectorId'] != null)
    businessSubSectorId = json['businessSubSectorId'];
  if (json['purchaseType'] != null) purchaseType = json['purchaseType'];
  if (json['productCategoryType'] != null)
    productCategoryType = json['productCategoryType'];
  if (json['serviceCategoryType'] != null)
    serviceCategoryType = json['serviceCategoryType'];
  if (json['businessStatus'] != null) businessStatus = json['businessStatus'];
  if (json['isDefault'] != null) isDefault = json['isDefault'];
  if (json['isVatPayer'] != null) isVatPayer = json['isVatPayer'];
  if (json['partnerEmail'] != null) partnerEmail = json['partnerEmail'];
  if (json['partnerEmail2'] != null) partnerEmail2 = json['partnerEmail2'];
  if (json['partnerPhone'] != null) partnerPhone = json['partnerPhone'];
  if (json['partnerPhone2'] != null) partnerPhone2 = json['partnerPhone2'];
  if (json['profileName'] != null) profileName = json['profileName'];
  if (json['profileNameEng'] != null) profileNameEng = json['profileNameEng'];
  if (json['logo'] != null) logo = json['logo'];
  if (json['profileInfo'] != null) profileInfo = json['profileInfo'];
  if (json['isConfirmed'] != null) isConfirmed = json['isConfirmed'];
  if (json['isAnchorBusiness'] != null)
    isAnchorBusiness = json['isAnchorBusiness'];
  if (json['id'] != null) id = json['id'];
  if (json['emailVerifiedDate'] != null)
    emailVerifiedDate = json['emailVerifiedDate'];
  if (json['isPhoneVerified'] != null)
    isPhoneVerified = json['isPhoneVerified'];

  if (json['createdAt'] != null) createdAt = json['createdAt'];
  if (json['updatedAt'] != null) updatedAt = json['updatedAt'];
  if (json['deletedAt'] != null) deletedAt = json['deletedAt'];
  if (json['type'] != null) type = json['type'];
  if (json['sessionId'] != null) sessionId = json['sessionId'];
  if (json['isActive'] != null) isActive = json['isActive'];
  if (json['email'] != null) email = json['email'];
  if (json['username'] != null) username = json['username'];
  if (json['isEmailVerified'] != null)
    isEmailVerified = json['isEmailVerified'];
  if (json['phoneVerifiedDate'] != null)
    phoneVerifiedDate = json['phoneVerifiedDate'];
  if (json['lastName'] != null) lastName = json['lastName'];
  if (json['firstName'] != null) firstName = json['firstName'];
  if (json['avatar'] != null) avatar = json['avatar'];
  if (json['sessionScope'] != null) sessionScope = json['sessionScope'];
  if (json['expiryHours'] != null)
    expiryHours = double.parse(json['expiryHours'].toString());
  if (json['userSuspended'] != null) userSuspended = json['userSuspended'];
  if (json['passwordExpired'] != null)
    passwordExpired = json['passwordExpired'];
  if (json['passwordNeedChange'] != null)
    passwordNeedChange = json['passwordNeedChange'];
  if (json['userTerminated'] != null) userTerminated = json['userTerminated'];
  if (json['expiryDate'] != null) expiryDate = json['expiryDate'];
  if (json['userStatus'] != null) userStatus = json['userStatus'];
  if (json['registerStatus'] != null) registerStatus = json['registerStatus'];
  if (json['userStatusDate'] != null) userStatusDate = json['userStatusDate'];
  if (json['partnerId'] != null) partnerId = json['partnerId'];
  if (json['verifyExpiryDate'] != null)
    verifyExpiryDate = json['verifyExpiryDate'];
  if (json['hasPin'] != null) hasPin = json['hasPin'];
  if (json['currentBusinessId'] != null)
    currentBusinessId = json['currentBusinessId'];
  if (json['loginType'] != null) loginType = json['loginType'];
  if (json['identityCardFront'] != null)
    identityCardFront = json['identityCardFront'];
  if (json['identityCardBack'] != null)
    identityCardBack = json['identityCardBack'];
  if (json['isSysUser'] != null) isSysUser = json['isSysUser'];
  if (json['isAppUser'] != null) isAppUser = json['isAppUser'];
  if (json['userId'] != null) userId = json['userId'];
  if (json['tokenType'] != null) tokenType = json['tokenType'];
  if (json['accessToken'] != null) accessToken = json['accessToken'];
  if (json['refreshToken'] != null) refreshToken = json['refreshToken'];
  if (json['sessionState'] != null) sessionState = json['sessionState'];

  return User(
    id: id,
    createdAt: createdAt,
    user: user,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    type: type,
    sessionId: sessionId,
    isActive: isActive,
    email: email,
    username: username,
    businessStaffs: businessStaffs,
    isEmailVerified: isEmailVerified,
    emailVerifiedDate: emailVerifiedDate,
    phone: phone,
    isPhoneVerified: isPhoneVerified,
    phoneVerifiedDate: phoneVerifiedDate,
    lastName: lastName,
    firstName: firstName,
    avatar: avatar,
    sessionScope: sessionScope,
    expiryHours: expiryHours,
    userSuspended: userSuspended,
    passwordExpired: passwordExpired,
    passwordNeedChange: passwordNeedChange,
    userTerminated: userTerminated,
    expiryDate: expiryDate,
    userStatus: userStatus,
    registerStatus: registerStatus,
    userStatusDate: userStatusDate,
    partnerId: partnerId,
    partner: partner,
    verifyExpiryDate: verifyExpiryDate,
    hasPin: hasPin,
    currentBusinessId: currentBusinessId,
    loginType: loginType,
    identityCardFront: identityCardFront,
    identityCardBack: identityCardBack,
    isSysUser: isSysUser,
    isAppUser: isAppUser,
    userId: userId,
    tokenType: tokenType,
    accessToken: accessToken,
    refreshToken: refreshToken,
    sessionState: sessionState,
    code: code,
    password: password,
    regUserId: regUserId,
    businessId: businessId,
    registerNo: registerNo,
    familyName: familyName,
    roleId: roleId,
    departmentUnitId: departmentUnitId,
    departmentSubUnitId: departmentSubUnitId,
    employeeUnitId: employeeUnitId,
    roleEnableDate: roleEnableDate,
    roleDisableDate: roleDisableDate,
    phone2: phone2,
    email2: email2,
    isDanVerified: isDanVerified,
    hasPassword: hasPassword,
    employeeUnit: employeeUnit,
    currentBusiness: currentBusiness,
    regNumber: regNumber,
    stateRegNum: stateRegNum,
    legalEntityType: legalEntityType,
    partnerName: partnerName,
    partnerNameEng: partnerNameEng,
    refCode: refCode,
    businessSectorId: businessSectorId,
    businessSubSectorId: businessSubSectorId,
    purchaseType: purchaseType,
    productCategoryType: productCategoryType,
    serviceCategoryType: serviceCategoryType,
    businessStatus: businessStatus,
    isDefault: isDefault,
    isVatPayer: isVatPayer,
    partnerEmail: partnerEmail,
    partnerEmail2: partnerEmail2,
    partnerPhone: partnerPhone,
    partnerPhone2: partnerPhone2,
    profileName: profileName,
    profileNameEng: profileNameEng,
    logo: logo,
    profileInfo: profileInfo,
    isConfirmed: isConfirmed,
    isAnchorBusiness: isAnchorBusiness,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  Map<String, dynamic> json = {};

  if (instance.roleDisableDate != null)
    json["roleDisableDate"] = instance.roleDisableDate;
  if (instance.emailVerifiedDate != null)
    json["emailVerifiedDate"] = instance.emailVerifiedDate;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.password != null) json['password'] = instance.password;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;
  if (instance.familyName != null) json['familyName'] = instance.familyName;
  if (instance.roleId != null) json['roleId'] = instance.roleId;
  if (instance.departmentUnitId != null)
    json['departmentUnitId'] = instance.departmentUnitId;
  if (instance.departmentSubUnitId != null)
    json['departmentSubUnitId'] = instance.departmentSubUnitId;
  if (instance.employeeUnitId != null)
    json['employeeUnitId'] = instance.employeeUnitId;
  if (instance.roleEnableDate != null)
    json['roleEnableDate'] = instance.roleEnableDate;
  if (instance.phone2 != null) json['phone2'] = instance.phone2;
  if (instance.email2 != null) json['email2'] = instance.email2;
  if (instance.isDanVerified != null)
    json['isDanVerified'] = instance.isDanVerified;
  if (instance.hasPassword != null) json['hasPassword'] = instance.hasPassword;
  if (instance.employeeUnit != null)
    json['employeeUnit'] = instance.employeeUnit;
  if (instance.currentBusiness != null)
    json['currentBusiness'] = instance.currentBusiness;
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
  if (instance.purchaseType != null)
    json['purchaseType'] = instance.purchaseType;
  if (instance.productCategoryType != null)
    json['productCategoryType'] = instance.productCategoryType;
  if (instance.serviceCategoryType != null)
    json['serviceCategoryType'] = instance.serviceCategoryType;
  if (instance.businessStatus != null)
    json['businessStatus'] = instance.businessStatus;
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.businessStaffs != null)
    json['businessStaffs'] = instance.businessStaffs;
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
  if (instance.isConfirmed != null) json['isConfirmed'] = instance.isConfirmed;
  if (instance.isAnchorBusiness != null)
    json['isAnchorBusiness'] = instance.isAnchorBusiness;

  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.sessionId != null) json['sessionId'] = instance.sessionId;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.username != null) json['username'] = instance.username;
  if (instance.isEmailVerified != null)
    json['isEmailVerified'] = instance.isEmailVerified;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.isPhoneVerified != null)
    json['isPhoneVerified'] = instance.isPhoneVerified;
  if (instance.phoneVerifiedDate != null)
    json['phoneVerifiedDate'] = instance.phoneVerifiedDate;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.sessionScope != null)
    json['sessionScope'] = instance.sessionScope;
  if (instance.expiryHours != null) json['expiryHours'] = instance.expiryHours;
  if (instance.userSuspended != null)
    json['userSuspended'] = instance.userSuspended;
  if (instance.passwordExpired != null)
    json['passwordExpired'] = instance.passwordExpired;
  if (instance.passwordNeedChange != null)
    json['passwordNeedChange'] = instance.passwordNeedChange;
  if (instance.userTerminated != null)
    json['userTerminated'] = instance.userTerminated;
  if (instance.expiryDate != null) json['expiryDate'] = instance.expiryDate;
  if (instance.userStatus != null) json['userStatus'] = instance.userStatus;
  if (instance.registerStatus != null)
    json['registerStatus'] = instance.registerStatus;
  if (instance.userStatusDate != null)
    json['userStatusDate'] = instance.userStatusDate;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.verifyExpiryDate != null)
    json['verifyExpiryDate'] = instance.verifyExpiryDate;
  if (instance.hasPin != null) json['hasPin'] = instance.hasPin;
  if (instance.currentBusinessId != null)
    json['currentBusinessId'] = instance.currentBusinessId;
  if (instance.loginType != null) json['loginType'] = instance.loginType;
  if (instance.identityCardFront != null)
    json['identityCardFront'] = instance.identityCardFront;
  if (instance.identityCardBack != null)
    json['identityCardBack'] = instance.identityCardBack;
  if (instance.isSysUser != null) json['isSysUser'] = instance.isSysUser;
  if (instance.isAppUser != null) json['isAppUser'] = instance.isAppUser;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.userId != null) json['userId'] = instance.userId;
  if (instance.tokenType != null) json['tokenType'] = instance.tokenType;
  if (instance.accessToken != null) json['accessToken'] = instance.accessToken;
  if (instance.refreshToken != null)
    json['refreshToken'] = instance.refreshToken;
  if (instance.sessionState != null)
    json['sessionState'] = instance.sessionState;
  if (instance.user != null) json['user'] = instance.user;

  return json;
}
