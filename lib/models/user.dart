import 'package:dehub/models/business.dart';
import 'package:dehub/models/partner.dart';
part '../parts/user.dart';

class User {
  User? user;
  String? id;
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

  User({
    this.userId,
    this.user,
    this.businessStaffs,
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.sessionState,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.type,
    this.sessionId,
    this.isActive,
    this.email,
    this.username,
    this.isEmailVerified,
    this.emailVerifiedDate,
    this.phone,
    this.isPhoneVerified,
    this.phoneVerifiedDate,
    this.lastName,
    this.firstName,
    this.avatar,
    this.sessionScope,
    this.expiryHours,
    this.userSuspended,
    this.passwordExpired,
    this.passwordNeedChange,
    this.userTerminated,
    this.expiryDate,
    this.userStatus,
    this.registerStatus,
    this.userStatusDate,
    this.partnerId,
    this.verifyExpiryDate,
    this.hasPin,
    this.currentBusinessId,
    this.loginType,
    this.identityCardFront,
    this.identityCardBack,
    this.isSysUser,
    this.isAppUser,
    this.code,
    this.password,
    this.regUserId,
    this.businessId,
    this.registerNo,
    this.familyName,
    this.roleId,
    this.departmentUnitId,
    this.departmentSubUnitId,
    this.employeeUnitId,
    this.roleEnableDate,
    this.roleDisableDate,
    this.phone2,
    this.email2,
    this.isDanVerified,
    this.hasPassword,
    this.employeeUnit,
    this.currentBusiness,
    this.regNumber,
    this.stateRegNum,
    this.legalEntityType,
    this.partnerName,
    this.partnerNameEng,
    this.refCode,
    this.businessSectorId,
    this.businessSubSectorId,
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
    this.isConfirmed,
    this.isAnchorBusiness,
    this.partner,
  });

  static $fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
