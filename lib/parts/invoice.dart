part of '../models/invoice.dart';

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
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
  User? confirmedUser;
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
  double? convertValue;
  List<Invoice>? attachments;

  String? method;
  String? creditAccountId;
  double? amount;

  if (json['creditAccountId'] != null)
    creditAccountId = json['creditAccountId'];
  if (json['amount'] != null) amount = double.parse('${json['amount']}');
  if (json['method'] != null) method = json['method'];

  if (json['count'] != null) count = json['count'];
  if (json['rows'] != null)
    rows = (json['rows'] as List).map((e) => Invoice.fromJson(e)).toList();
  if (json['id'] != null) id = json['id'];
  if (json['createdAt'] != null) createdAt = json['createdAt'];
  if (json['updatedAt'] != null) updatedAt = json['updatedAt'];
  if (json['deletedAt'] != null) deletedAt = json['deletedAt'];
  if (json['refCode'] != null) refCode = json['refCode'];
  if (json['senderUserId'] != null) senderUserId = json['senderUserId'];
  if (json['senderBusinessId'] != null)
    senderBusinessId = json['senderBusinessId'];
  if (json['senderFinUserId'] != null)
    senderFinUserId = json['senderFinUserId'];
  if (json['senderBranchId'] != null) senderBranchId = json['senderBranchId'];
  if (json['senderAccId'] != null) senderAccId = json['senderAccId'];
  if (json['salesOrderId'] != null) salesOrderId = json['salesOrderId'];
  if (json['purchaseOrderId'] != null)
    purchaseOrderId = json['purchaseOrderId'];
  if (json['paymentTermId'] != null) paymentTermId = json['paymentTermId'];
  if (json['paymentDate'] != null) paymentDate = json['paymentDate'];
  if (json['receiverBusinessId'] != null)
    receiverBusinessId = json['receiverBusinessId'];
  if (json['receiverAccId'] != null) receiverAccId = json['receiverAccId'];
  if (json['receiverAddress'] != null)
    receiverAddress = json['receiverAddress'];
  if (json['receiverBranchId'] != null)
    receiverBranchId = json['receiverBranchId'];
  if (json['receiverFinUserId'] != null)
    receiverFinUserId = json['receiverFinUserId'];
  if (json['shippingAmount'] != null)
    shippingAmount = double.parse('${json['shippingAmount']}');
  if (json['vatAmount'] != null)
    vatAmount = double.parse('${json['vatAmount']}');
  if (json['taxAmount'] != null)
    taxAmount = double.parse('${json['taxAmount']}');
  if (json['discountType'] != null) discountType = json['discountType'];
  if (json['discountValue'] != null)
    discountValue = double.parse('${json['taxAmount']}');
  if (json['discountAmount'] != null)
    discountAmount = double.parse('${json['discountAmount']}');
  if (json['itemsTotal'] != null)
    itemsTotal = double.parse('${json['itemsTotal']}');
  if (json['totalAmount'] != null)
    totalAmount = double.parse('${json['totalAmount']}');
  if (json['confirmedAmount'] != null)
    confirmedAmount = double.parse('${json['confirmedAmount']}');
  if (json['paidAmount'] != null)
    paidAmount = double.parse('${json['paidAmount']}');
  if (json['amountToPay'] != null)
    amountToPay = double.parse('${json['amountToPay']}');
  if (json['paymentStatus'] != null) paymentStatus = json['paymentStatus'];
  if (json['invoiceStatus'] != null) invoiceStatus = json['invoiceStatus'];
  if (json['overDueStatus'] != null) overDueStatus = json['overDueStatus'];
  if (json['sentDate'] != null) sentDate = json['sentDate'];
  if (json['description'] != null) description = json['description'];
  if (json['confirmedUserId'] != null)
    confirmedUserId = json['confirmedUserId'];
  if (json['confirmedDate'] != null) confirmedDate = json['confirmedDate'];
  if (json['respondText'] != null) respondText = json['respondText'];
  if (json['type'] != null) type = json['type'];
  if (json['receiverBusiness'] != null) {
    receiverBusiness =
        Invoice.fromJson(json['receiverBusiness'] as Map<String, dynamic>);
  }

  if (json['partnerId'] != null) partnerId = json['partnerId'];
  if (json['regNumber'] != null) regNumber = json['regNumber'];
  if (json['stateRegNum'] != null) stateRegNum = json['stateRegNum'];
  if (json['partnerName'] != null) partnerName = json['partnerName'];
  if (json['partnerNameEng'] != null) partnerNameEng = json['partnerNameEng'];
  if (json['isVatPayer'] != null) isVatPayer = json['isVatPayer'];
  if (json['partnerEmail'] != null) partnerEmail = json['partnerEmail'];
  if (json['partnerPhone'] != null) partnerPhone = json['partnerPhone'];
  if (json['profileName'] != null) profileName = json['profileName'];
  if (json['profileNameEng'] != null) profileNameEng = json['profileNameEng'];
  if (json['logo'] != null) logo = json['logo'];
  if (json['profileInfo'] != null) profileInfo = json['profileInfo'];
  if (json['partner'] != null) {
    partner = Invoice.fromJson(json['partner'] as Map<String, dynamic>);
  }

  if (json['businessName'] != null) businessName = json['businessName'];
  if (json['businessNameEng'] != null)
    businessNameEng = json['businessNameEng'];
  if (json['senderUser'] != null) {
    senderUser = Invoice.fromJson(json['senderUser'] as Map<String, dynamic>);
  }
  if (json['lastName'] != null) lastName = json['lastName'];
  if (json['firstName'] != null) firstName = json['firstName'];
  if (json['avatar'] != null) avatar = json['avatar'];

  if (json['confirmedUser'] != null) {
    confirmedUser =
        User.fromJson(json['confirmedUser'] as Map<String, dynamic>);
  }

  if (json['salesOrder'] != null) {
    salesOrder = Invoice.fromJson(json['salesOrder'] as Map<String, dynamic>);
  }
  if (json['purchaseOrder'] != null) {
    purchaseOrder =
        Invoice.fromJson(json['purchaseOrder'] as Map<String, dynamic>);
  }
  if (json['remainingDays'] != null)
    remainingDays = int.parse('${json['remainingDays']}');

  if (json['senderFinUser'] != null)
    senderFinUser =
        Invoice.fromJson(json['senderFinUser'] as Map<String, dynamic>);
  if (json['senderBranch'] != null)
    senderBranch =
        Invoice.fromJson(json['senderBranch'] as Map<String, dynamic>);
  if (json['name'] != null) name = json['name'];
  if (json['nameEng'] != null) nameEng = json['nameEng'];
  if (json['branchStatus'] != null) branchStatus = json['branchStatus'];
  if (json['provinceId'] != null) provinceId = json['provinceId'];
  if (json['districtId'] != null) districtId = json['districtId'];
  if (json['khorooId'] != null) khorooId = json['khorooId'];
  if (json['khoroolol'] != null) khoroolol = json['khoroolol'];
  if (json['khotkhonBair'] != null) khotkhonBair = json['khotkhonBair'];
  if (json['khashaaDavkhar'] != null) khashaaDavkhar = json['khashaaDavkhar'];
  if (json['khaalgaDugaar'] != null) khaalgaDugaar = json['khaalgaDugaar'];
  if (json['branchAddress'] != null) branchAddress = json['branchAddress'];
  if (json['locationLat'] != null)
    locationLat = double.parse('${json['locationLat']}');
  if (json['locationLng'] != null)
    locationLng = double.parse('${json['locationLng']}');
  if (json['senderAcc'] != null)
    senderAcc = Invoice.fromJson(json['senderAcc'] as Map<String, dynamic>);
  if (json['senderBusiness'] != null)
    senderBusiness =
        Invoice.fromJson(json['senderBusiness'] as Map<String, dynamic>);
  if (json['bankName'] != null) bankName = json['bankName'];
  if (json['number'] != null) number = json['number'];
  if (json['currency'] != null) currency = json['currency'];
  if (json['icon'] != null) icon = json['icon'];
  if (json['paymentTerm'] != null)
    paymentTerm = Invoice.fromJson(json['paymentTerm'] as Map<String, dynamic>);
  if (json['modifiedUserId'] != null) modifiedUserId = json['modifiedUserId'];
  if (json['termRule'] != null) termRule = json['termRule'];
  if (json['orderConfirmTerm'] != null)
    orderConfirmTerm = json['orderConfirmTerm'];
  if (json['expireDayCount'] != null) expireDayCount = json['expireDayCount'];
  if (json['month'] != null) month = json['month'];
  if (json['paymentDay'] != null) paymentDay = json['paymentDay'];
  if (json['isMain'] != null) isMain = json['isMain'];
  if (json['isActive'] != null) isActive = json['isActive'];
  if (json['isOpen'] != null) isOpen = json['isOpen'];
  if (json['receiverFinUser'] != null)
    receiverFinUser =
        Invoice.fromJson(json['receiverFinUser'] as Map<String, dynamic>);
  if (json['receiverBranch'] != null)
    receiverBranch =
        Invoice.fromJson(json['receiverBranch'] as Map<String, dynamic>);
  if (json['receiverAcc'] != null)
    receiverAcc = Invoice.fromJson(json['receiverAcc'] as Map<String, dynamic>);
  if (json['invoiceLines'] != null)
    invoiceLines =
        (json['invoiceLines'] as List).map((e) => Invoice.fromJson(e)).toList();
  if (json['invoiceId'] != null) invoiceId = json['invoiceId'];
  if (json['unitVariantId'] != null) unitVariantId = json['unitVariantId'];
  if (json['price'] != null) price = double.parse('${json['price']}');
  if (json['quantity'] != null) quantity = double.parse('${json['quantity']}');
  if (json['hasVat'] != null) hasVat = json['hasVat'];
  if (json['vatPercent'] != null)
    vatPercent = double.parse('${json['vatPercent']}');
  if (json['hasTax'] != null) hasTax = json['hasTax'];
  if (json['taxPercent'] != null)
    taxPercent = double.parse('${json['taxPercent']}');
  if (json['lineTotalAmount'] != null)
    lineTotalAmount = double.parse('${json['lineTotalAmount']}');

  if (json['skuCode'] != null) skuCode = json['skuCode'];
  if (json['barCode'] != null) barCode = json['barCode'];
  if (json['erpCode'] != null) erpCode = json['erpCode'];
  if (json['nameMon'] != null) nameMon = json['nameMon'];
  if (json['nameBill'] != null) nameBill = json['nameBill'];
  if (json['nameWeb'] != null) nameWeb = json['nameWeb'];
  if (json['nameApp'] != null) nameApp = json['nameApp'];
  if (json['image'] != null) image = json['image'];
  if (json['priceStartDate'] != null) priceStartDate = json['priceStartDate'];
  if (json['unit'] != null)
    unit = Invoice.fromJson(json['unit'] as Map<String, dynamic>);
  if (json['convertType'] != null) convertType = json['convertType'];
  if (json['convertValue'] != null)
    convertValue = double.parse('${json['convertValue']}');
  if (json['attachments'] != null)
    attachments =
        (json['attachments'] as List).map((e) => Invoice.fromJson(e)).toList();

  return Invoice(
    method: method,
    creditAccountId: creditAccountId,
    amount: amount,
    count: count,
    rows: rows,
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    refCode: refCode,
    senderUserId: senderUserId,
    senderBusinessId: senderBusinessId,
    senderFinUserId: senderFinUserId,
    senderBranchId: senderBranchId,
    senderAccId: senderAccId,
    salesOrderId: salesOrderId,
    purchaseOrderId: purchaseOrderId,
    paymentTermId: paymentTermId,
    paymentDate: paymentDate,
    receiverBusinessId: receiverBusinessId,
    receiverAccId: receiverAccId,
    receiverAddress: receiverAddress,
    receiverBranchId: receiverBranchId,
    receiverFinUserId: receiverFinUserId,
    shippingAmount: shippingAmount,
    vatAmount: vatAmount,
    taxAmount: taxAmount,
    discountType: discountType,
    discountValue: discountValue,
    discountAmount: discountAmount,
    itemsTotal: itemsTotal,
    totalAmount: totalAmount,
    confirmedAmount: confirmedAmount,
    paidAmount: paidAmount,
    amountToPay: amountToPay,
    paymentStatus: paymentStatus,
    invoiceStatus: invoiceStatus,
    overDueStatus: overDueStatus,
    sentDate: sentDate,
    description: description,
    confirmedUserId: confirmedUserId,
    confirmedDate: confirmedDate,
    respondText: respondText,
    type: type,
    receiverBusiness: receiverBusiness,
    partnerId: partnerId,
    regNumber: regNumber,
    stateRegNum: stateRegNum,
    partnerName: partnerName,
    partnerNameEng: partnerNameEng,
    isVatPayer: isVatPayer,
    partnerEmail: partnerEmail,
    partnerPhone: partnerPhone,
    profileName: profileName,
    profileNameEng: profileNameEng,
    logo: logo,
    profileInfo: profileInfo,
    partner: partner,
    businessName: businessName,
    businessNameEng: businessNameEng,
    senderUser: senderUser,
    lastName: lastName,
    firstName: firstName,
    avatar: avatar,
    confirmedUser: confirmedUser,
    salesOrder: salesOrder,
    purchaseOrder: purchaseOrder,
    remainingDays: remainingDays,
    senderBusiness: senderBusiness,
    senderFinUser: senderFinUser,
    senderBranch: senderBranch,
    name: name,
    nameEng: nameEng,
    branchStatus: branchStatus,
    provinceId: provinceId,
    districtId: districtId,
    khorooId: khorooId,
    khoroolol: khoroolol,
    khotkhonBair: khotkhonBair,
    khashaaDavkhar: khashaaDavkhar,
    khaalgaDugaar: khaalgaDugaar,
    branchAddress: branchAddress,
    locationLat: locationLat,
    locationLng: locationLng,
    senderAcc: senderAcc,
    bankName: bankName,
    number: number,
    currency: currency,
    icon: icon,
    paymentTerm: paymentTerm,
    modifiedUserId: modifiedUserId,
    termRule: termRule,
    orderConfirmTerm: orderConfirmTerm,
    expireDayCount: expireDayCount,
    month: month,
    paymentDay: paymentDay,
    isMain: isMain,
    isActive: isActive,
    isOpen: isOpen,
    receiverFinUser: receiverFinUser,
    receiverBranch: receiverBranch,
    receiverAcc: receiverAcc,
    invoiceLines: invoiceLines,
    invoiceId: invoiceId,
    unitVariantId: unitVariantId,
    price: price,
    quantity: quantity,
    hasVat: hasVat,
    vatPercent: vatPercent,
    hasTax: hasTax,
    taxPercent: taxPercent,
    lineTotalAmount: lineTotalAmount,
    skuCode: skuCode,
    barCode: barCode,
    erpCode: erpCode,
    nameMon: nameMon,
    nameBill: nameBill,
    nameWeb: nameWeb,
    nameApp: nameApp,
    image: image,
    priceStartDate: priceStartDate,
    unit: unit,
    convertType: convertType,
    convertValue: convertValue,
    attachments: attachments,
  );
}

