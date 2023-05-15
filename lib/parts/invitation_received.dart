part of '../models/invitation_received.dart';

InvitationReceived _$InvitationReceivedFromJson(Map<String, dynamic> json) {
  int? count;
  List<InvitationReceived>? rows;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? refCode;
  String? senderId;
  String? receiverId;
  String? type;
  String? invitationStatus;
  String? toMessage;
  String? invitedDate;
  String? responseMessage;
  String? respondedDate;
  String? senderUserId;
  String? bankName;
  String? senderUserName;
  String? senderUserAvatar;
  bool? toAnchor;
  String? partnerId;
  bool? isOnboarding;
  bool? isBuyer;
  bool? isSupplier;
  InvitationReceived? sender;
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
  InvitationReceived? staff;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? avatar;
  InvitationReceived? receiver;

  if (json['count'] != null) count = int.parse(json['count'].toString());
  // if (json['rows'] != null) {
  //   rows = (json['rows'] as List).map((e) => InvitationReceived()).toList();
  // }
  if (json['rows'] != null) {
    rows = (json['rows'] as List)
        .map((e) => InvitationReceived.fromJson(e))
        .toList();
  }
  if (json['id'] != null) id = json['id'];
  if (json['createdAt'] != null) createdAt = json['createdAt'];
  if (json['updatedAt'] != null) updatedAt = json['updatedAt'];
  if (json['deletedAt'] != null) deletedAt = json['deletedAt'];
  if (json['refCode'] != null) refCode = json['refCode'];
  if (json['senderId'] != null) senderId = json['senderId'];
  if (json['receiverId'] != null) receiverId = json['receiverId'];
  if (json['type'] != null) type = json['type'];
  if (json['invitationStatus'] != null)
    invitationStatus = json['invitationStatus'];
  if (json['toMessage'] != null) toMessage = json['toMessage'];
  if (json['invitedDate'] != null) invitedDate = json['invitedDate'];
  if (json['responseMessage'] != null)
    responseMessage = json['responseMessage'];
  if (json['respondedDate'] != null) respondedDate = json['respondedDate'];
  if (json['senderUserId'] != null) senderUserId = json['senderUserId'];
  if (json['bankName'] != null) bankName = json['bankName'];
  if (json['senderUserName'] != null) senderUserName = json['senderUserName'];
  if (json['senderUserAvatar'] != null)
    senderUserAvatar = json['senderUserAvatar'];
  if (json['toAnchor'] != null) toAnchor = json['toAnchor'];
  if (json['partnerId'] != null) partnerId = json['partnerId'];
  if (json['isOnboarding'] != null) isOnboarding = json['isOnboarding'];
  if (json['isBuyer'] != null) isBuyer = json['isBuyer'];
  if (json['isSupplier'] != null) isSupplier = json['isSupplier'];
  if (json['sender'] != null) {
    sender =
        InvitationReceived.fromJson(json['sender'] as Map<String, dynamic>);
  }
  if (json['regNumber'] != null) regNumber = json['regNumber'];
  if (json['stateRegNum'] != null) stateRegNum = json['stateRegNum'];
  if (json['legalEntityType'] != null)
    legalEntityType = json['legalEntityType'];
  if (json['partnerName'] != null) partnerName = json['partnerName'];
  if (json['partnerNameEng'] != null) partnerNameEng = json['partnerNameEng'];
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
  if (json['isAnchorBusiness'] != null)
    isAnchorBusiness = json['isAnchorBusiness'];
  if (json['staff'] != null) {
    staff = InvitationReceived.fromJson(json['staff'] as Map<String, dynamic>);
  }
  if (json['firstName'] != null) firstName = json['firstName'];
  if (json['lastName'] != null) lastName = json['lastName'];
  if (json['email'] != null) email = json['email'];
  if (json['phone'] != null) phone = json['phone'];
  if (json['avatar'] != null) avatar = json['avatar'];
  if (json['receiver'] != null) {
    receiver =
        InvitationReceived.fromJson(json['receiver'] as Map<String, dynamic>);
  }

  return InvitationReceived(
    count: count,
    rows: rows,
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    refCode: refCode,
    senderId: senderId,
    receiverId: receiverId,
    type: type,
    invitationStatus: invitationStatus,
    toMessage: toMessage,
    invitedDate: invitedDate,
    responseMessage: responseMessage,
    respondedDate: respondedDate,
    senderUserId: senderUserId,
    bankName: bankName,
    senderUserName: senderUserName,
    senderUserAvatar: senderUserAvatar,
    toAnchor: toAnchor,
    partnerId: partnerId,
    isOnboarding: isOnboarding,
    isBuyer: isBuyer,
    isSupplier: isSupplier,
    sender: sender,
    regNumber: regNumber,
    stateRegNum: stateRegNum,
    legalEntityType: legalEntityType,
    partnerName: partnerName,
    partnerNameEng: partnerNameEng,
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
    isAnchorBusiness: isAnchorBusiness,
    staff: staff,
    firstName: firstName,
    lastName: lastName,
    email: email,
    phone: phone,
    avatar: avatar,
    receiver: receiver,
  );
}

Map<String, dynamic> _$InvitationReceivedToJson(InvitationReceived instance) {
  Map<String, dynamic> json = {};

  if (instance.businessSubSectorId != null)
    json['businessSubSectorId'] = instance.businessSubSectorId;
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
