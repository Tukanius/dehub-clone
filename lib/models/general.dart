part '../parts/general.dart';

class General {
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

  General({
    this.provinces,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.districts,
    this.provinceId,
    this.khoroos,
    this.districtId,
    this.bankAccounts,
    this.businessId,
    this.bankName,
    this.number,
    this.currency,
    this.isDefault,
    this.isVerified,
    this.isActive,
    this.icon,
    this.balance,
    this.staffs,
    this.lastName,
    this.firstName,
    this.networks,
    this.profileName,
    this.businessType,
    this.discountTypes,
    this.code,
    this.symbol,
    this.invoiceHistoryTypes,
    this.invoiceTypes,
    this.invoicePaymentStatus,
    this.color,
    this.invoiceStatus,
    this.itemStatus,
    this.types,
    this.numberUnits,
    this.value,
    this.orderConfirmTerms,
    this.overDueStatus,
    this.paymentMethod,
    this.paymentTermRules,
    this.perTypes,
    this.text,
    this.priceChangeTypes,
    this.priceEndTypes,
    this.returnTypes,
    this.transactionTypes,
    this.unitConvertTypes,
    this.unitSpaceLabels,
    this.unitWeightLabels,
  });

  static $fromJson(Map<String, dynamic> json) => _$GeneralFromJson(json);

  factory General.fromJson(Map<String, dynamic> json) =>
      _$GeneralFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralToJson(this);
}
