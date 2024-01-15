part '../parts/finance.dart';

class Finance {
  int? count;
  List<Finance>? rows;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? partnerId;
  String? profileName;
  String? businessRef;
  String? partnerRef;
  String? email;
  String? password;
  String? accessToken;
  String? parentRefCode;
  double? invCount;
  String? refCode;
  String? type;
  String? invId;
  String? invRefCode;
  String? requestedBusinessId;
  double? requestedBusinessSubLimit;
  String? requestedUserId;
  double? responsePeriod;
  DateTime? responseDate;
  String? requestStatus;
  String? programId;
  String? productId;
  String? productType;
  double? requestedAmount;
  String? currency;
  bool? finAmountAcceptable;
  double? finMinAmount;
  double? finMaxAmount;
  bool? balanceAcceptable;
  double? minInvBalance;
  bool? tenorAcceptable;
  double? minTenor;
  double? maxTenor;
  double? calculatedFeePercent;
  double? calculatedFeeAmount;
  double? scfFee;
  double? scfFeeAmount;
  double? trxFee;
  double? appFee;
  double? disbursementFee;
  double? totalScfFeePercent;
  double? totalScfFeeAmount;
  String? feeRule;
  bool? feeAcceptable;
  double? minFeeAmount;
  double? maxFeeAmount;
  DateTime? repaymentDate;
  bool? recourseTerm;
  DateTime? recourseDate;
  DateTime? restrictDate;
  DateTime? sentDate;
  double? penaltyPercent;
  String? penaltyType;
  String? repaymentRule;
  double? invConfirmedDays;
  bool? daysAcceptable;
  double? minDays;
  double? maxDays;
  bool? overdueStatusAcceptable;
  String? invOverdueStatus;
  String? requestedBusinessAccId;
  String? receiverBusinessAccId;
  bool? isBankApproved;
  double? bankFeeAmount;
  bool? suppAcceptable;
  bool? buyerAcceptable;
  String? invSenderUserId;
  double? invConfirmedAmount;
  double? invPaidAmount;
  double? invAmountToPay;
  String? invReceiverBusinessId;
  String? invReceiverBusinessRegNumber;
  DateTime? invPaymentDate;
  DateTime? paymentDate;
  String? invConfirmedUserId;
  String? fundingInstructionStatus;
  String? invStatus;
  DateTime? invCreatedAt;
  DateTime? invConfirmedDate;
  String? invPaymentStatus;
  String? invPaymentTermId;
  String? invPaymentTermConfigType;
  String? invPaymentTermDesc;
  DateTime? respondedDate;
  String? respondedUserId;
  bool? isDisbursed;
  DateTime? toDisburseDate;
  DateTime? disbursedDate;
  double? repaymentAmount;
  String? repaymentInvId;
  bool? isApproved;
  double? approvedAmount;
  bool? isResponded;
  String? respondDesc;
  DateTime? interestStartDate;
  bool? minAmountAcceptable;
  bool? maxAmountAcceptable;
  double? remainingDays;
  Finance? program;
  Finance? respondedUser;
  Finance? requestedBusiness;
  Finance? requestedFinUser;
  Finance? partner;
  Finance? product;
  Finance? invConfirmedUser;
  String? lastName;
  String? avatar;
  String? firstName;
  String? businessName;
  Finance? invReceiverBusiness;
  Finance? requestedUser;
  Finance? repaymentInv;
  Finance? invSenderUser;
  Finance? payerBusiness;
  Finance? payerAcc;
  String? name;
  double? amountToPay;
  String? overdueStatus;
  String? repaymentStatus;
  double? paidAmount;
  String? regNumber;
  Finance? requestedBusinessAcc;
  Finance? invReceiverBusinessAcc;
  Finance? receiverBusinessAcc;
  Finance? finUser;
  String? number;
  String? programStatus;
  String? username;
  double? availableAmount;
  double? programLimit;
  Finance? receiverBusiness;
  Finance? senderBusiness;
  String? invoiceStatus;
  DateTime? confirmedDate;
  Finance? senderUser;
  Finance? confirmedUser;
  double? confirmedAmount;
  String? paymentTermDesc;
  Finance? senderFinUser;
  Finance? receiverFinUser;
  Finance? senderAcc;
  Finance? receiverAcc;
  String? shortName;
  String? bankName;
  List<Finance>? invoices;

