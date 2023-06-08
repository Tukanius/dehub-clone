import 'package:intl/intl.dart';
import 'package:moment_dart/moment_dart.dart';
part '../parts/invoice.dart';

class Invoice {
  int? count;
  List<Invoice>? rows;
  String? id;
  String? createdAt;
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
  String? paymentDate;
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
  String? overDueStatus;
  String? sentDate;
  String? description;
  String? confirmedUserId;
  String? confirmedDate;
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
  String? paymentDay;
  bool? isMain;
  bool? isActive;
  bool? isOpen;
  Invoice? receiverFinUser;
  Invoice? receiverBranch;
  Invoice? receiverAcc;
  List<Invoice>? invoiceLines;
  String? invoiceId;
  String? unitVariantId;
  double? price;
  double? quantity;
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
  String? priceStartDate;
  Invoice? unit;
  String? convertType;
  int? convertValue;
  List<Invoice>? attachments;

  String? method;
  String? creditAccountId;
  double? amount;

  String getPostDate() {
    return Moment.parse(DateFormat("yyyy-MM-dd")
            .parseUTC(createdAt!)
            .toLocal()
            .toIso8601String())
        .format("yyyy-MM-dd");
  }

  String getsentDate() {
    return Moment.parse(DateFormat("yyyy-MM-ddTHH:mm:ssZ")
            .parseUTC(createdAt!)
            .toLocal()
            .toIso8601String())
        .format("yyyy-MM-dd HH:mm");
  }

  String getPaymentDate() {
    return Moment.parse(DateFormat("yyyy-MM-ddTHH:mm:ssZ")
            .parseUTC(paymentDate!)
            .toLocal()
            .toIso8601String())
        .format('yyyy-MM-dd HH:mm');
  }

  Invoice({
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
    this.overDueStatus,
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
    this.unitVariantId,
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
