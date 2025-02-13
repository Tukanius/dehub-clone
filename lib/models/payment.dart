import 'package:dehub/models/stats.dart';

part '../parts/payment.dart';

class Payment {
  int? count;
  List<Payment>? rows;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? partnerId;
  String? businessId;
  String? regUserId;
  String? bankName;
  String? number;
  String? name;
  String? shortName;
  String? currency;
  bool? isDefault;
  bool? isVerified;
  bool? isActive;
  String? icon;
  Payment? business;
  String? regNumber;
  String? refCode;
  String? profileName;
  Payment? partner;
  String? businessName;
  Payment? regUser;
  String? avatar;
  String? firstName;
  String? lastName;
  String? accountName;
  String? type;
  String? transactionStatus;
  String? paymentId;
  String? paymentRefCode;
  String? paymentMethod;
  String? objectType;
  String? objectId;
  String? invoiceRefCode;
  String? payerUserId;
  String? payerBusinessId;
  String? typayerBusinessRegNumbere;
  String? creditAccountId;
  String? creditAccountBank;
  String? creditAccountName;
  String? creditAccountNumber;
  String? creditAccountCurrency;
  String? receiverBusinessId;
  String? debitAccountId;
  String? debitAccountBank;
  String? debitAccountName;
  String? debitAccountNumber;
  String? debitAccountCurrency;
  String? description;
  String? addInfo;
  double? amount;
  bool? hasTrxFee;
  double? trxFee;
  bool? hasPaymentFee;
  double? paymentFee;
  bool? hasBankTrxFee;
  double? bankTrxFee;
  double? totalAmount;
  String? tranId;
  String? tranDate;
  String? tranStatus;
  String? inOutType;
  DateTime? header;
  List<Payment>? values;
  String? requestId;
  String? clientId;
  String? responseType;
  String? redirectUri;
  Uri? url;
  List<Payment>? byInterval;
  List<Payment>? revenueStructure;
  double? percent;
  String? date; //Must be string
  int? incomeAmount;
  int? outcomeAmount;
  Payment? payerUser;
  Payment? payerBusiness;
  Payment? account;
  List<Stats>? numberSurvey;
  String? image;

  int? recNum;
  String? drOrCr;
  double? tranAmount;
  String? tranDesc;
  DateTime? tranPostedDate;
  String? tranCrnCode;
  int? exchRate;
  String? balance;
  String? accName;
  String? accNum;

  Payment({
    this.recNum,
    this.drOrCr,
    this.tranAmount,
    this.tranDesc,
    this.tranPostedDate,
    this.tranCrnCode,
    this.exchRate,
    this.balance,
    this.accName,
    this.accNum,
    this.image,
    this.numberSurvey,
    this.account,
    this.payerUser,
    this.payerBusiness,
    this.outcomeAmount,
    this.incomeAmount,
    this.date,
    this.percent,
    this.byInterval,
    this.revenueStructure,
    this.requestId,
    this.clientId,
    this.responseType,
    this.redirectUri,
    this.url,
    this.accountName,
    this.header,
    this.values,
    this.inOutType,
    this.type,
    this.transactionStatus,
    this.paymentId,
    this.paymentRefCode,
    this.paymentMethod,
    this.objectType,
    this.objectId,
    this.invoiceRefCode,
    this.payerUserId,
    this.payerBusinessId,
    this.typayerBusinessRegNumbere,
    this.creditAccountId,
    this.creditAccountBank,
    this.creditAccountName,
    this.creditAccountNumber,
    this.creditAccountCurrency,
    this.receiverBusinessId,
    this.debitAccountId,
    this.debitAccountBank,
    this.debitAccountName,
    this.debitAccountNumber,
    this.debitAccountCurrency,
    this.description,
    this.addInfo,
    this.amount,
    this.hasTrxFee,
    this.trxFee,
    this.hasPaymentFee,
    this.paymentFee,
    this.hasBankTrxFee,
    this.bankTrxFee,
    this.totalAmount,
    this.tranId,
    this.tranDate,
    this.tranStatus,
    this.count,
    this.rows,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.partnerId,
    this.businessId,
    this.regUserId,
    this.bankName,
    this.number,
    this.name,
    this.shortName,
    this.currency,
    this.isDefault,
    this.isVerified,
    this.isActive,
    this.icon,
    this.business,
    this.regNumber,
    this.refCode,
    this.profileName,
    this.partner,
    this.businessName,
    this.regUser,
    this.avatar,
    this.firstName,
    this.lastName,
  });

  static $fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