  Finance({
    this.invoices,
    this.bankName,
    this.shortName,
    this.senderFinUser,
    this.receiverFinUser,
    this.senderAcc,
    this.receiverAcc,
    this.paymentTermDesc,
    this.confirmedAmount,
    this.confirmedUser,
    this.sentDate,
    this.senderUser,
    this.paymentDate,
    this.confirmedDate,
    this.invoiceStatus,
    this.receiverBusiness,
    this.senderBusiness,
    this.availableAmount,
    this.programLimit,
    this.programStatus,
    this.username,
    this.invReceiverBusinessAcc,
    this.finUser,
    this.requestedBusinessAcc,
    this.receiverBusinessAcc,
    this.regNumber,
    this.paidAmount,
    this.repaymentStatus,
    this.overdueStatus,
    this.payerAcc,
    this.amountToPay,
    this.payerBusiness,
    this.name,
    this.requestedFinUser,
    this.invSenderUser,
    this.parentRefCode,
    this.invCount,
    this.refCode,
    this.type,
    this.invId,
    this.invRefCode,
    this.requestedBusinessId,
    this.requestedBusinessSubLimit,
    this.requestedUserId,
    this.responsePeriod,
    this.responseDate,
    this.requestStatus,
    this.programId,
    this.productId,
    this.productType,
    this.requestedAmount,
    this.currency,
    this.finAmountAcceptable,
    this.finMinAmount,
    this.finMaxAmount,
    this.balanceAcceptable,
    this.minInvBalance,
    this.tenorAcceptable,
    this.minTenor,
    this.maxTenor,
    this.calculatedFeePercent,
    this.calculatedFeeAmount,
    this.scfFee,
    this.scfFeeAmount,
    this.trxFee,
    this.appFee,
    this.disbursementFee,
    this.totalScfFeePercent,
    this.totalScfFeeAmount,
    this.feeRule,
    this.feeAcceptable,
    this.minFeeAmount,
    this.maxFeeAmount,
    this.repaymentDate,
    this.recourseTerm,
    this.recourseDate,
    this.restrictDate,
    this.penaltyPercent,
    this.number,
    this.penaltyType,
    this.repaymentRule,
    this.invConfirmedDays,
    this.daysAcceptable,
    this.minDays,
    this.maxDays,
    this.overdueStatusAcceptable,
    this.invOverdueStatus,
    this.requestedBusinessAccId,
    this.receiverBusinessAccId,
    this.isBankApproved,
    this.bankFeeAmount,
    this.suppAcceptable,
    this.buyerAcceptable,
    this.invSenderUserId,
    this.invConfirmedAmount,
    this.invPaidAmount,
    this.invAmountToPay,
    this.invReceiverBusinessId,
    this.invReceiverBusinessRegNumber,
    this.invPaymentDate,
    this.invConfirmedUserId,
    this.fundingInstructionStatus,
    this.invStatus,
    this.invCreatedAt,
    this.invConfirmedDate,
    this.invPaymentStatus,
    this.invPaymentTermId,
    this.invPaymentTermConfigType,
    this.invPaymentTermDesc,
    this.respondedDate,
    this.respondedUserId,
    this.isDisbursed,
    this.toDisburseDate,
    this.disbursedDate,
    this.repaymentAmount,
    this.repaymentInvId,
    this.isApproved,
    this.approvedAmount,
    this.isResponded,
    this.respondDesc,
    this.interestStartDate,
    this.minAmountAcceptable,
    this.maxAmountAcceptable,
    this.remainingDays,
    this.program,
    this.respondedUser,
    this.requestedBusiness,
    this.partner,
    this.product,
    this.invConfirmedUser,
    this.lastName,
    this.avatar,
    this.firstName,
    this.businessName,
    this.invReceiverBusiness,
    this.requestedUser,
    this.repaymentInv,
    this.profileName,
    this.accessToken,
    this.businessRef,
    this.partnerRef,
    this.email,
    this.password,
    this.count,
    this.rows,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.partnerId,
  });

  static $fromJson(Map<String, dynamic> json) => _$FinanceFromJson(json);
  factory Finance.fromJson(Map<String, dynamic> json) =>
      _$FinanceFromJson(json);
  Map<String, dynamic> toJson() => _$FinanceToJson(this);
}
