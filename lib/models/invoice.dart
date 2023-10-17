import 'package:dehub/models/qpay-urls.dart';
part '../parts/invoice.dart';

class Invoice {
  int? count;
  List<Invoice>? rows;
  String? id;
  DateTime? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? refCode;
  String? senderUserId;
  String? senderBusinessId;
  String? senderFinUserId;
  String? senderBranchId;
  String? senderAccId;
  String? salesOrderId;
  String? purchaseOrderId;
  String? paymentTermId;
  DateTime? paymentDate;
  String? receiverBusinessId;
  String? receiverAccId;
  String? receiverAddress;
  String? receiverBranchId;
  String? receiverFinUserId;
  double? shippingAmount;
  double? vatAmount;
  double? taxAmount;
  String? discountType;
  double? discountValue;
  double? discountAmount;
  double? itemsTotal;
  double? totalAmount;
  double? confirmedAmount;
  double? paidAmount;
  double? amountToPay;
  String? paymentStatus;
  String? invoiceStatus;
  String? overdueStatus;
  DateTime? sentDate;
  String? description;
  String? confirmedUserId;
  DateTime? confirmedDate;
  String? respondText;
  String? type;
  Invoice? receiverBusiness;
  String? partnerId;
  String? regNumber;
  String? stateRegNum;
  String? partnerName;
  String? partnerNameEng;
  bool? isVatPayer;
  String? partnerEmail;
  String? partnerPhone;
  String? profileName;
  String? profileNameEng;
  String? logo;
  String? profileInfo;
  Invoice? partner;
  String? businessName;
  String? businessNameEng;
  Invoice? senderUser;
  String? lastName;
  String? firstName;
  String? avatar;
  Invoice? confirmedUser;
  Invoice? salesOrder;
  Invoice? purchaseOrder;
  int? remainingDays;
  Invoice? senderBusiness;
  Invoice? senderFinUser;
  Invoice? senderBranch;
  String? name;
  String? nameEng;
  String? branchStatus;
  String? provinceId;
  String? districtId;
  String? khorooId;
  String? khoroolol;
  String? khotkhonBair;
  String? khashaaDavkhar;
  String? khaalgaDugaar;
  String? branchAddress;
  double? locationLat;
  double? locationLng;
  Invoice? senderAcc;
  String? bankName;
  String? number;
  String? currency;
  String? icon;
  Invoice? paymentTerm;
  String? modifiedUserId;
  String? termRule;
  String? orderConfirmTerm;
  int? expireDayCount;
  String? month;
  int? paymentDay;
  bool? isMain;
  bool? isActive;
  bool? isOpen;
  Invoice? receiverFinUser;
  Invoice? receiverBranch;
  Invoice? receiverAcc;
  List<Invoice>? invoiceLines;
  String? invoiceId;
  String? variantId;
  double? price;
  int? quantity;
  bool? hasVat;
  double? vatPercent;
  bool? hasTax;
  double? taxPercent;
  double? lineTotalAmount;
  String? skuCode;
  String? barCode;
  String? erpCode;
  String? nameMon;
  String? nameBill;
  String? nameWeb;
  String? nameApp;
  String? image;
  DateTime? priceStartDate;
  String? unit;
  String? convertType;
  int? convertValue;
  List<Invoice>? attachments;
  String? method;
  String? creditAccountId;
  double? amount;
  String? unitName;
  bool? send;
  List<Invoice>? lines;
  String? phone;
  String? businessAddress;
  Invoice? staff;

  String? category;
  String? supplier;
  String? brand;
  List<Invoice>? optionValues;
  String? optionId;

  String? invoiceRefCode;
  String? creditAccountBank;
  String? creditAccountName;
  String? creditAccountNumber;
  String? creditAccountCurrency;
  String? debitAccountId;
  String? debitAccountBank;
  String? debitAccountName;
  String? debitAccountNumber;
  String? debitAccountCurrency;

