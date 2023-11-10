import 'package:file_picker/file_picker.dart';
part '../parts/order.dart';

class Order {
  int? count;
  List<Order>? rows;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? refCode;
  String? type;
  bool? isDefault;
  String? businessStatus;
  String? profileName;
  String? profileNameEng;
  String? logo;
  String? profileInfo;
  bool? isAnchorBusiness;
  String? partnerId;
  String? regNumber;
  String? partnerName;
  String? partnerNameEng;
  String? partnerEmail;
  String? partnerEmail2;
  String? partnerPhone;
  String? partnerPhone2;
  String? legalEntityType;
  Order? partner;
  String? businessName;
  Order? receiverBrach;
  Order? receiverBranch;
  String? name;
  String? nameEng;
  Order? receiverStaff;
  Order? receiverFinStaff;
  String? avatar;
  String? lastName;
  String? firstName;
  String? email;
  String? phone;
  Order? region;
  Order? direction;
  String? category;
  Order? priority;
  Order? staff;
  String? networkStatus;
  String? branchStatus;
  bool? isBuyer;
  bool? isSupplier;
  DateTime? deliveryDate;
  String? province;
  String? district;
  String? khoroo;
  String? khoroolol;
  String? khotkhonBair;
  String? khashaaDavkhar;
  String? khaalgaDugaar;
  String? branchAddress;
  String? businessId;
  String? receiverBranchId;
  String? deliveryType;
  String? receiverStaffId;
  List<Order>? lines;
  List<FilePickerResult>? attachments;
  List<Order>? additionalLines;
  String? variantId;
  String? discountType;
  double? discountValue;
  int? quantity;
  String? unit;
  double? price;
  String? senderNote;
  String? senderAdditionalNote;
  double? shippingAmount;
  String? url;
  String? description;
  bool? toReview;
  bool? send;
  String? skuCode;
  String? barCode;
  String? erpCode;
  String? nameMon;
  String? nameBill;
  String? nameWeb;
  String? nameApp;
  String? image;
  String? supplier;
  String? brand;
  DateTime? priceStartDate;
  bool? hasVat;
  bool? hasTax;
  double? vatAmount;
  double? taxAmount;
  List<Order>? optionValues;
  String? packageType;
  String? purchaseCode;
  String? salesCode;
  String? orderStatus;
  String? orderedUserId;
  String? senderBusinessId;
  String? receiverBusinessId;
  String? paymentTermId;
  String? createdType;
  double? itemTypeCount;
  double? totalItemCount;
  double? lineTotalAmount;
  double? lineVatAmount;
  double? lineTaxAmount;
  double? lineTotalDiscountAmount;
  double? orderAmount;
  double? totalAmount;
  double? paidAmount;
  double? amountToPay;
  String? paymentStatus;
  String? reviewedUserId;
  DateTime? reviewedDate;
  String? canceledUserId;
  DateTime? canceledDate;
  String? respondedUserId;
  DateTime? respondedDate;
  String? invoiceId;
  Order? receiverBusiness;
  Order? senderBusiness;
  Order? orderedUser;
  Order? reviewedUser;
  bool? approve;
  bool? review;
  int? onDeliveryQuantity;
  int? warehouseQuantity;
  Order? paymentTerm;
  bool? isVatPayer;
  List<Order>? receiverBranches;
  String? regUserId;
  double? locationLat;
  double? locationLng;
  String? warehouseId;
  String? staffId;
  DateTime? loadingDate;
  String? pullSheetStatus;
  DateTime? startedDate;
  DateTime? startDate;
  bool? isPaused;
  DateTime? pausedDate;
  DateTime? proceededDate;
  double? pausedDuration;
  DateTime? endedDate;
  DateTime? dispatchedDate;
  Order? warehouse;
  String? warehouseUserId;
  Order? warehouseUser;
  Order? regUser;
  String? warehouseStatus;
  List<Order>? deliveryNotes;
  List<Order>? pullSheetLines;
  String? orderId;
  String? pullSheetId;
  String? variantParentId;
  String? optionValue;
  String? baseUnitId;
  String? baseUnit;
  String? unitId;
  String? unitConvertType;
  int? unitConvertValue;
  int? baseUnitQuantity;
  bool? hasAdditionalUnit;
  String? additionalUnit;
  double? additionalUnitQuantity;
  String? deliveryNoteId;
  int? totalLineType;
  int? totalLineQuantity;
  String? pullSheetLineId;
  int? confirmedQuantity;
  String? deliveryNoteStatus;
  String? condition;
  String? text;
  Order? user;
  Order? supplierStaff;
  Order? buyerStaff;
  String? lineId;
  bool? isConfirmed;
  List<Order>? receiptLines;
  Order? supplierBusiness;
  Order? buyerBusiness;
  Order? deliveryStaff;
  String? code;
  String? configType;

