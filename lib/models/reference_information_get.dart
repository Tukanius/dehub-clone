part '../parts/reference_information_get.dart';

class ReferenceInformationGet {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? refCode;
  String? modifiedUserId;
  String? termRule;
  String? orderConfirmTerm;
  int? expireDayCount;
  int? month;
  int? paymentDay;
  String? description;
  bool? isMain;
  bool? isActive;
  bool? isOpen;
  ReferenceInformationGet? modifiedUser;
  String? sessionId;
  String? username;
  String? partnerId;
  String? currentBusinessId;
  String? employeeUnitId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? avatar;
  String? userStatus;
  String? registerStatus;
  String? loginType;
  bool? isSysUser;
  bool? isAppUser;
  String? businessId;
  String? regUserId;
  String? parentId;
  bool? isParent;
  String? name;

  ReferenceInformationGet({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.refCode,
    this.modifiedUserId,
    this.termRule,
    this.orderConfirmTerm,
    this.expireDayCount,
    this.month,
    this.paymentDay,
    this.description,
    this.isMain,
    this.isActive,
    this.isOpen,
    this.modifiedUser,
    this.sessionId,
    this.username,
    this.partnerId,
    this.currentBusinessId,
    this.employeeUnitId,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.avatar,
    this.userStatus,
    this.registerStatus,
    this.loginType,
    this.isSysUser,
    this.isAppUser,
    this.businessId,
    this.regUserId,
    this.parentId,
    this.isParent,
    this.name,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ReferenceInformationGetFromJson(json);
  factory ReferenceInformationGet.fromJson(Map<String, dynamic> json) =>
      _$ReferenceInformationGetFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceInformationGetToJson(this);
}