  String? qr_image;

  List<Urls>? urls;
  bool? confirm;

  String? salesCode;
  String? purchaseCode;
  List<Invoice>? additionalLines;
  String? configType;

  Invoice({
    this.configType,
    this.additionalLines,
    this.salesCode,
    this.purchaseCode,
    this.confirm,
    this.urls,
    this.qr_image,
    this.invoiceRefCode,
    this.creditAccountBank,
    this.creditAccountName,
    this.creditAccountNumber,
    this.creditAccountCurrency,
    this.debitAccountId,
    this.debitAccountBank,
    this.debitAccountName,
    this.debitAccountNumber,
    this.debitAccountCurrency,
    this.category,
    this.supplier,
    this.brand,
    this.optionValues,
    this.optionId,
    this.phone,
    this.businessAddress,
    this.staff,
    this.unitName,
    this.send,
    this.lines,
    this.method,
    this.creditAccountId,
    this.amount,
    this.count,
    this.rows,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.refCode,
    this.senderUserId,
    this.senderBusinessId,
    this.senderFinUserId,
    this.senderBranchId,
    this.senderAccId,
    this.salesOrderId,
    this.purchaseOrderId,
    this.paymentTermId,
    this.paymentDate,
    this.receiverBusinessId,
    this.receiverAccId,
    this.receiverAddress,
    this.receiverBranchId,
    this.receiverFinUserId,
    this.shippingAmount,
    this.vatAmount,
    this.taxAmount,
    this.discountType,
    this.discountValue,
    this.discountAmount,
    this.itemsTotal,
    this.totalAmount,
    this.confirmedAmount,
    this.paidAmount,
    this.amountToPay,
    this.paymentStatus,
    this.invoiceStatus,
    this.overdueStatus,
    this.sentDate,
    this.description,
    this.confirmedUserId,
    this.confirmedDate,
    this.respondText,
    this.type,
    this.receiverBusiness,
    this.partnerId,
    this.regNumber,
    this.stateRegNum,
    this.partnerName,
    this.partnerNameEng,
    this.isVatPayer,
    this.partnerEmail,
    this.partnerPhone,
    this.profileName,
    this.profileNameEng,
    this.logo,
    this.profileInfo,
    this.partner,
    this.businessName,
    this.businessNameEng,
    this.senderUser,
    this.lastName,
    this.firstName,
    this.avatar,
    this.confirmedUser,
    this.salesOrder,
    this.purchaseOrder,
    this.remainingDays,
    this.senderBusiness,
    this.senderFinUser,
    this.senderBranch,
    this.name,
    this.nameEng,
    this.branchStatus,
    this.provinceId,
    this.districtId,
    this.khorooId,
    this.khoroolol,
    this.khotkhonBair,
    this.khashaaDavkhar,
    this.khaalgaDugaar,
    this.branchAddress,
    this.locationLat,
    this.locationLng,
    this.senderAcc,
    this.bankName,
    this.number,
    this.currency,
    this.icon,
    this.paymentTerm,
    this.modifiedUserId,
    this.termRule,
    this.orderConfirmTerm,
    this.expireDayCount,
    this.month,
    this.paymentDay,
    this.isMain,
    this.isActive,
    this.isOpen,
    this.receiverFinUser,
    this.receiverBranch,
    this.receiverAcc,
    this.invoiceLines,
    this.invoiceId,
    this.variantId,
    this.price,
    this.quantity,
    this.hasVat,
    this.vatPercent,
    this.hasTax,
    this.taxPercent,
    this.lineTotalAmount,
    this.skuCode,
    this.barCode,
    this.erpCode,
    this.nameMon,
    this.nameBill,
    this.nameWeb,
    this.nameApp,
    this.image,
    this.priceStartDate,
    this.unit,
    this.convertType,
    this.convertValue,
    this.attachments,
  });

  static $fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}