Map<String, dynamic> _$InvoiceToJson(Invoice instance) {
  Map<String, dynamic> json = {};

  if (instance.method != null) json['method'] = instance.method;
  if (instance.creditAccountId != null)
    json['creditAccountId'] = instance.creditAccountId;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.count != null) json['count'] = instance.count;

  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.senderUserId != null)
    json['senderUserId'] = instance.senderUserId;
  if (instance.senderBusinessId != null)
    json['senderBusinessId'] = instance.senderBusinessId;
  if (instance.senderFinUserId != null)
    json['senderFinUserId'] = instance.senderFinUserId;
  if (instance.senderBranchId != null)
    json['senderBranchId'] = instance.senderBranchId;
  if (instance.senderAccId != null) json['senderAccId'] = instance.senderAccId;
  if (instance.salesOrderId != null)
    json['salesOrderId'] = instance.salesOrderId;
  if (instance.purchaseOrderId != null)
    json['purchaseOrderId'] = instance.purchaseOrderId;
  if (instance.paymentTermId != null)
    json['paymentTermId'] = instance.paymentTermId;
  if (instance.paymentDate != null) json['paymentDate'] = instance.paymentDate;
  if (instance.receiverBusinessId != null)
    json['receiverBusinessId'] = instance.receiverBusinessId;
  if (instance.receiverAccId != null)
    json['receiverAccId'] = instance.receiverAccId;
  if (instance.receiverAddress != null)
    json['receiverAddress'] = instance.receiverAddress;
  if (instance.receiverBranchId != null)
    json['receiverBranchId'] = instance.receiverBranchId;
  if (instance.receiverFinUserId != null)
    json['receiverFinUserId'] = instance.receiverFinUserId;
  if (instance.shippingAmount != null)
    json['shippingAmount'] = instance.shippingAmount;
  if (instance.vatAmount != null) json['vatAmount'] = instance.vatAmount;
  if (instance.taxAmount != null) json['taxAmount'] = instance.taxAmount;
  if (instance.discountType != null)
    json['discountType'] = instance.discountType;
  if (instance.discountValue != null)
    json['discountValue'] = instance.discountValue;
  if (instance.discountAmount != null)
    json['discountAmount'] = instance.discountAmount;
  if (instance.itemsTotal != null) json['itemsTotal'] = instance.itemsTotal;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.confirmedAmount != null)
    json['confirmedAmount'] = instance.confirmedAmount;
  if (instance.paidAmount != null) json['paidAmount'] = instance.paidAmount;
  if (instance.amountToPay != null) json['amountToPay'] = instance.amountToPay;
  if (instance.paymentStatus != null)
    json['paymentStatus'] = instance.paymentStatus;
  if (instance.invoiceStatus != null)
    json['invoiceStatus'] = instance.invoiceStatus;
  if (instance.overDueStatus != null)
    json['overDueStatus'] = instance.overDueStatus;
  if (instance.sentDate != null) json['sentDate'] = instance.sentDate;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.confirmedUserId != null)
    json['confirmedUserId'] = instance.confirmedUserId;
  if (instance.confirmedDate != null)
    json['confirmedDate'] = instance.confirmedDate;
  if (instance.respondText != null) json['respondText'] = instance.respondText;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.receiverBusiness != null)
    json['receiverBusiness'] = instance.receiverBusiness;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.stateRegNum != null) json['stateRegNum'] = instance.stateRegNum;
  if (instance.partnerName != null) json['partnerName'] = instance.partnerName;
  if (instance.partnerNameEng != null)
    json['partnerNameEng'] = instance.partnerNameEng;
  if (instance.isVatPayer != null) json['isVatPayer'] = instance.isVatPayer;
  if (instance.partnerEmail != null)
    json['partnerEmail'] = instance.partnerEmail;
  if (instance.partnerPhone != null)
    json['partnerPhone'] = instance.partnerPhone;
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.profileNameEng != null)
    json['profileNameEng'] = instance.profileNameEng;
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.profileInfo != null) json['profileInfo'] = instance.profileInfo;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.businessName != null)
    json['businessName'] = instance.businessName;
  if (instance.businessNameEng != null)
    json['businessNameEng'] = instance.businessNameEng;
  if (instance.senderUser != null) json['senderUser'] = instance.senderUser;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.confirmedUser != null)
    json['confirmedUser'] = instance.confirmedUser;
  if (instance.salesOrder != null) json['salesOrder'] = instance.salesOrder;
  if (instance.purchaseOrder != null)
    json['purchaseOrder'] = instance.purchaseOrder;
  if (instance.remainingDays != null)
    json['remainingDays'] = instance.remainingDays;
  if (instance.senderBusiness != null)
    json['senderBusiness'] = instance.senderBusiness;
  if (instance.senderFinUser != null)
    json['senderFinUser'] = instance.senderFinUser;
  if (instance.senderBranch != null)
    json['senderBranch'] = instance.senderBranch;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.nameEng != null) json['nameEng'] = instance.nameEng;
  if (instance.branchStatus != null)
    json['branchStatus'] = instance.branchStatus;
  if (instance.provinceId != null) json['provinceId'] = instance.provinceId;
  if (instance.districtId != null) json['districtId'] = instance.districtId;
  if (instance.khorooId != null) json['khorooId'] = instance.khorooId;
  if (instance.khoroolol != null) json['khoroolol'] = instance.khoroolol;
  if (instance.khotkhonBair != null)
    json['khotkhonBair'] = instance.khotkhonBair;
  if (instance.khashaaDavkhar != null)
    json['khashaaDavkhar'] = instance.khashaaDavkhar;
  if (instance.khaalgaDugaar != null)
    json['khaalgaDugaar'] = instance.khaalgaDugaar;
  if (instance.branchAddress != null)
    json['branchAddress'] = instance.branchAddress;
  if (instance.locationLat != null) json['locationLat'] = instance.locationLat;
  if (instance.locationLng != null) json['locationLng'] = instance.locationLng;
  if (instance.senderAcc != null) json['senderAcc'] = instance.senderAcc;
  if (instance.bankName != null) json['bankName'] = instance.bankName;
  if (instance.number != null) json['number'] = instance.number;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.icon != null) json['icon'] = instance.icon;
  if (instance.paymentTerm != null) json['paymentTerm'] = instance.paymentTerm;
  if (instance.modifiedUserId != null)
    json['modifiedUserId'] = instance.modifiedUserId;
  if (instance.termRule != null) json['termRule'] = instance.termRule;
  if (instance.orderConfirmTerm != null)
    json['orderConfirmTerm'] = instance.orderConfirmTerm;
  if (instance.expireDayCount != null)
    json['expireDayCount'] = instance.expireDayCount;
  if (instance.month != null) json['month'] = instance.month;
  if (instance.paymentDay != null) json['paymentDay'] = instance.paymentDay;
  if (instance.isMain != null) json['isMain'] = instance.isMain;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.isOpen != null) json['isOpen'] = instance.isOpen;
  if (instance.receiverFinUser != null)
    json['receiverFinUser'] = instance.receiverFinUser;
  if (instance.receiverBranch != null)
    json['receiverBranch'] = instance.receiverBranch;
  if (instance.receiverAcc != null) json['receiverAcc'] = instance.receiverAcc;
  if (instance.invoiceLines != null)
    json['invoiceLines'] = instance.invoiceLines;
  if (instance.invoiceId != null) json['invoiceId'] = instance.invoiceId;
  if (instance.unitVariantId != null)
    json['unitVariantId'] = instance.unitVariantId;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.quantity != null) json['quantity'] = instance.quantity;
  if (instance.hasVat != null) json['hasVat'] = instance.hasVat;
  if (instance.vatPercent != null) json['vatPercent'] = instance.vatPercent;
  if (instance.hasTax != null) json['hasTax'] = instance.hasTax;
  if (instance.taxPercent != null) json['taxPercent'] = instance.taxPercent;
  if (instance.lineTotalAmount != null)
    json['lineTotalAmount'] = instance.lineTotalAmount;
  if (instance.skuCode != null) json['skuCode'] = instance.skuCode;
  if (instance.barCode != null) json['barCode'] = instance.barCode;
  if (instance.erpCode != null) json['erpCode'] = instance.erpCode;
  if (instance.nameMon != null) json['nameMon'] = instance.nameMon;
  if (instance.nameBill != null) json['nameBill'] = instance.nameBill;
  if (instance.nameWeb != null) json['nameWeb'] = instance.nameWeb;
  if (instance.nameApp != null) json['nameApp'] = instance.nameApp;
  if (instance.image != null) json['image'] = instance.image;
  if (instance.priceStartDate != null)
    json['priceStartDate'] = instance.priceStartDate;
  if (instance.unit != null) json['unit'] = instance.unit;
  if (instance.convertType != null) json['convertType'] = instance.convertType;
  if (instance.convertValue != null)
    json['convertValue'] = instance.convertValue;
  if (instance.attachments != null) json['attachments'] = instance.attachments;

  return json;
}
