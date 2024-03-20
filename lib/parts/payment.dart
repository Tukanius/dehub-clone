part of '../models/payment.dart';

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment(
    count: json['count'] != null ? int.parse(json['count'].toString()) : null,
    incomeAmount: json['incomeAmount'] != null
        ? int.parse(json['incomeAmount'].toString())
        : null,
    outcomeAmount: json['outcomeAmount'] != null
        ? int.parse(json['outcomeAmount'].toString())
        : null,
    rows: json['rows'] != null
        ? (json['rows'] as List).map((e) => Payment.fromJson(e)).toList()
        : null,
    numberSurvey: json['numberSurvey'] != null
        ? (json['numberSurvey'] as List).map((e) => Stats.fromJson(e)).toList()
        : null,
    values: json['values'] != null
        ? (json['values'] as List).map((e) => Payment.fromJson(e)).toList()
        : null,
    byInterval: json['byInterval'] != null
        ? (json['byInterval'] as List).map((e) => Payment.fromJson(e)).toList()
        : null,
    revenueStructure: json['revenueStructure'] != null
        ? (json['revenueStructure'] as List)
            .map((e) => Payment.fromJson(e))
            .toList()
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'].toString())
        : null,
    header: json['header'] != null
        ? DateTime.parse(json['header'].toString())
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'].toString())
        : null,
    deletedAt: json['deletedAt'] != null
        ? DateTime.parse(json['deletedAt'].toString())
        : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    image: json['image'] != null ? json['image'] as String : null,
    accountName:
        json['accountName'] != null ? json['accountName'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    inOutType: json['inOutType'] != null ? json['inOutType'] as String : null,
    date: json['date'] != null ? json['date'] as String : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    bankName: json['bankName'] != null ? json['bankName'] as String : null,
    number: json['number'] != null ? json['number'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    shortName: json['shortName'] != null ? json['shortName'] as String : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    isDefault: json['isDefault'] != null ? json['isDefault'] as bool : null,
    isVerified: json['isVerified'] != null ? json['isVerified'] as bool : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    icon: json['icon'] != null ? json['icon'] as String : null,
    business: json['business'] != null
        ? Payment.fromJson(json['business'] as Map<String, dynamic>)
        : null,
    payerBusiness: json['payerBusiness'] != null
        ? Payment.fromJson(json['payerBusiness'] as Map<String, dynamic>)
        : null,
    payerUser: json['payerUser'] != null
        ? Payment.fromJson(json['payerUser'] as Map<String, dynamic>)
        : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
    partner: json['partner'] != null
        ? Payment.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    account: json['account'] != null
        ? Payment.fromJson(json['account'] as Map<String, dynamic>)
        : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    regUser: json['regUser'] != null
        ? Payment.fromJson(json['regUser'] as Map<String, dynamic>)
        : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    transactionStatus: json['transactionStatus'] != null
        ? json['transactionStatus'] as String
        : null,
    paymentId: json['paymentId'] != null ? json['paymentId'] as String : null,
    paymentRefCode: json['paymentRefCode'] != null
        ? json['paymentRefCode'] as String
        : null,
    paymentMethod:
        json['paymentMethod'] != null ? json['paymentMethod'] as String : null,
    objectType:
        json['objectType'] != null ? json['objectType'] as String : null,
    objectId: json['objectId'] != null ? json['objectId'] as String : null,
    invoiceRefCode: json['e'] != null ? json['e'] as String : null,
    payerUserId:
        json['payerUserId'] != null ? json['payerUserId'] as String : null,
    payerBusinessId: json['payerBusinessId'] != null
        ? json['payerBusinessId'] as String
        : null,
    typayerBusinessRegNumbere: json['typayerBusinessRegNumbere'] != null
        ? json['typayerBusinessRegNumbere'] as String
        : null,
    creditAccountId: json['creditAccountId'] != null
        ? json['creditAccountId'] as String
        : null,
    creditAccountBank: json['creditAccountBank'] != null
        ? json['creditAccountBank'] as String
        : null,
    creditAccountName: json['creditAccountName'] != null
        ? json['creditAccountName'] as String
        : null,
    creditAccountNumber: json['creditAccountNumber'] != null
        ? json['creditAccountNumber'] as String
        : null,
    creditAccountCurrency: json['creditAccountCurrency'] != null
        ? json['creditAccountCurrency'] as String
        : null,
    receiverBusinessId: json['receiverBusinessId'] != null
        ? json['receiverBusinessId'] as String
        : null,
    debitAccountId: json['debitAccountId'] != null
        ? json['debitAccountId'] as String
        : null,
    debitAccountBank: json['debitAccountBank'] != null
        ? json['debitAccountBank'] as String
        : null,
    debitAccountName: json['debitAccountName'] != null
        ? json['debitAccountName'] as String
        : null,
    debitAccountNumber: json['debitAccountNumber'] != null
        ? json['debitAccountNumber'] as String
        : null,
    debitAccountCurrency: json['debitAccountCurrency'] != null
        ? json['debitAccountCurrency'] as String
        : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    addInfo: json['addInfo'] != null ? json['addInfo'] as String : null,
    amount:
        json['amount'] != null ? double.parse(json['amount'].toString()) : null,
    hasTrxFee: json['hasTrxFee'] != null ? json['hasTrxFee'] as bool : null,
    trxFee:
        json['trxFee'] != null ? double.parse(json['trxFee'].toString()) : null,
    hasPaymentFee:
        json['hasPaymentFee'] != null ? json['hasPaymentFee'] as bool : null,
    paymentFee: json['paymentFee'] != null
        ? double.parse(json['paymentFee'].toString())
        : null,
    percent: json['percent'] != null
        ? double.parse(json['percent'].toString())
        : null,
    hasBankTrxFee:
        json['hasBankTrxFee'] != null ? json['hasBankTrxFee'] as bool : null,
    bankTrxFee: json['bankTrxFee'] != null
        ? double.parse(json['bankTrxFee'].toString())
        : null,
    totalAmount: json['totalAmount'] != null
        ? double.parse(json['totalAmount'].toString())
        : null,
    tranId: json['tranId'] != null ? json['tranId'] as String : null,
    tranDate: json['tranDate'] != null ? json['tranDate'] as String : null,
    tranStatus:
        json['tranStatus'] != null ? json['tranStatus'] as String : null,
    requestId: json['requestId'] != null ? json['requestId'] as String : null,
    clientId: json['clientId'] != null ? json['clientId'] as String : null,
    responseType:
        json['responseType'] != null ? json['responseType'] as String : null,
    redirectUri:
        json['redirectUri'] != null ? json['redirectUri'] as String : null,
    url: json['url'] != null ? Uri.parse(json['url'].toString()) : null,
  );
}

Map<String, dynamic> _$PaymentToJson(Payment instance) {
  Map<String, dynamic> json = {};
  if (instance.byInterval != null) json['byInterval'] = instance.byInterval;
  if (instance.account != null) json['account'] = instance.account;
  if (instance.payerUser != null) json['payerUser'] = instance.payerUser;
  if (instance.payerBusiness != null) {
    json['payerBusiness'] = instance.payerBusiness;
  }
  if (instance.numberSurvey != null) {
    json['numberSurvey'] = instance.numberSurvey;
  }
  if (instance.incomeAmount != null) {
    json['incomeAmount'] = instance.incomeAmount;
  }
  if (instance.outcomeAmount != null) {
    json['outcomeAmount'] = instance.outcomeAmount;
  }
  if (instance.date != null) json['date'] = instance.date;
  if (instance.revenueStructure != null) {
    json['revenueStructure'] = instance.revenueStructure;
  }
  if (instance.requestId != null) json['requestId'] = instance.requestId;
  if (instance.image != null) json['image'] = instance.image;
  if (instance.clientId != null) json['clientId'] = instance.clientId;
  if (instance.responseType != null) {
    json['responseType'] = instance.responseType;
  }
  if (instance.redirectUri != null) json['redirectUri'] = instance.redirectUri;
  if (instance.url != null) json['url'] = instance.url;
  if (instance.values != null) json['values'] = instance.values;
  if (instance.header != null) json['header'] = instance.header;
  if (instance.inOutType != null) json['inOutType'] = instance.inOutType;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.transactionStatus != null) {
    json['transactionStatus'] = instance.transactionStatus;
  }
  if (instance.paymentId != null) json['paymentId'] = instance.paymentId;
  if (instance.paymentRefCode != null) {
    json['paymentRefCode'] = instance.paymentRefCode;
  }
  if (instance.paymentMethod != null) {
    json['paymentMethod'] = instance.paymentMethod;
  }
  if (instance.objectType != null) json['objectType'] = instance.objectType;
  if (instance.objectId != null) json['objectId'] = instance.objectId;
  if (instance.invoiceRefCode != null) {
    json['invoiceRefCode'] = instance.invoiceRefCode;
  }
  if (instance.payerUserId != null) json['payerUserId'] = instance.payerUserId;
  if (instance.payerBusinessId != null) {
    json['payerBusinessId'] = instance.payerBusinessId;
  }
  if (instance.typayerBusinessRegNumbere != null) {
    json['typayerBusinessRegNumbere'] = instance.typayerBusinessRegNumbere;
  }
  if (instance.creditAccountId != null) {
    json['creditAccountId'] = instance.creditAccountId;
  }
  if (instance.creditAccountBank != null) {
    json['creditAccountBank'] = instance.creditAccountBank;
  }
  if (instance.creditAccountName != null) {
    json['creditAccountName'] = instance.creditAccountName;
  }
  if (instance.creditAccountNumber != null) {
    json['creditAccountNumber'] = instance.creditAccountNumber;
  }
  if (instance.creditAccountCurrency != null) {
    json['creditAccountCurrency'] = instance.creditAccountCurrency;
  }
  if (instance.debitAccountId != null) {
    json['debitAccountId'] = instance.debitAccountId;
  }
  if (instance.receiverBusinessId != null) {
    json['receiverBusinessId'] = instance.receiverBusinessId;
  }
  if (instance.debitAccountBank != null) {
    json['debitAccountBank'] = instance.debitAccountBank;
  }
  if (instance.debitAccountName != null) {
    json['debitAccountName'] = instance.debitAccountName;
  }
  if (instance.debitAccountNumber != null) {
    json['debitAccountNumber'] = instance.debitAccountNumber;
  }
  if (instance.debitAccountCurrency != null) {
    json['debitAccountCurrency'] = instance.debitAccountCurrency;
  }
  if (instance.description != null) json['description'] = instance.description;
  if (instance.addInfo != null) json['addInfo'] = instance.addInfo;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.hasTrxFee != null) json['hasTrxFee'] = instance.hasTrxFee;
  if (instance.trxFee != null) json['trxFee'] = instance.trxFee;
  if (instance.hasPaymentFee != null) {
    json['hasPaymentFee'] = instance.hasPaymentFee;
  }
  if (instance.paymentFee != null) json['paymentFee'] = instance.paymentFee;
  if (instance.accountName != null) json['accountName'] = instance.accountName;
  if (instance.hasBankTrxFee != null) {
    json['hasBankTrxFee'] = instance.hasBankTrxFee;
  }
  if (instance.bankTrxFee != null) json['bankTrxFee'] = instance.bankTrxFee;
  if (instance.percent != null) json['percent'] = instance.percent;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.tranId != null) json['tranId'] = instance.tranId;
  if (instance.tranDate != null) json['tranDate'] = instance.tranDate;
  if (instance.tranStatus != null) json['tranStatus'] = instance.tranStatus;
  if (instance.count != null) json['count'] = instance.count;
  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.bankName != null) json['bankName'] = instance.bankName;
  if (instance.number != null) json['number'] = instance.number;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.shortName != null) json['shortName'] = instance.shortName;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.isVerified != null) json['isVerified'] = instance.isVerified;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.icon != null) json['icon'] = instance.icon;
  if (instance.business != null) json['business'] = instance.business;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.businessName != null) {
    json['businessName'] = instance.businessName;
  }
  if (instance.regUser != null) json['regUser'] = instance.regUser;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;

  return json;
}