  bool? isEnded;
  DateTime? deliveredDate;
  Order? respondedUser;
  bool? isBuyerConfirmed;
  bool? isSupplierConfirmed;
  Order? business;
  Order? receipt;
  Order? order;

  Order? deliveryNote;

  Order({
    this.deliveryNote,
    this.order,
    this.receipt,
    this.business,
    this.isSupplierConfirmed,
    this.isBuyerConfirmed,
    this.respondedUser,
    this.deliveredDate,
    this.isEnded,
    this.configType,
    this.code,
    this.startDate,
    this.deliveryStaff,
    this.supplierBusiness,
    this.buyerBusiness,
    this.receiptLines,
    this.isConfirmed,
    this.lineId,
    this.supplierStaff,
    this.buyerStaff,
    this.user,
    this.text,
    this.condition,
    this.deliveryNoteStatus,
    this.pullSheetLineId,
    this.confirmedQuantity,
    this.regUser,
    this.warehouseStatus,
    this.deliveryNotes,
    this.pullSheetLines,
    this.orderId,
    this.pullSheetId,
    this.variantParentId,
    this.optionValue,
    this.baseUnitId,
    this.baseUnit,
    this.unitId,
    this.unitConvertType,
    this.unitConvertValue,
    this.baseUnitQuantity,
    this.hasAdditionalUnit,
    this.additionalUnit,
    this.additionalUnitQuantity,
    this.deliveryNoteId,
    this.totalLineType,
    this.totalLineQuantity,
    this.warehouseId,
    this.staffId,
    this.loadingDate,
    this.pullSheetStatus,
    this.startedDate,
    this.isPaused,
    this.pausedDate,
    this.proceededDate,
    this.pausedDuration,
    this.endedDate,
    this.dispatchedDate,
    this.warehouse,
    this.warehouseUserId,
    this.warehouseUser,
    this.receiverBranches,
    this.regUserId,
    this.locationLat,
    this.locationLng,
    this.isVatPayer,
    this.paymentTerm,
    this.onDeliveryQuantity,
    this.warehouseQuantity,
    this.review,
    this.approve,
    this.purchaseCode,
    this.salesCode,
    this.orderStatus,
    this.orderedUserId,
    this.senderBusinessId,
    this.receiverBusinessId,
    this.paymentTermId,
    this.createdType,
    this.itemTypeCount,
    this.totalItemCount,
    this.lineTotalAmount,
    this.lineVatAmount,
    this.lineTaxAmount,
    this.lineTotalDiscountAmount,
    this.orderAmount,
    this.totalAmount,
    this.paidAmount,
    this.amountToPay,
    this.paymentStatus,
    this.reviewedUserId,
    this.reviewedDate,
    this.canceledUserId,
    this.canceledDate,
    this.respondedUserId,
    this.respondedDate,
    this.invoiceId,
    this.receiverBusiness,
    this.senderBusiness,
    this.orderedUser,
    this.reviewedUser,
    this.skuCode,
    this.barCode,
    this.erpCode,
    this.nameMon,
    this.nameBill,
    this.nameWeb,
    this.nameApp,
    this.image,
    this.supplier,
    this.brand,
    this.priceStartDate,
    this.hasVat,
    this.hasTax,
    this.vatAmount,
    this.taxAmount,
    this.optionValues,
    this.packageType,
    this.businessId,
    this.receiverBranchId,
    this.deliveryType,
    this.receiverStaffId,
    this.lines,
    this.attachments,
    this.additionalLines,
    this.variantId,
    this.discountType,
    this.discountValue,
    this.quantity,
    this.unit,
    this.price,
    this.senderNote,
    this.senderAdditionalNote,
    this.shippingAmount,
    this.url,
    this.description,
    this.toReview,
    this.send,
    this.count,
    this.rows,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.refCode,
    this.type,
    this.isDefault,
    this.businessStatus,
    this.profileName,
    this.profileNameEng,
    this.logo,
    this.profileInfo,
    this.isAnchorBusiness,
    this.partnerId,
    this.regNumber,
    this.partnerName,
    this.partnerNameEng,
    this.partnerEmail,
    this.partnerEmail2,
    this.partnerPhone,
    this.partnerPhone2,
    this.legalEntityType,
    this.partner,
    this.businessName,
    this.receiverBranch,
    this.receiverBrach,
    this.name,
    this.nameEng,
    this.receiverStaff,
    this.receiverFinStaff,
    this.avatar,
    this.lastName,
    this.firstName,
    this.email,
    this.phone,
    this.region,
    this.direction,
    this.category,
    this.priority,
    this.staff,
    this.networkStatus,
    this.branchStatus,
    this.isBuyer,
    this.isSupplier,
    this.deliveryDate,
    this.province,
    this.district,
    this.khoroo,
    this.khoroolol,
    this.khotkhonBair,
    this.khashaaDavkhar,
    this.khaalgaDugaar,
    this.branchAddress,
  });

  static $fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
