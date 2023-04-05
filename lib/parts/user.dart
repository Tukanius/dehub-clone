part of '../models/user.dart';

User _$UserFromJson(Map<String, dynamic> json) {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? sessionId;
  String? partnerId;
  String? currentBusinessId;
  String? firstName;
  String? lastName;
  String? avatar;
  int? phone;
  String? email;
  String? loginType;
  String? username;
  User? partner;
  String? refCode;
  String? type;
  String? businessName;
  String? businessNameEng;
  User? currentBusiness;
  String? purchaseType;
  String? profileName;
  String? profileNameEng;
  String? productCategoryType;
  String? serviceCategoryType;
  String? businessStatus;
  bool? isVatPayer;
  String? logo;
  String? code;
  String? password;
  String? userId;
  String? tokeyType;
  String? accessToken;
  String? refreshToken;
  String? sessionState;
  String? sessionScope;

  if (json['id'] != null) id = json['id'];
  if (json['userId'] != null) userId = json['userId'];
  if (json['tokeyType'] != null) tokeyType = json['tokeyType'];
  if (json['accessToken'] != null) accessToken = json['accessToken'];
  if (json['refreshToken'] != null) refreshToken = json['refreshToken'];
  if (json['sessionState'] != null) sessionState = json['sessionState'];
  if (json['sessionScope'] != null) sessionScope = json['sessionScope'];
  if (json['code'] != null) code = json['code'];
  if (json['password'] != null) password = json['password'];
  if (json['createdAt'] != null) createdAt = json['createdAt'];
  if (json['updatedAt'] != null) updatedAt = json['updatedAt'];
  if (json['deletedAt'] != null) deletedAt = json['deletedAt'];
  if (json['sessionId'] != null) sessionId = json['sessionId'];
  if (json['partnerId'] != null) partnerId = json['partnerId'];
  if (json['currentBusinessId'] != null)
    currentBusinessId = json['currentBusinessId'];
  if (json['firstName'] != null) firstName = json['firstName'];
  if (json['lastName'] != null) lastName = json['lastName'];
  if (json['avatar'] != null) avatar = json['avatar'];
  if (json['phone'] != null) phone = json['phone'];
  if (json['email'] != null) email = json['email'];
  if (json['loginType'] != null) loginType = json['loginType'];
  if (json['username'] != null) username = json['username'];
  if (json['partner'] != null) partner = json['partner'];
  if (json['refCode'] != null) refCode = json['refCode'];
  if (json['type'] != null) type = json['type'];
  if (json['businessName'] != null) businessName = json['businessName'];
  if (json['businessNameEng'] != null)
    businessNameEng = json['businessNameEng'];
  if (json['currentBusiness'] != null)
    currentBusiness = json['currentBusiness'];
  if (json['purchaseType'] != null) purchaseType = json['purchaseType'];
  if (json['profileName'] != null) profileName = json['profileName'];
  if (json['profileNameEng'] != null) profileNameEng = json['profileNameEng'];
  if (json['productCategoryType'] != null)
    productCategoryType = json['productCategoryType'];
  if (json['serviceCategoryType'] != null)
    serviceCategoryType = json['serviceCategoryType'];
  if (json['businessStatus'] != null) businessStatus = json['businessStatus'];
  if (json['isVatPayer'] != null) isVatPayer = json['isVatPayer'];
  if (json['logo'] != null) logo = json['logo'];

  return User(
    id: id,
    accessToken: accessToken,
    userId: userId,
    refreshToken: refreshToken,
    tokeyType: tokeyType,
    sessionScope: sessionScope,
    sessionState: sessionState,
    createdAt: createdAt,
    code: code,
    password: password,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    sessionId: sessionId,
    partnerId: partnerId,
    currentBusinessId: currentBusinessId,
    firstName: firstName,
    lastName: lastName,
    avatar: avatar,
    phone: phone,
    email: email,
    loginType: loginType,
    username: username,
    partner: partner,
    refCode: refCode,
    type: type,
    businessName: businessName,
    businessNameEng: businessNameEng,
    currentBusiness: currentBusiness,
    purchaseType: purchaseType,
    profileName: profileName,
    profileNameEng: profileNameEng,
    productCategoryType: productCategoryType,
    serviceCategoryType: serviceCategoryType,
    businessStatus: businessStatus,
    isVatPayer: isVatPayer,
    logo: logo,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['id'] = instance.id;
  if (instance.accessToken != null) json['accessToken'] = instance.accessToken;
  if (instance.refreshToken != null)
    json['refreshToken'] = instance.refreshToken;
  if (instance.userId != null) json['userId'] = instance.userId;
  if (instance.tokeyType != null) json['tokeyType'] = instance.tokeyType;
  if (instance.sessionScope != null)
    json['sessionScope'] = instance.sessionScope;
  if (instance.sessionState != null)
    json['sessionState'] = instance.sessionState;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.password != null) json['password'] = instance.password;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.sessionId != null) json['sessionId'] = instance.sessionId;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.currentBusinessId != null)
    json['currentBusinessId'] = instance.currentBusinessId;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.loginType != null) json['loginType'] = instance.loginType;
  if (instance.username != null) json['username'] = instance.username;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.businessName != null)
    json['businessName'] = instance.businessName;
  if (instance.businessNameEng != null)
    json['businessNameEng'] = instance.businessNameEng;
  if (instance.currentBusiness != null)
    json['currentBusiness'] = instance.currentBusiness;
  if (instance.purchaseType != null)
    json['purchaseType'] = instance.purchaseType;
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.profileNameEng != null)
    json['profileNameEng'] = instance.profileNameEng;
  if (instance.productCategoryType != null)
    json['productCategoryType'] = instance.productCategoryType;
  if (instance.serviceCategoryType != null)
    json['serviceCategoryType'] = instance.serviceCategoryType;
  if (instance.businessStatus != null)
    json['businessStatus'] = instance.businessStatus;
  if (instance.isVatPayer != null) json['isVatPayer'] = instance.isVatPayer;
  if (instance.logo != null) json['logo'] = instance.logo;

  return json;
}
