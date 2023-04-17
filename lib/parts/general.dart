part of "../models/general.dart";

General _$GeneralFromJson(Map<String, dynamic> json) {
  List<General>? provinces;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  List<General>? districts;
  String? provinceId;
  List<General>? khoroos;
  String? districtId;
  List<General>? bankAccounts;
  String? businessId;
  String? bankName;
  String? number;
  String? currency;
  bool? isDefault;
  bool? isVerified;
  bool? isActive;
  String? icon;
  String? balance;
  List<General>? staffs;
  String? lastName;
  String? firstName;
  List<General>? networks;
  String? profileName;
  List<General>? businessType;
  List<General>? discountTypes;
  String? code;
  String? symbol;
  List<General>? invoiceHistoryTypes;
  List<General>? invoiceTypes;
  List<General>? invoicePaymentStatus;
  String? color;
  List<General>? invoiceStatus;
  List<General>? itemStatus;
  List<General>? types;
  List<General>? numberUnits;
  String? value;
  List<General>? orderConfirmTerms;
  List<General>? overDueStatus;
  List<General>? paymentMethod;
  List<General>? paymentTermRules;
  List<General>? perTypes;
  String? text;
  List<General>? priceChangeTypes;
  List<General>? priceEndTypes;
  List<General>? returnTypes;
  List<General>? transactionTypes;
  List<General>? unitConvertTypes;
  List<General>? unitSpaceLabels;
  List<General>? unitWeightLabels;

  if (json['provinces'] != null)
    provinces =
        (json['provinces'] as List).map((e) => General.fromJson(e)).toList();
  if (json['districts'] != null)
    districts =
        (json['districts'] as List).map((e) => General.fromJson(e)).toList();
  if (json['khoroos'] != null)
    khoroos =
        (json['khoroos'] as List).map((e) => General.fromJson(e)).toList();
  if (json['bankAccounts'] != null)
    bankAccounts =
        (json['bankAccounts'] as List).map((e) => General.fromJson(e)).toList();
  if (json['staffs'] != null)
    staffs = (json['staffs'] as List).map((e) => General.fromJson(e)).toList();
  if (json['networks'] != null)
    networks =
        (json['networks'] as List).map((e) => General.fromJson(e)).toList();
  if (json['businessType'] != null)
    businessType =
        (json['businessType'] as List).map((e) => General.fromJson(e)).toList();
  if (json['discountTypes'] != null)
    discountTypes = (json['discountTypes'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['invoiceHistoryTypes'] != null)
    invoiceHistoryTypes = (json['invoiceHistoryTypes'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['invoiceTypes'] != null)
    invoiceTypes =
        (json['invoiceTypes'] as List).map((e) => General.fromJson(e)).toList();
  if (json['invoicePaymentStatus'] != null)
    invoicePaymentStatus = (json['invoicePaymentStatus'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['itemStatus'] != null)
    itemStatus =
        (json['itemStatus'] as List).map((e) => General.fromJson(e)).toList();
  if (json['types'] != null)
    types = (json['types'] as List).map((e) => General.fromJson(e)).toList();
  if (json['numberUnits'] != null)
    numberUnits =
        (json['numberUnits'] as List).map((e) => General.fromJson(e)).toList();
  if (json['orderConfirmTerms'] != null)
    orderConfirmTerms = (json['orderConfirmTerms'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['overDueStatus'] != null)
    overDueStatus = (json['overDueStatus'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['paymentMethod'] != null)
    paymentMethod = (json['paymentMethod'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['paymentTermRules'] != null)
    paymentTermRules = (json['paymentTermRules'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['priceChangeTypes'] != null)
    priceChangeTypes = (json['priceChangeTypes'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['priceEndTypes'] != null)
    priceEndTypes = (json['priceEndTypes'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['returnTypes'] != null)
    returnTypes =
        (json['returnTypes'] as List).map((e) => General.fromJson(e)).toList();
  if (json['transactionTypes'] != null)
    transactionTypes = (json['transactionTypes'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['unitConvertTypes'] != null)
    unitConvertTypes = (json['unitConvertTypes'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['unitSpaceLabels'] != null)
    unitSpaceLabels = (json['unitSpaceLabels'] as List)
        .map((e) => General.fromJson(e))
        .toList();
  if (json['unitWeightLabels'] != null)
    unitWeightLabels = (json['unitWeightLabels'] as List)
        .map((e) => General.fromJson(e))
        .toList();

  return General(
    provinces: provinces,
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    name: name,
    districts: districts,
    provinceId: provinceId,
    khoroos: khoroos,
    districtId: districtId,
    bankAccounts: bankAccounts,
    businessId: businessId,
    bankName: bankName,
    number: number,
    currency: currency,
    isDefault: isDefault,
    isVerified: isVerified,
    isActive: isActive,
    icon: icon,
    balance: balance,
    staffs: staffs,
    lastName: lastName,
    firstName: firstName,
    networks: networks,
    profileName: profileName,
    businessType: businessType,
    discountTypes: discountTypes,
    code: code,
    symbol: symbol,
    invoiceHistoryTypes: invoiceHistoryTypes,
    invoiceTypes: invoiceTypes,
    invoicePaymentStatus: invoicePaymentStatus,
    color: color,
    invoiceStatus: invoiceStatus,
    itemStatus: itemStatus,
    types: types,
    numberUnits: numberUnits,
    value: value,
    orderConfirmTerms: orderConfirmTerms,
    overDueStatus: overDueStatus,
    paymentMethod: paymentMethod,
    paymentTermRules: paymentTermRules,
    perTypes: perTypes,
    text: text,
    priceChangeTypes: priceChangeTypes,
    priceEndTypes: priceEndTypes,
    returnTypes: returnTypes,
    transactionTypes: transactionTypes,
    unitConvertTypes: unitConvertTypes,
    unitSpaceLabels: unitSpaceLabels,
    unitWeightLabels: unitWeightLabels,
  );
}

Map<String, dynamic> _$GeneralToJson(General instance) {
  Map<String, dynamic> json = {};

  if (instance.provinces != null) json['provinces'] = instance.provinces;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.districts != null) json['districts'] = instance.districts;
  if (instance.provinceId != null) json['provinceId'] = instance.provinceId;
  if (instance.khoroos != null) json['khoroos'] = instance.khoroos;
  if (instance.districtId != null) json['districtId'] = instance.districtId;
  if (instance.bankAccounts != null)
    json['bankAccounts'] = instance.bankAccounts;
  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.bankName != null) json['bankName'] = instance.bankName;
  if (instance.number != null) json['number'] = instance.number;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.isVerified != null) json['isVerified'] = instance.isVerified;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.icon != null) json['icon'] = instance.icon;
  if (instance.balance != null) json['balance'] = instance.balance;
  if (instance.staffs != null) json['staffs'] = instance.staffs;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.networks != null) json['networks'] = instance.networks;
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.businessType != null)
    json['businessType'] = instance.businessType;
  if (instance.discountTypes != null)
    json['discountTypes'] = instance.discountTypes;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.symbol != null) json['symbol'] = instance.symbol;
  if (instance.invoiceHistoryTypes != null)
    json['invoiceHistoryTypes'] = instance.invoiceHistoryTypes;
  if (instance.invoiceTypes != null)
    json['invoiceTypes'] = instance.invoiceTypes;
  if (instance.invoicePaymentStatus != null)
    json['invoicePaymentStatus'] = instance.invoicePaymentStatus;
  if (instance.color != null) json['color'] = instance.color;
  if (instance.invoiceStatus != null)
    json['invoiceStatus'] = instance.invoiceStatus;
  if (instance.itemStatus != null) json['itemStatus'] = instance.itemStatus;
  if (instance.types != null) json['types'] = instance.types;
  if (instance.numberUnits != null) json['numberUnits'] = instance.numberUnits;
  if (instance.value != null) json['value'] = instance.value;
  if (instance.orderConfirmTerms != null)
    json['orderConfirmTerms'] = instance.orderConfirmTerms;
  if (instance.overDueStatus != null)
    json['overDueStatus'] = instance.overDueStatus;
  if (instance.paymentMethod != null)
    json['paymentMethod'] = instance.paymentMethod;
  if (instance.paymentTermRules != null)
    json['paymentTermRules'] = instance.paymentTermRules;
  if (instance.text != null) json['text'] = instance.text;
  if (instance.priceChangeTypes != null)
    json['priceChangeTypes'] = instance.priceChangeTypes;
  if (instance.priceEndTypes != null)
    json['priceEndTypes'] = instance.priceEndTypes;
  if (instance.returnTypes != null) json['returnTypes'] = instance.returnTypes;
  if (instance.transactionTypes != null)
    json['transactionTypes'] = instance.transactionTypes;
  if (instance.unitConvertTypes != null)
    json['unitConvertTypes'] = instance.unitConvertTypes;
  if (instance.unitSpaceLabels != null)
    json['unitSpaceLabels'] = instance.unitSpaceLabels;
  if (instance.unitWeightLabels != null)
    json['unitWeightLabels'] = instance.unitWeightLabels;

  return json;
}
