part of '../models/invitation_received.dart';

InvitationReceived _$InvitationReceivedFromJson(Map<String, dynamic> json) {
  return InvitationReceived(
    count: json['count'] != null ? int.parse(json['count'].toString()) : null,
    rows: json['rows'] != null
        ? (json['rows'] as List)
            .map((e) => InvitationReceived.fromJson(e))
            .toList()
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    senderId: json['senderId'] != null ? json['senderId'] as String : null,
    receiverId:
        json['receiverId'] != null ? json['receiverId'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    invitationStatus: json['invitationStatus'] != null
        ? json['invitationStatus'] as String
        : null,
    toMessage: json['toMessage'] != null ? json['toMessage'] as String : null,
    invitedDate:
        json['invitedDate'] != null ? json['invitedDate'] as String : null,
    responseMessage: json['responseMessage'] != null
        ? json['responseMessage'] as String
        : null,
    respondedDate:
        json['respondedDate'] != null ? json['respondedDate'] as String : null,
    senderUserId:
        json['senderUserId'] != null ? json['senderUserId'] as String : null,
    bankName: json['bankName'] != null ? json['bankName'] as String : null,
    senderUserName: json['senderUserName'] != null
        ? json['senderUserName'] as String
        : null,
    senderUserAvatar: json['senderUserAvatar'] != null
        ? json['senderUserAvatar'] as String
        : null,
    toAnchor: json['toAnchor'] != null ? json['toAnchor'] as bool : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    isOnboarding:
        json['isOnboarding'] != null ? json['isOnboarding'] as bool : null,
    isBuyer: json['isBuyer'] != null ? json['isBuyer'] as bool : null,
    isSupplier: json['isSupplier'] != null ? json['isSupplier'] as bool : null,
    sender: json['sender'] != null
        ? InvitationReceived.fromJson(json['sender'] as Map<String, dynamic>)
        : null,
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
    isAnchorBusiness: json['isAnchorBusiness'] != null
        ? json['isAnchorBusiness'] as bool
        : null,
    staff: json['staff'] != null
        ? InvitationReceived.fromJson(json['staff'] as Map<String, dynamic>)
        : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    receiver: json['receiver'] != null
        ? InvitationReceived.fromJson(json['receiver'] as Map<String, dynamic>)
        : null,
    partner: json['partner'] != null
        ? InvitationReceived.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    businessNameEng: json['businessNameEng'] != null
        ? json['businessNameEng'] as String
        : null,
    senderUser: json['senderUser'] != null
        ? InvitationReceived.fromJson(
            json['senderUser'] as Map<String, dynamic>)
        : null,
    senderFinStaff: json['senderFinStaff'] != null
        ? InvitationReceived.fromJson(
            json['senderFinStaff'] as Map<String, dynamic>)
        : null,
    accept: json['accept'] != null ? json['accept'] as bool : null,
  );
}

Map<String, dynamic> _$InvitationReceivedToJson(InvitationReceived instance) {
  Map<String, dynamic> json = {};

  if (instance.businessSubSectorId != null)
    json['businessSubSectorId'] = instance.businessSubSectorId;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.businessName != null)
    json['businessName'] = instance.businessName;
  if (instance.businessNameEng != null)
    json['businessNameEng'] = instance.businessNameEng;
  if (instance.senderUser != null) json['senderUser'] = instance.senderUser;
  if (instance.senderFinStaff != null)
    json['senderFinStaff'] = instance.senderFinStaff;
  if (instance.accept != null) json['accept'] = instance.accept;
  if (instance.count != null) json['count'] = instance.count;
  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.senderId != null) json['senderId'] = instance.senderId;
  if (instance.receiverId != null) json['receiverId'] = instance.receiverId;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.invitationStatus != null)
    json['invitationStatus'] = instance.invitationStatus;
  if (instance.toMessage != null) json['toMessage'] = instance.toMessage;
  if (instance.invitedDate != null) json['invitedDate'] = instance.invitedDate;
  if (instance.responseMessage != null)
    json['responseMessage'] = instance.responseMessage;
  if (instance.respondedDate != null)
    json['respondedDate'] = instance.respondedDate;
  if (instance.senderUserId != null)
    json['senderUserId'] = instance.senderUserId;
  if (instance.bankName != null) json['bankName'] = instance.bankName;
  if (instance.senderUserName != null)
    json['senderUserName'] = instance.senderUserName;
  if (instance.senderUserAvatar != null)
    json['senderUserAvatar'] = instance.senderUserAvatar;
  if (instance.toAnchor != null) json['toAnchor'] = instance.toAnchor;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.isOnboarding != null)
    json['isOnboarding'] = instance.isOnboarding;
  if (instance.isBuyer != null) json['isBuyer'] = instance.isBuyer;
  if (instance.isSupplier != null) json['isSupplier'] = instance.isSupplier;
  if (instance.sender != null) json['sender'] = instance.sender;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.stateRegNum != null) json['stateRegNum'] = instance.stateRegNum;
  if (instance.legalEntityType != null)
    json['legalEntityType'] = instance.legalEntityType;
  if (instance.partnerName != null) json['partnerName'] = instance.partnerName;
  if (instance.partnerNameEng != null)
    json['partnerNameEng'] = instance.partnerNameEng;
  if (instance.businessSectorId != null)
    json['businessSectorId'] = instance.businessSectorId;
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
  if (instance.staff != null) json['staff'] = instance.staff;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.receiver != null) json['receiver'] = instance.receiver;
  return json;
}
