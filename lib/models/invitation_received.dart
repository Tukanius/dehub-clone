part '../parts/invitation_received.dart';

class Invitation {
  int? count;
  List<Invitation>? rows;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? refCode;
  String? senderId;
  String? receiverId;
  String? type;
  String? invitationStatus;
  String? toMessage;
  DateTime? invitedDate;
  String? responseMessage;
  DateTime? respondedDate;
  String? senderUserId;
  String? bankName;
  String? senderUserName;
  String? senderUserAvatar;
  bool? toAnchor;
  String? partnerId;
  bool? isOnboarding;
  bool? isBuyer;
  bool? isSupplier;
  Invitation? sender;
  String? regNumber;
  String? stateRegNum;
  String? legalEntityType;
  String? partnerName;
  String? partnerNameEng;
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
  bool? isAnchorBusiness;
  Invitation? staff;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? avatar;
  Invitation? receiver;

  Invitation? partner;
  String? businessName;
  String? businessNameEng;
  Invitation? senderUser;
  Invitation? senderFinStaff;

  bool? accept;

  Invitation({
    this.accept,
    this.partner,
    this.businessName,
    this.businessNameEng,
    this.senderUser,
    this.senderFinStaff,
    this.count,
    this.rows,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.refCode,
    this.senderId,
    this.receiverId,
    this.type,
    this.invitationStatus,
    this.toMessage,
    this.invitedDate,
    this.responseMessage,
    this.respondedDate,
    this.senderUserId,
    this.bankName,
    this.senderUserName,
    this.senderUserAvatar,
    this.toAnchor,
    this.partnerId,
    this.isOnboarding,
    this.isBuyer,
    this.isSupplier,
    this.sender,
    this.regNumber,
    this.stateRegNum,
    this.legalEntityType,
    this.partnerName,
    this.partnerNameEng,
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
    this.isAnchorBusiness,
    this.staff,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.avatar,
    this.receiver,
  });

  static $fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);

  factory Invitation.fromJson(Map<String, dynamic> json) =>
      _$InvitationFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationToJson(this);
}
