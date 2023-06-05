part '../parts/reference_information.dart';

class ReferenceInformation {
  int? count;
  List<ReferenceInformation>? rows;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? refCode;
  String? name;
  String? type;
  String? listType;
  String? description;

  String? modifiedUserId;
  String? termRule;
  String? orderConfirmTerm;
  int? expireDayCount;
  int? month;
  int? paymentDay;
  bool? isMain;
  bool? isActive;
  bool? isOpen;
  ReferenceInformation? modifiedUser;
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
  ReferenceInformation? regUser;
  ReferenceInformation? parent;
  ReferenceInformation? business;
  String? profileName;

  ReferenceInformation({
    this.count,
    this.rows,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.refCode,
    this.name,
    this.type,
    this.listType,
    this.description,
    this.modifiedUserId,
    this.termRule,
    this.orderConfirmTerm,
    this.expireDayCount,
    this.month,
    this.paymentDay,
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
    this.regUser,
    this.parent,
    this.business,
    this.profileName,
  });

  static $fromJson(Map<String, dynamic> json) =>
      _$ReferenceInformationFromJson(json);
  factory ReferenceInformation.fromJson(Map<String, dynamic> json) =>
      _$ReferenceInformationFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceInformationToJson(this);
}
