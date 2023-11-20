part of '../models/finance.dart';

Finance _$FinanceFromJson(Map<String, dynamic> json) {
  return Finance(
    count: json['count'] != null ? int.parse(json['count'].toString()) : null,
    rows: json['rows'] != null
        ? (json['rows'] as List).map((e) => Finance.fromJson(e)).toList()
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'].toString())
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'].toString())
        : null,
    deletedAt: json['deletedAt'] != null
        ? DateTime.parse(json['deletedAt'].toString())
        : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    repaymentStatus: json['repaymentStatus'] != null
        ? json['repaymentStatus'] as String
        : null,
    name: json['name'] != null ? json['name'] as String : null,
    businessRef:
        json['businessRef'] != null ? json['businessRef'] as String : null,
    partnerRef:
        json['partnerRef'] != null ? json['partnerRef'] as String : null,
    overdueStatus:
        json['overdueStatus'] != null ? json['overdueStatus'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    password: json['password'] != null ? json['password'] as String : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
    accessToken:
        json['accessToken'] != null ? json['accessToken'] as String : null,
    parentRefCode:
        json['parentRefCode'] != null ? json['parentRefCode'] as String : null,
    invCount: json['invCount'] != null
        ? double.parse(json['invCount'].toString())
        : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    invId: json['invId'] != null ? json['invId'] as String : null,
    invRefCode:
        json['invRefCode'] != null ? json['invRefCode'] as String : null,
    requestedBusinessId: json['requestedBusinessId'] != null
        ? json['requestedBusinessId'] as String
        : null,
    requestedBusinessSubLimit: json['requestedBusinessSubLimit'] != null
        ? double.parse(json['requestedBusinessSubLimit'].toString())
        : null,
    requestedUserId: json['requestedUserId'] != null
        ? json['requestedUserId'] as String
        : null,
    responsePeriod: json['responsePeriod'] != null
        ? double.parse(json['responsePeriod'].toString())
        : null,
    responseDate: json['responseDate'] != null
        ? DateTime.parse(json['responseDate'].toString())
        : null,
    requestStatus:
        json['requestStatus'] != null ? json['requestStatus'] as String : null,
    programId: json['programId'] != null ? json['programId'] as String : null,
    productId: json['productId'] != null ? json['productId'] as String : null,
    productType:
        json['productType'] != null ? json['productType'] as String : null,
    requestedAmount: json['requestedAmount'] != null
        ? double.parse(json['requestedAmount'].toString())
        : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    finAmountAcceptable: json['finAmountAcceptable'] != null
        ? json['finAmountAcceptable'] as bool
        : null,
    finMinAmount: json['finMinAmount'] != null
        ? double.parse(json['finMinAmount'].toString())
        : null,
    finMaxAmount: json['finMaxAmount'] != null
        ? double.parse(json['finMaxAmount'].toString())
        : null,
    amountToPay: json['amountToPay'] != null
        ? double.parse(json['amountToPay'].toString())
        : null,
    balanceAcceptable: json['balanceAcceptable'] != null
        ? json['balanceAcceptable'] as bool
        : null,
    minInvBalance: json['minInvBalance'] != null
        ? double.parse(json['minInvBalance'].toString())
        : null,
    tenorAcceptable: json['tenorAcceptable'] != null
        ? json['tenorAcceptable'] as bool
        : null,
    minTenor: json['minTenor'] != null
        ? double.parse(json['minTenor'].toString())
        : null,
    paidAmount: json['paidAmount'] != null
        ? double.parse(json['paidAmount'].toString())
        : null,
    maxTenor: json['maxTenor'] != null
        ? double.parse(json['maxTenor'].toString())
        : null,
    calculatedFeePercent: json['calculatedFeePercent'] != null
        ? double.parse(json['calculatedFeePercent'].toString())
        : null,
    calculatedFeeAmount: json['calculatedFeeAmount'] != null
        ? double.parse(json['calculatedFeeAmount'].toString())
        : null,
    scfFee:
        json['scfFee'] != null ? double.parse(json['scfFee'].toString()) : null,
    scfFeeAmount: json['scfFeeAmount'] != null
        ? double.parse(json['scfFeeAmount'].toString())
        : null,
    trxFee:
        json['trxFee'] != null ? double.parse(json['trxFee'].toString()) : null,
    appFee:
        json['appFee'] != null ? double.parse(json['appFee'].toString()) : null,
    disbursementFee: json['disbursementFee'] != null
        ? double.parse(json['disbursementFee'].toString())
        : null,
    totalScfFeePercent: json['totalScfFeePercent'] != null
        ? double.parse(json['totalScfFeePercent'].toString())
        : null,
    totalScfFeeAmount: json['totalScfFeeAmount'] != null
        ? double.parse(json['totalScfFeeAmount'].toString())
        : null,
    feeRule: json['feeRule'] != null ? json['feeRule'] as String : null,
    feeAcceptable:
        json['feeAcceptable'] != null ? json['feeAcceptable'] as bool : null,
    minFeeAmount: json['minFeeAmount'] != null
        ? double.parse(json['minFeeAmount'].toString())
        : null,
    maxFeeAmount: json['maxFeeAmount'] != null
        ? double.parse(json['maxFeeAmount'].toString())
        : null,
    repaymentDate: json['repaymentDate'] != null
        ? DateTime.parse(json['repaymentDate'].toString())
        : null,
    recourseTerm:
        json['recourseTerm'] != null ? json['recourseTerm'] as bool : null,
    recourseDate: json['recourseDate'] != null
        ? DateTime.parse(json['recourseDate'].toString())
        : null,
    restrictDate: json['restrictDate'] != null
        ? DateTime.parse(json['restrictDate'].toString())
        : null,
    penaltyPercent: json['penaltyPercent'] != null
        ? double.parse(json['penaltyPercent'].toString())
        : null,
    penaltyType:
        json['penaltyType'] != null ? json['penaltyType'] as String : null,
    repaymentRule:
        json['repaymentRule'] != null ? json['repaymentRule'] as String : null,
    invConfirmedDays: json['invConfirmedDays'] != null
        ? double.parse(json['invConfirmedDays'].toString())
        : null,
    daysAcceptable:
        json['daysAcceptable'] != null ? json['daysAcceptable'] as bool : null,
    minDays: json['minDays'] != null
        ? double.parse(json['minDays'].toString())
        : null,
    maxDays: json['maxDays'] != null
        ? double.parse(json['maxDays'].toString())
        : null,
    overdueStatusAcceptable: json['overdueStatusAcceptable'] != null
        ? json['overdueStatusAcceptable'] as bool
        : null,
    invOverdueStatus: json['invOverdueStatus'] != null
        ? json['invOverdueStatus'] as String
        : null,
    requestedBusinessAccId: json['requestedBusinessAccId'] != null
        ? json['requestedBusinessAccId'] as String
        : null,
    receiverBusinessAccId: json['receiverBusinessAccId'] != null
        ? json['receiverBusinessAccId'] as String
        : null,
    isBankApproved:
        json['isBankApproved'] != null ? json['isBankApproved'] as bool : null,
    bankFeeAmount: json['bankFeeAmount'] != null
        ? double.parse(json['bankFeeAmount'].toString())
        : null,
    suppAcceptable:
        json['suppAcceptable'] != null ? json['suppAcceptable'] as bool : null,
    buyerAcceptable: json['buyerAcceptable'] != null
        ? json['buyerAcceptable'] as bool
        : null,
    invSenderUserId: json['invSenderUserId'] != null
        ? json['invSenderUserId'] as String
        : null,
    invConfirmedAmount: json['invConfirmedAmount'] != null
        ? double.parse(json['invConfirmedAmount'].toString())
        : null,
    invPaidAmount: json['invPaidAmount'] != null
        ? double.parse(json['invPaidAmount'].toString())
        : null,
    invAmountToPay: json['invAmountToPay'] != null
        ? double.parse(json['invAmountToPay'].toString())
        : null,
    invReceiverBusinessId: json['invReceiverBusinessId'] != null
        ? json['invReceiverBusinessId'] as String
        : null,
    invReceiverBusinessRegNumber: json['invReceiverBusinessRegNumber'] != null
        ? json['invReceiverBusinessRegNumber'] as String
        : null,
    invPaymentDate: json['invPaymentDate'] != null
        ? DateTime.parse(json['invPaymentDate'].toString())
        : null,
    invConfirmedUserId: json['invConfirmedUserId'] != null
        ? json['invConfirmedUserId'] as String
        : null,
    fundingInstructionStatus: json['fundingInstructionStatus'] != null
        ? json['fundingInstructionStatus'] as String
        : null,
    invStatus: json['invStatus'] != null ? json['invStatus'] as String : null,
    invCreatedAt: json['invCreatedAt'] != null
        ? DateTime.parse(json['invCreatedAt'].toString())
        : null,
    invConfirmedDate: json['invConfirmedDate'] != null
        ? DateTime.parse(json['invConfirmedDate'].toString())
        : null,
    invPaymentStatus: json['invPaymentStatus'] != null
        ? json['invPaymentStatus'] as String
        : null,
    invPaymentTermId: json['invPaymentTermId'] != null
        ? json['invPaymentTermId'] as String
        : null,
    invPaymentTermConfigType: json['invPaymentTermConfigType'] != null
        ? json['invPaymentTermConfigType'] as String
        : null,
    invPaymentTermDesc: json['invPaymentTermDesc'] != null
        ? json['invPaymentTermDesc'] as String
        : null,
    respondedDate: json['respondedDate'] != null
        ? DateTime.parse(json['respondedDate'].toString())
        : null,
    respondedUserId: json['respondedUserId'] != null
        ? json['respondedUserId'] as String
        : null,
    isDisbursed:
        json['isDisbursed'] != null ? json['isDisbursed'] as bool : null,
    toDisburseDate: json['toDisburseDate'] != null
        ? DateTime.parse(json['toDisburseDate'].toString())
        : null,
    disbursedDate: json['disbursedDate'] != null
        ? DateTime.parse(json['disbursedDate'].toString())
        : null,
    repaymentAmount: json['repaymentAmount'] != null
        ? double.parse(json['repaymentAmount'].toString())
        : null,
    repaymentInvId: json['repaymentInvId'] != null
        ? json['repaymentInvId'] as String
        : null,
    isApproved: json['isApproved'] != null ? json['isApproved'] as bool : null,
    approvedAmount: json['approvedAmount'] != null
        ? double.parse(json['approvedAmount'].toString())
        : null,
    isResponded:
        json['isResponded'] != null ? json['isResponded'] as bool : null,
    respondDesc:
        json['respondDesc'] != null ? json['respondDesc'] as String : null,
    interestStartDate: json['interestStartDate'] != null
        ? DateTime.parse(json['interestStartDate'].toString())
        : null,
    minAmountAcceptable: json['minAmountAcceptable'] != null
        ? json['minAmountAcceptable'] as bool
        : null,
    maxAmountAcceptable: json['maxAmountAcceptable'] != null
        ? json['maxAmountAcceptable'] as bool
        : null,
    remainingDays: json['remainingDays'] != null
        ? double.parse(json['remainingDays'].toString())
        : null,
    program: json['program'] != null
        ? Finance.fromJson(json['program'] as Map<String, dynamic>)
        : null,
    respondedUser: json['respondedUser'] != null
        ? Finance.fromJson(json['respondedUser'] as Map<String, dynamic>)
        : null,
    requestedBusiness: json['requestedBusiness'] != null
        ? Finance.fromJson(json['requestedBusiness'] as Map<String, dynamic>)
        : null,
    partner: json['partner'] != null
        ? Finance.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    product: json['product'] != null
        ? Finance.fromJson(json['product'] as Map<String, dynamic>)
        : null,
    invConfirmedUser: json['invConfirmedUser'] != null
        ? Finance.fromJson(json['invConfirmedUser'] as Map<String, dynamic>)
        : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    invReceiverBusiness: json['invReceiverBusiness'] != null
        ? Finance.fromJson(json['invReceiverBusiness'] as Map<String, dynamic>)
        : null,
    invSenderUser: json['invSenderUser'] != null
        ? Finance.fromJson(json['invSenderUser'] as Map<String, dynamic>)
        : null,
    payerBusiness: json['payerBusiness'] != null
        ? Finance.fromJson(json['payerBusiness'] as Map<String, dynamic>)
        : null,
    requestedUser: json['requestedUser'] != null
        ? Finance.fromJson(json['requestedUser'] as Map<String, dynamic>)
        : null,
    repaymentInv: json['repaymentInv'] != null
        ? Finance.fromJson(json['repaymentInv'] as Map<String, dynamic>)
        : null,
    requestedFinUser: json['requestedFinUser'] != null
        ? Finance.fromJson(json['requestedFinUser'] as Map<String, dynamic>)
        : null,
    payerAcc: json['payerAcc'] != null
        ? Finance.fromJson(json['payerAcc'] as Map<String, dynamic>)
        : null,
  );
}

Map<String, dynamic> _$FinanceToJson(Finance instance) {
  Map<String, dynamic> json = {};

  if (instance.repaymentStatus != null)
    json['repaymentStatus'] = instance.repaymentStatus;
  if (instance.payerAcc != null) json['payerAcc'] = instance.payerAcc;
  if (instance.overdueStatus != null)
    json['overdueStatus'] = instance.overdueStatus;
  if (instance.requestedFinUser != null)
    json['requestedFinUser'] = instance.requestedFinUser;
  if (instance.parentRefCode != null)
    json['parentRefCode'] = instance.parentRefCode;
  if (instance.invSenderUser != null)
    json['invSenderUser'] = instance.invSenderUser;
  if (instance.invCount != null) json['invCount'] = instance.invCount;
  if (instance.payerBusiness != null)
    json['payerBusiness'] = instance.payerBusiness;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.invId != null) json['invId'] = instance.invId;
  if (instance.invRefCode != null) json['invRefCode'] = instance.invRefCode;
  if (instance.requestedBusinessId != null)
    json['requestedBusinessId'] = instance.requestedBusinessId;
  if (instance.requestedBusinessSubLimit != null)
    json['requestedBusinessSubLimit'] = instance.requestedBusinessSubLimit;
  if (instance.requestedUserId != null)
    json['requestedUserId'] = instance.requestedUserId;
  if (instance.responsePeriod != null)
    json['responsePeriod'] = instance.responsePeriod;
  if (instance.responseDate != null)
    json['responseDate'] = instance.responseDate;
  if (instance.requestStatus != null)
    json['requestStatus'] = instance.requestStatus;
  if (instance.paidAmount != null) json['paidAmount'] = instance.paidAmount;
  if (instance.programId != null) json['programId'] = instance.programId;
  if (instance.productId != null) json['productId'] = instance.productId;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.productType != null) json['productType'] = instance.productType;
  if (instance.requestedAmount != null)
    json['requestedAmount'] = instance.requestedAmount;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.finAmountAcceptable != null)
    json['finAmountAcceptable'] = instance.finAmountAcceptable;
  if (instance.finMinAmount != null)
    json['finMinAmount'] = instance.finMinAmount;
  if (instance.finMaxAmount != null)
    json['finMaxAmount'] = instance.finMaxAmount;
  if (instance.balanceAcceptable != null)
    json['balanceAcceptable'] = instance.balanceAcceptable;
  if (instance.minInvBalance != null)
    json['minInvBalance'] = instance.minInvBalance;
  if (instance.tenorAcceptable != null)
    json['tenorAcceptable'] = instance.tenorAcceptable;
  if (instance.minTenor != null) json['minTenor'] = instance.minTenor;
  if (instance.maxTenor != null) json['maxTenor'] = instance.maxTenor;
  if (instance.calculatedFeePercent != null)
    json['calculatedFeePercent'] = instance.calculatedFeePercent;
  if (instance.calculatedFeeAmount != null)
    json['calculatedFeeAmount'] = instance.calculatedFeeAmount;
  if (instance.scfFee != null) json['scfFee'] = instance.scfFee;
  if (instance.scfFeeAmount != null)
    json['scfFeeAmount'] = instance.scfFeeAmount;
  if (instance.trxFee != null) json['trxFee'] = instance.trxFee;
  if (instance.appFee != null) json['appFee'] = instance.appFee;
  if (instance.disbursementFee != null)
    json['disbursementFee'] = instance.disbursementFee;
  if (instance.totalScfFeePercent != null)
    json['totalScfFeePercent'] = instance.totalScfFeePercent;
  if (instance.totalScfFeeAmount != null)
    json['totalScfFeeAmount'] = instance.totalScfFeeAmount;
  if (instance.feeRule != null) json['feeRule'] = instance.feeRule;
  if (instance.feeAcceptable != null)
    json['feeAcceptable'] = instance.feeAcceptable;
  if (instance.minFeeAmount != null)
    json['minFeeAmount'] = instance.minFeeAmount;
  if (instance.maxFeeAmount != null)
    json['maxFeeAmount'] = instance.maxFeeAmount;
  if (instance.repaymentDate != null)
    json['repaymentDate'] = instance.repaymentDate;
  if (instance.recourseTerm != null)
    json['recourseTerm'] = instance.recourseTerm;
  if (instance.recourseDate != null)
    json['recourseDate'] = instance.recourseDate;
  if (instance.restrictDate != null)
    json['restrictDate'] = instance.restrictDate;
  if (instance.penaltyPercent != null)
    json['penaltyPercent'] = instance.penaltyPercent;
  if (instance.penaltyType != null) json['penaltyType'] = instance.penaltyType;
  if (instance.repaymentRule != null)
    json['repaymentRule'] = instance.repaymentRule;
  if (instance.invConfirmedDays != null)
    json['invConfirmedDays'] = instance.invConfirmedDays;
  if (instance.daysAcceptable != null)
    json['daysAcceptable'] = instance.daysAcceptable;
  if (instance.amountToPay != null) json['amountToPay'] = instance.amountToPay;
  if (instance.minDays != null) json['minDays'] = instance.minDays;
  if (instance.maxDays != null) json['maxDays'] = instance.maxDays;
  if (instance.overdueStatusAcceptable != null)
    json['overdueStatusAcceptable'] = instance.overdueStatusAcceptable;
  if (instance.invOverdueStatus != null)
    json['invOverdueStatus'] = instance.invOverdueStatus;
  if (instance.requestedBusinessAccId != null)
    json['requestedBusinessAccId'] = instance.requestedBusinessAccId;
  if (instance.receiverBusinessAccId != null)
    json['receiverBusinessAccId'] = instance.receiverBusinessAccId;
  if (instance.isBankApproved != null)
    json['isBankApproved'] = instance.isBankApproved;
  if (instance.bankFeeAmount != null)
    json['bankFeeAmount'] = instance.bankFeeAmount;
  if (instance.suppAcceptable != null)
    json['suppAcceptable'] = instance.suppAcceptable;
  if (instance.buyerAcceptable != null)
    json['buyerAcceptable'] = instance.buyerAcceptable;
  if (instance.invSenderUserId != null)
    json['invSenderUserId'] = instance.invSenderUserId;
  if (instance.invConfirmedAmount != null)
    json['invConfirmedAmount'] = instance.invConfirmedAmount;
  if (instance.invPaidAmount != null)
    json['invPaidAmount'] = instance.invPaidAmount;
  if (instance.invAmountToPay != null)
    json['invAmountToPay'] = instance.invAmountToPay;
  if (instance.invReceiverBusinessId != null)
    json['invReceiverBusinessId'] = instance.invReceiverBusinessId;
  if (instance.invReceiverBusinessRegNumber != null)
    json['invReceiverBusinessRegNumber'] =
        instance.invReceiverBusinessRegNumber;
  if (instance.invPaymentDate != null)
    json['invPaymentDate'] = instance.invPaymentDate;
  if (instance.invConfirmedUserId != null)
    json['invConfirmedUserId'] = instance.invConfirmedUserId;
  if (instance.fundingInstructionStatus != null)
    json['fundingInstructionStatus'] = instance.fundingInstructionStatus;
  if (instance.invStatus != null) json['invStatus'] = instance.invStatus;
  if (instance.invCreatedAt != null)
    json['invCreatedAt'] = instance.invCreatedAt;
  if (instance.invConfirmedDate != null)
    json['invConfirmedDate'] = instance.invConfirmedDate;
  if (instance.invPaymentStatus != null)
    json['invPaymentStatus'] = instance.invPaymentStatus;
  if (instance.invPaymentTermId != null)
    json['invPaymentTermId'] = instance.invPaymentTermId;
  if (instance.invPaymentTermConfigType != null)
    json['invPaymentTermConfigType'] = instance.invPaymentTermConfigType;
  if (instance.invPaymentTermDesc != null)
    json['invPaymentTermDesc'] = instance.invPaymentTermDesc;
  if (instance.respondedDate != null)
    json['respondedDate'] = instance.respondedDate;
  if (instance.respondedUserId != null)
    json['respondedUserId'] = instance.respondedUserId;
  if (instance.isDisbursed != null) json['isDisbursed'] = instance.isDisbursed;
  if (instance.toDisburseDate != null)
    json['toDisburseDate'] = instance.toDisburseDate;
  if (instance.disbursedDate != null)
    json['disbursedDate'] = instance.disbursedDate;
  if (instance.repaymentAmount != null)
    json['repaymentAmount'] = instance.repaymentAmount;
  if (instance.repaymentInvId != null)
    json['repaymentInvId'] = instance.repaymentInvId;
  if (instance.isApproved != null) json['isApproved'] = instance.isApproved;
  if (instance.approvedAmount != null)
    json['approvedAmount'] = instance.approvedAmount;
  if (instance.isResponded != null) json['isResponded'] = instance.isResponded;
  if (instance.respondDesc != null) json['respondDesc'] = instance.respondDesc;
  if (instance.interestStartDate != null)
    json['interestStartDate'] = instance.interestStartDate;
  if (instance.minAmountAcceptable != null)
    json['minAmountAcceptable'] = instance.minAmountAcceptable;
  if (instance.maxAmountAcceptable != null)
    json['maxAmountAcceptable'] = instance.maxAmountAcceptable;
  if (instance.remainingDays != null)
    json['remainingDays'] = instance.remainingDays;
  if (instance.program != null) json['program'] = instance.program;
  if (instance.respondedUser != null)
    json['respondedUser'] = instance.respondedUser;
  if (instance.requestedBusiness != null)
    json['requestedBusiness'] = instance.requestedBusiness;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.product != null) json['product'] = instance.product;
  if (instance.invConfirmedUser != null)
    json['invConfirmedUser'] = instance.invConfirmedUser;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.businessName != null)
    json['businessName'] = instance.businessName;
  if (instance.invReceiverBusiness != null)
    json['invReceiverBusiness'] = instance.invReceiverBusiness;
  if (instance.requestedUser != null)
    json['requestedUser'] = instance.requestedUser;
  if (instance.repaymentInv != null)
    json['repaymentInv'] = instance.repaymentInv;

  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.businessRef != null) json['businessRef'] = instance.businessRef;
  if (instance.partnerRef != null) json['partnerRef'] = instance.partnerRef;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.password != null) json['password'] = instance.password;
  if (instance.accessToken != null) json['accessToken'] = instance.accessToken;
  if (instance.count != null) json['count'] = instance.count;
  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;

  return json;
}