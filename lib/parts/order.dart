part of '../models/order.dart';

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    count: json['count'] != null ? int.parse(json['count'].toString()) : null,
    rows: json['rows'] != null
        ? (json['rows'] as List).map((e) => Order.fromJson(e)).toList()
        : null,
    values: json['values'] != null
        ? (json['values'] as List).map((e) => Order.fromJson(e)).toList()
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
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
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    isDefault: json['isDefault'] != null ? json['isDefault'] as bool : null,
    isConfirmed:
        json['isConfirmed'] != null ? json['isConfirmed'] as bool : null,
    businessStatus: json['businessStatus'] != null
        ? json['businessStatus'] as String
        : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
    startDate: json['startDate'] != null
        ? DateTime.parse(json['startDate'].toString())
        : null,
    profileNameEng: json['profileNameEng'] != null
        ? json['profileNameEng'] as String
        : null,
    logo: json['logo'] != null ? json['logo'] as String : null,
    profileInfo:
        json['profileInfo'] != null ? json['profileInfo'] as String : null,
    deliveredDate: json['deliveredDate'] != null
        ? DateTime.parse(json['deliveredDate'].toString())
        : null,
    isAnchorBusiness: json['isAnchorBusiness'] != null
        ? json['isAnchorBusiness'] as bool
        : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    partnerName:
        json['partnerName'] != null ? json['partnerName'] as String : null,
    partnerNameEng: json['partnerNameEng'] != null
        ? json['partnerNameEng'] as String
        : null,
    partnerEmail:
        json['partnerEmail'] != null ? json['partnerEmail'] as String : null,
    partnerEmail2:
        json['partnerEmail2'] != null ? json['partnerEmail2'] as String : null,
    partnerPhone:
        json['partnerPhone'] != null ? json['partnerPhone'] as String : null,
    partnerPhone2:
        json['partnerPhone2'] != null ? json['partnerPhone2'] as String : null,
    legalEntityType: json['legalEntityType'] != null
        ? json['legalEntityType'] as String
        : null,
    partner: json['partner'] != null
        ? Order.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    deliveryNote: json['deliveryNote'] != null
        ? Order.fromJson(json['deliveryNote'] as Map<String, dynamic>)
        : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    receiverBrach: json['receiverBrach'] != null
        ? Order.fromJson(json['receiverBrach'] as Map<String, dynamic>)
        : null,
    receiverBranch: json['receiverBranch'] != null
        ? Order.fromJson(json['receiverBranch'] as Map<String, dynamic>)
        : null,
    receipt: json['receipt'] != null
        ? Order.fromJson(json['receipt'] as Map<String, dynamic>)
        : null,
    order: json['order'] != null
        ? Order.fromJson(json['order'] as Map<String, dynamic>)
        : null,
    name: json['name'] != null ? json['name'] as String : null,
    nameEng: json['nameEng'] != null ? json['nameEng'] as String : null,
    receiverStaff: json['receiverStaff'] != null
        ? Order.fromJson(json['receiverStaff'] as Map<String, dynamic>)
        : null,
    receiverFinStaff: json['receiverFinStaff'] != null
        ? Order.fromJson(json['receiverFinStaff'] as Map<String, dynamic>)
        : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    region: json['region'] != null
        ? Order.fromJson(json['region'] as Map<String, dynamic>)
        : null,
    direction: json['direction'] != null
        ? Order.fromJson(json['direction'] as Map<String, dynamic>)
        : null,
    // category: json['category'] != null ? json['category'] as String : null,
    priority: json['priority'] != null
        ? Order.fromJson(json['priority'] as Map<String, dynamic>)
        : null,
    staff: json['staff'] != null
        ? Order.fromJson(json['staff'] as Map<String, dynamic>)
        : null,
    networkStatus:
        json['networkStatus'] != null ? json['networkStatus'] as String : null,
    branchStatus:
        json['branchStatus'] != null ? json['branchStatus'] as String : null,
    isBuyer: json['isBuyer'] != null ? json['isBuyer'] as bool : null,
    isBuyerConfirmed: json['isBuyerConfirmed'] != null
        ? json['isBuyerConfirmed'] as bool
        : null,
    isSupplierConfirmed: json['isSupplierConfirmed'] != null
        ? json['isSupplierConfirmed'] as bool
        : null,
    approve: json['approve'] != null ? json['approve'] as bool : null,
    isSupplier: json['isSupplier'] != null ? json['isSupplier'] as bool : null,
    deliveryDate:
        json['deliveryDate'] != null ? json['deliveryDate'] as String : null,
    province: json['province'] != null ? json['province'] as String : null,
    district: json['district'] != null ? json['district'] as String : null,
    khoroo: json['khoroo'] != null ? json['khoroo'] as String : null,
    khoroolol: json['khoroolol'] != null ? json['khoroolol'] as String : null,
    khotkhonBair:
        json['khotkhonBair'] != null ? json['khotkhonBair'] as String : null,
    khashaaDavkhar: json['khashaaDavkhar'] != null
        ? json['khashaaDavkhar'] as String
        : null,
    khaalgaDugaar:
        json['khaalgaDugaar'] != null ? json['khaalgaDugaar'] as String : null,
    branchAddress:
        json['branchAddress'] != null ? json['branchAddress'] as String : null,
    businessId:
        json['businessId'] != null ? json['businessId'] as String : null,
    receiverBranchId: json['receiverBranchId'] != null
        ? json['receiverBranchId'] as String
        : null,
    deliveryType:
        json['deliveryType'] != null ? json['deliveryType'] as String : null,
    receiverStaffId: json['receiverStaffId'] != null
        ? json['receiverStaffId'] as String
        : null,
    lines: json['lines'] != null
        ? (json['lines'] as List).map((e) => Order.fromJson(e)).toList()
        : null,
    attachments: json['attachments'] != null
        ? (json['attachments'] as List).map((e) => Order.fromJson(e)).toList()
        : null,
    additionalLines: json['additionalLines'] != null
        ? (json['additionalLines'] as List)
            .map((e) => Order.fromJson(e))
            .toList()
        : null,
    variantId: json['variantId'] != null ? json['variantId'] as String : null,
    discountType:
        json['discountType'] != null ? json['discountType'] as String : null,
    discountValue: json['discountValue'] != null
        ? double.parse(json['discountValue'].toString())
        : null,
    advancePercent: json['advancePercent'] != null
        ? double.parse(json['advancePercent'].toString())
        : null,
    quantity: json['quantity'] != null
        ? int.parse(json['quantity'].toString())
        : null,
    unit: json['unit'] != null ? json['unit'] as String : null,
    price:
        json['price'] != null ? double.parse(json['price'].toString()) : null,
    senderNote:
        json['senderNote'] != null ? json['senderNote'] as String : null,
    senderAdditionalNote: json['senderAdditionalNote'] != null
        ? json['senderAdditionalNote'] as String
        : null,
    shippingAmount: json['shippingAmount'] != null
        ? double.parse(json['shippingAmount'].toString())
        : null,
    url: json['url'] != null ? json['url'] as String : null,
    text: json['text'] != null ? json['text'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    toReview: json['toReview'] != null ? json['toReview'] as bool : null,
    isEnded: json['isEnded'] != null ? json['isEnded'] as bool : null,
    send: json['send'] != null ? json['send'] as bool : null,
    review: json['review'] != null ? json['review'] as bool : null,
    skuCode: json['skuCode'] != null ? json['skuCode'] as String : null,
    barCode: json['barCode'] != null ? json['barCode'] as String : null,
    erpCode: json['erpCode'] != null ? json['erpCode'] as String : null,
    nameMon: json['nameMon'] != null ? json['nameMon'] as String : null,
    nameBill: json['nameBill'] != null ? json['nameBill'] as String : null,
    nameWeb: json['nameWeb'] != null ? json['nameWeb'] as String : null,
    nameApp: json['nameApp'] != null ? json['nameApp'] as String : null,
    image: json['image'] != null ? json['image'] as String : null,
    supplier: json['supplier'] != null ? json['supplier'] as String : null,
    brand: json['brand'] != null ? json['brand'] as String : null,
    priceStartDate: json['priceStartDate'] != null
        ? DateTime.parse(json['priceStartDate'].toString())
        : null,
    hasVat: json['hasVat'] != null ? json['hasVat'] as bool : null,
    hasTax: json['hasTax'] != null ? json['hasTax'] as bool : null,
    vatAmount: json['vatAmount'] != null
        ? double.parse(json['vatAmount'].toString())
        : null,
    taxAmount: json['taxAmount'] != null
        ? double.parse(json['taxAmount'].toString())
        : null,
    optionValues: json['optionValues'] != null
        ? (json['optionValues'] as List).map((e) => Order.fromJson(e)).toList()
        : null,
    receiptLines: json['receiptLines'] != null
        ? (json['receiptLines'] as List).map((e) => Order.fromJson(e)).toList()
        : null,
    packageType:
        json['packageType'] != null ? json['packageType'] as String : null,
    purchaseCode:
        json['purchaseCode'] != null ? json['purchaseCode'] as String : null,
    salesCode: json['salesCode'] != null ? json['salesCode'] as String : null,
    orderStatus:
        json['orderStatus'] != null ? json['orderStatus'] as String : null,
    orderedUserId:
        json['orderedUserId'] != null ? json['orderedUserId'] as String : null,
    senderBusinessId: json['senderBusinessId'] != null
        ? json['senderBusinessId'] as String
        : null,
    receiverBusinessId: json['receiverBusinessId'] != null
        ? json['receiverBusinessId'] as String
        : null,
    paymentTermId:
        json['paymentTermId'] != null ? json['paymentTermId'] as String : null,
    createdType:
        json['createdType'] != null ? json['createdType'] as String : null,
    itemTypeCount: json['itemTypeCount'] != null
        ? double.parse(json['itemTypeCount'].toString())
        : null,
    totalItemCount: json['totalItemCount'] != null
        ? double.parse(json['totalItemCount'].toString())
        : null,
    lineTotalAmount: json['lineTotalAmount'] != null
        ? double.parse(json['lineTotalAmount'].toString())
        : null,
    lineVatAmount: json['lineVatAmount'] != null
        ? double.parse(json['lineVatAmount'].toString())
        : null,
    lineTaxAmount: json['lineTaxAmount'] != null
        ? double.parse(json['lineTaxAmount'].toString())
        : null,
    lineTotalDiscountAmount: json['lineTotalDiscountAmount'] != null
        ? double.parse(json['lineTotalDiscountAmount'].toString())
        : null,
    orderAmount: json['orderAmount'] != null
        ? double.parse(json['orderAmount'].toString())
        : null,
    totalAmount: json['totalAmount'] != null
        ? double.parse(json['totalAmount'].toString())
        : null,
    paidAmount: json['paidAmount'] != null
        ? double.parse(json['paidAmount'].toString())
        : null,
    amountToPay: json['amountToPay'] != null
        ? double.parse(json['amountToPay'].toString())
        : null,
    paymentStatus:
        json['paymentStatus'] != null ? json['paymentStatus'] as String : null,
    reviewedUserId: json['reviewedUserId'] != null
        ? json['reviewedUserId'] as String
        : null,
    reviewedDate: json['reviewedDate'] != null
        ? DateTime.parse(json['reviewedDate'].toString())
        : null,
    canceledUserId: json['canceledUserId'] != null
        ? json['canceledUserId'] as String
        : null,
    canceledDate: json['canceledDate'] != null
        ? DateTime.parse(json['canceledDate'].toString())
        : null,
    respondedUserId: json['respondedUserId'] != null
        ? json['respondedUserId'] as String
        : null,
    respondedDate: json['respondedDate'] != null
        ? DateTime.parse(json['respondedDate'].toString())
        : null,
    invoiceId: json['invoiceId'] != null ? json['invoiceId'] as String : null,
    receiverBusiness: json['receiverBusiness'] != null
        ? Order.fromJson(json['receiverBusiness'] as Map<String, dynamic>)
        : null,
    senderBusiness: json['senderBusiness'] != null
        ? Order.fromJson(json['senderBusiness'] as Map<String, dynamic>)
        : null,
    orderedUser: json['orderedUser'] != null
        ? Order.fromJson(json['orderedUser'] as Map<String, dynamic>)
        : null,
    reviewedUser: json['reviewedUser'] != null
        ? Order.fromJson(json['reviewedUser'] as Map<String, dynamic>)
        : null,
    respondedUser: json['respondedUser'] != null
        ? Order.fromJson(json['respondedUser'] as Map<String, dynamic>)
        : null,
    business: json['business'] != null
        ? Order.fromJson(json['business'] as Map<String, dynamic>)
        : null,
    onDeliveryQuantity: json['onDeliveryQuantity'] != null
        ? int.parse(json['onDeliveryQuantity'].toString())
        : null,
    warehouseQuantity: json['warehouseQuantity'] != null
        ? int.parse(json['warehouseQuantity'].toString())
        : null,
    isVatPayer: json['isVatPayer'] != null ? json['isVatPayer'] as bool : null,
    paymentTerm: json['paymentTerm'] != null
        ? Order.fromJson(json['paymentTerm'] as Map<String, dynamic>)
        : null,
    receiverBranches: json['receiverBranches'] != null
        ? (json['receiverBranches'] as List)
            .map((e) => Order.fromJson(e))
            .toList()
        : null,
    regUserId: json['regUserId'] != null ? json['regUserId'] as String : null,
    locationLat: json['locationLat'] != null
        ? double.parse(json['locationLat'].toString())
        : null,
    locationLng: json['locationLng'] != null
        ? double.parse(json['locationLng'].toString())
        : null,
    warehouseId:
        json['warehouseId'] != null ? json['warehouseId'] as String : null,
    staffId: json['staffId'] != null ? json['staffId'] as String : null,
    loadingDate: json['loadingDate'] != null
        ? DateTime.parse(json['loadingDate'].toString())
        : null,
    pullSheetStatus: json['pullSheetStatus'] != null
        ? json['pullSheetStatus'] as String
        : null,
    startedDate: json['startedDate'] != null
        ? DateTime.parse(json['startedDate'].toString())
        : null,
    isPaused: json['isPaused'] != null ? json['isPaused'] as bool : null,
    pausedDate: json['pausedDate'] != null
        ? DateTime.parse(json['pausedDate'].toString())
        : null,
    proceededDate: json['proceededDate'] != null
        ? DateTime.parse(json['proceededDate'].toString())
        : null,
    pausedDuration: json['pausedDuration'] != null
        ? double.parse(json['pausedDuration'].toString())
        : null,
    endedDate: json['endedDate'] != null
        ? DateTime.parse(json['endedDate'].toString())
        : null,
    lineId: json['lineId'] != null ? json['lineId'] as String : null,
    dispatchedDate: json['dispatchedDate'] != null
        ? DateTime.parse(json['dispatchedDate'].toString())
        : null,
    warehouse: json['warehouse'] != null
        ? Order.fromJson(json['warehouse'] as Map<String, dynamic>)
        : null,
    user: json['user'] != null
        ? Order.fromJson(json['user'] as Map<String, dynamic>)
        : null,
    warehouseUserId: json['warehouseUserId'] != null
        ? json['warehouseUserId'] as String
        : null,
    warehouseUser: json['warehouseUser'] != null
        ? Order.fromJson(json['warehouseUser'] as Map<String, dynamic>)
        : null,
    regUser: json['regUser'] != null
        ? Order.fromJson(json['regUser'] as Map<String, dynamic>)
        : null,
    warehouseStatus: json['warehouseStatus'] != null
        ? json['warehouseStatus'] as String
        : null,
    deliveryNotes: json['deliveryNotes'] != null
        ? (json['deliveryNotes'] as List).map((e) => Order.fromJson(e)).toList()
        : null,
    pullSheetLines: json['pullSheetLines'] != null
        ? (json['pullSheetLines'] as List)
            .map((e) => Order.fromJson(e))
            .toList()
        : null,
    orderId: json['orderId'] != null ? json['orderId'] as String : null,
    pullSheetId:
        json['pullSheetId'] != null ? json['pullSheetId'] as String : null,
    deliveryNoteStatus: json['deliveryNoteStatus'] != null
        ? json['deliveryNoteStatus'] as String
        : null,
    variantParentId: json['variantParentId'] != null
        ? json['variantParentId'] as String
        : null,
    optionValue:
        json['optionValue'] != null ? json['optionValue'] as String : null,
    baseUnitId:
        json['baseUnitId'] != null ? json['baseUnitId'] as String : null,
    baseUnit: json['baseUnit'] != null ? json['baseUnit'] as String : null,
    condition: json['condition'] != null ? json['condition'] as String : null,
    unitId: json['unitId'] != null ? json['unitId'] as String : null,
    configType:
        json['configType'] != null ? json['configType'] as String : null,
    unitConvertType: json['unitConvertType'] != null
        ? json['unitConvertType'] as String
        : null,
    unitConvertValue: json['unitConvertValue'] != null
        ? int.parse(json['unitConvertValue'].toString())
        : null,
    baseUnitQuantity: json['baseUnitQuantity'] != null
        ? int.parse(json['baseUnitQuantity'].toString())
        : null,
    hasAdditionalUnit: json['hasAdditionalUnit'] != null
        ? json['hasAdditionalUnit'] as bool
        : null,
    additionalUnit: json['additionalUnit'] != null
        ? json['additionalUnit'] as String
        : null,
    additionalUnitQuantity: json['additionalUnitQuantity'] != null
        ? double.parse(json['additionalUnitQuantity'].toString())
        : null,
    deliveryNoteId: json['deliveryNoteId'] != null
        ? json['deliveryNoteId'] as String
        : null,
    totalLineType: json['totalLineType'] != null
        ? int.parse(json['totalLineType'].toString())
        : null,
    totalLineQuantity: json['totalLineQuantity'] != null
        ? int.parse(json['totalLineQuantity'].toString())
        : null,
    pullSheetLineId: json['pullSheetLineId'] != null
        ? json['pullSheetLineId'] as String
        : null,
    confirmedQuantity: json['confirmedQuantity'] != null
        ? int.parse(json['confirmedQuantity'].toString())
        : null,

    supplierStaff: json['supplierStaff'] != null
        ? Order.fromJson(json['supplierStaff'] as Map<String, dynamic>)
        : null,
    buyerStaff: json['buyerStaff'] != null
        ? Order.fromJson(json['buyerStaff'] as Map<String, dynamic>)
        : null,
    supplierBusiness: json['supplierBusiness'] != null
        ? Order.fromJson(json['supplierBusiness'] as Map<String, dynamic>)
        : null,
    buyerBusiness: json['buyerBusiness'] != null
        ? Order.fromJson(json['buyerBusiness'] as Map<String, dynamic>)
        : null,
    deliveryStaff: json['deliveryStaff'] != null
        ? Order.fromJson(json['deliveryStaff'] as Map<String, dynamic>)
        : null,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) {
  Map<String, dynamic> json = {};

  if (instance.values != null) json['values'] = instance.values;
  if (instance.header != null) json['header'] = instance.header;
  if (instance.receipt != null) json['receipt'] = instance.receipt;
  if (instance.deliveryNote != null)
    json['deliveryNote'] = instance.deliveryNote;
  if (instance.order != null) json['order'] = instance.order;
  if (instance.advancePercent != null)
    json['advancePercent'] = instance.advancePercent;
  if (instance.business != null) json['business'] = instance.business;
  if (instance.isBuyerConfirmed != null)
    json['isBuyerConfirmed'] = instance.isBuyerConfirmed;
  if (instance.isSupplierConfirmed != null)
    json['isSupplierConfirmed'] = instance.isSupplierConfirmed;
  if (instance.respondedUser != null)
    json['respondedUser'] = instance.respondedUser;
  if (instance.isEnded != null) json['isEnded'] = instance.isEnded;
  if (instance.deliveredDate != null)
    json['deliveredDate'] = instance.deliveredDate;
  if (instance.configType != null) json['configType'] = instance.configType;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.startDate != null) json['startDate'] = instance.startDate;
  if (instance.deliveryStaff != null)
    json['deliveryStaff'] = instance.deliveryStaff;
  if (instance.supplierBusiness != null)
    json['supplierBusiness'] = instance.supplierBusiness;
  if (instance.buyerBusiness != null)
    json['buyerBusiness'] = instance.buyerBusiness;
  if (instance.receiptLines != null)
    json['receiptLines'] = instance.receiptLines;
  if (instance.supplierStaff != null)
    json['supplierStaff'] = instance.supplierStaff;
  if (instance.lineId != null) json['lineId'] = instance.lineId;
  if (instance.buyerStaff != null) json['buyerStaff'] = instance.buyerStaff;
  if (instance.confirmedQuantity != null)
    json['confirmedQuantity'] = instance.confirmedQuantity;
  if (instance.pullSheetLineId != null)
    json['pullSheetLineId'] = instance.pullSheetLineId;
  if (instance.totalLineQuantity != null)
    json['totalLineQuantity'] = instance.totalLineQuantity;
  if (instance.totalLineType != null)
    json['totalLineType'] = instance.totalLineType;
  if (instance.deliveryNoteId != null)
    json['deliveryNoteId'] = instance.deliveryNoteId;
  if (instance.additionalUnitQuantity != null)
    json['additionalUnitQuantity'] = instance.additionalUnitQuantity;
  if (instance.additionalUnit != null)
    json['additionalUnit'] = instance.additionalUnit;
  if (instance.hasAdditionalUnit != null)
    json['hasAdditionalUnit'] = instance.hasAdditionalUnit;
  if (instance.baseUnitQuantity != null)
    json['baseUnitQuantity'] = instance.baseUnitQuantity;
  if (instance.unitConvertValue != null)
    json['unitConvertValue'] = instance.unitConvertValue;
  if (instance.unitConvertType != null)
    json['unitConvertType'] = instance.unitConvertType;
  if (instance.condition != null) json['condition'] = instance.condition;
  if (instance.unitId != null) json['unitId'] = instance.unitId;
  if (instance.isConfirmed != null) json['isConfirmed'] = instance.isConfirmed;
  if (instance.baseUnit != null) json['baseUnit'] = instance.baseUnit;
  if (instance.baseUnitId != null) json['baseUnitId'] = instance.baseUnitId;
  if (instance.text != null) json['text'] = instance.text;
  if (instance.optionValue != null) json['optionValue'] = instance.optionValue;
  if (instance.variantParentId != null)
    json['variantParentId'] = instance.variantParentId;
  if (instance.pullSheetId != null) json['pullSheetId'] = instance.pullSheetId;
  if (instance.orderId != null) json['orderId'] = instance.orderId;
  if (instance.pullSheetLines != null)
    json['pullSheetLines'] = instance.pullSheetLines;
  if (instance.deliveryNotes != null)
    json['deliveryNotes'] = instance.deliveryNotes;
  if (instance.warehouseStatus != null)
    json['warehouseStatus'] = instance.warehouseStatus;
  if (instance.regUser != null) json['regUser'] = instance.regUser;
  if (instance.warehouseId != null) json['warehouseId'] = instance.warehouseId;
  if (instance.staffId != null) json['staffId'] = instance.staffId;
  if (instance.loadingDate != null) json['loadingDate'] = instance.loadingDate;
  if (instance.pullSheetStatus != null)
    json['pullSheetStatus'] = instance.pullSheetStatus;
  if (instance.startedDate != null) json['startedDate'] = instance.startedDate;
  if (instance.isPaused != null) json['isPaused'] = instance.isPaused;
  if (instance.pausedDate != null) json['pausedDate'] = instance.pausedDate;
  if (instance.proceededDate != null)
    json['proceededDate'] = instance.proceededDate;
  if (instance.pausedDuration != null)
    json['pausedDuration'] = instance.pausedDuration;
  if (instance.endedDate != null) json['endedDate'] = instance.endedDate;
  if (instance.dispatchedDate != null)
    json['dispatchedDate'] = instance.dispatchedDate;
  if (instance.warehouse != null) json['warehouse'] = instance.warehouse;
  if (instance.warehouseUserId != null)
    json['warehouseUserId'] = instance.warehouseUserId;
  if (instance.warehouseUser != null)
    json['warehouseUser'] = instance.warehouseUser;
  if (instance.regUserId != null) json['regUserId'] = instance.regUserId;
  if (instance.receiverBranches != null)
    json['receiverBranches'] = instance.receiverBranches;
  if (instance.locationLat != null) json['locationLat'] = instance.locationLat;
  if (instance.locationLng != null) json['locationLng'] = instance.locationLng;
  if (instance.isVatPayer != null) json['isVatPayer'] = instance.isVatPayer;
  if (instance.paymentTerm != null) json['paymentTerm'] = instance.paymentTerm;
  if (instance.review != null) json['review'] = instance.review;
  if (instance.reviewedUser != null)
    json['reviewedUser'] = instance.reviewedUser;
  if (instance.onDeliveryQuantity != null)
    json['onDeliveryQuantity'] = instance.onDeliveryQuantity;
  if (instance.warehouseQuantity != null)
    json['warehouseQuantity'] = instance.warehouseQuantity;
  if (instance.approve != null) json['approve'] = instance.approve;
  if (instance.orderedUser != null) json['orderedUser'] = instance.orderedUser;
  if (instance.senderBusiness != null)
    json['senderBusiness'] = instance.senderBusiness;
  if (instance.receiverBusiness != null)
    json['receiverBusiness'] = instance.receiverBusiness;
  if (instance.invoiceId != null) json['invoiceId'] = instance.invoiceId;
  if (instance.respondedDate != null)
    json['respondedDate'] = instance.respondedDate;
  if (instance.respondedUserId != null)
    json['respondedUserId'] = instance.respondedUserId;
  if (instance.canceledDate != null)
    json['canceledDate'] = instance.canceledDate;
  if (instance.canceledUserId != null)
    json['canceledUserId'] = instance.canceledUserId;
  if (instance.reviewedDate != null)
    json['reviewedDate'] = instance.reviewedDate;
  if (instance.reviewedUserId != null)
    json['reviewedUserId'] = instance.reviewedUserId;
  if (instance.paymentStatus != null)
    json['paymentStatus'] = instance.paymentStatus;
  if (instance.amountToPay != null) json['amountToPay'] = instance.amountToPay;
  if (instance.paidAmount != null) json['paidAmount'] = instance.paidAmount;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.orderAmount != null) json['orderAmount'] = instance.orderAmount;
  if (instance.lineTotalDiscountAmount != null)
    json['lineTotalDiscountAmount'] = instance.lineTotalDiscountAmount;
  if (instance.lineTaxAmount != null)
    json['lineTaxAmount'] = instance.lineTaxAmount;
  if (instance.lineVatAmount != null)
    json['lineVatAmount'] = instance.lineVatAmount;
  if (instance.lineTotalAmount != null)
    json['lineTotalAmount'] = instance.lineTotalAmount;
  if (instance.totalItemCount != null)
    json['totalItemCount'] = instance.totalItemCount;
  if (instance.itemTypeCount != null)
    json['itemTypeCount'] = instance.itemTypeCount;
  if (instance.createdType != null) json['createdType'] = instance.createdType;
  if (instance.paymentTermId != null)
    json['paymentTermId'] = instance.paymentTermId;
  if (instance.receiverBusinessId != null)
    json['receiverBusinessId'] = instance.receiverBusinessId;
  if (instance.senderBusinessId != null)
    json['senderBusinessId'] = instance.senderBusinessId;
  if (instance.orderedUserId != null)
    json['orderedUserId'] = instance.orderedUserId;
  if (instance.deliveryNoteStatus != null)
    json['deliveryNoteStatus'] = instance.deliveryNoteStatus;
  if (instance.orderStatus != null) json['orderStatus'] = instance.orderStatus;
  if (instance.salesCode != null) json['salesCode'] = instance.salesCode;
  if (instance.purchaseCode != null)
    json['purchaseCode'] = instance.purchaseCode;
  if (instance.skuCode != null) json['skuCode'] = instance.skuCode;
  if (instance.barCode != null) json['barCode'] = instance.barCode;
  if (instance.erpCode != null) json['erpCode'] = instance.erpCode;
  if (instance.nameMon != null) json['nameMon'] = instance.nameMon;
  if (instance.nameBill != null) json['nameBill'] = instance.nameBill;
  if (instance.nameWeb != null) json['nameWeb'] = instance.nameWeb;
  if (instance.nameApp != null) json['nameApp'] = instance.nameApp;
  if (instance.image != null) json['image'] = instance.image;
  if (instance.supplier != null) json['supplier'] = instance.supplier;
  if (instance.brand != null) json['brand'] = instance.brand;
  if (instance.priceStartDate != null)
    json['priceStartDate'] = instance.priceStartDate;
  if (instance.hasVat != null) json['hasVat'] = instance.hasVat;
  if (instance.hasTax != null) json['hasTax'] = instance.hasTax;
  if (instance.vatAmount != null) json['vatAmount'] = instance.vatAmount;
  if (instance.taxAmount != null) json['taxAmount'] = instance.taxAmount;
  if (instance.optionValues != null)
    json['optionValues'] = instance.optionValues;
  if (instance.packageType != null) json['packageType'] = instance.packageType;

  if (instance.businessId != null) json['businessId'] = instance.businessId;
  if (instance.receiverBranchId != null)
    json['receiverBranchId'] = instance.receiverBranchId;
  if (instance.deliveryType != null)
    json['deliveryType'] = instance.deliveryType;
  if (instance.receiverStaffId != null)
    json['receiverStaffId'] = instance.receiverStaffId;
  if (instance.lines != null) json['lines'] = instance.lines;
  if (instance.attachments != null) json['attachments'] = instance.attachments;
  if (instance.additionalLines != null)
    json['additionalLines'] = instance.additionalLines;
  if (instance.variantId != null) json['variantId'] = instance.variantId;
  if (instance.discountType != null)
    json['discountType'] = instance.discountType;
  if (instance.discountValue != null)
    json['discountValue'] = instance.discountValue;
  if (instance.quantity != null) json['quantity'] = instance.quantity;
  if (instance.unit != null) json['unit'] = instance.unit;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.senderNote != null) json['senderNote'] = instance.senderNote;
  if (instance.senderAdditionalNote != null)
    json['senderAdditionalNote'] = instance.senderAdditionalNote;
  if (instance.shippingAmount != null)
    json['shippingAmount'] = instance.shippingAmount;
  if (instance.url != null) json['url'] = instance.url;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.toReview != null) json['toReview'] = instance.toReview;
  if (instance.send != null) json['send'] = instance.send;
  if (instance.branchStatus != null)
    json['branchStatus'] = instance.branchStatus;
  if (instance.user != null) json['user'] = instance.user;
  if (instance.isBuyer != null) json['isBuyer'] = instance.isBuyer;
  if (instance.isSupplier != null) json['isSupplier'] = instance.isSupplier;
  if (instance.deliveryDate != null)
    json['deliveryDate'] = instance.deliveryDate;
  if (instance.province != null) json['province'] = instance.province;
  if (instance.district != null) json['district'] = instance.district;
  if (instance.khoroo != null) json['khoroo'] = instance.khoroo;
  if (instance.khoroolol != null) json['khoroolol'] = instance.khoroolol;
  if (instance.khotkhonBair != null)
    json['khotkhonBair'] = instance.khotkhonBair;
  if (instance.khashaaDavkhar != null)
    json['khashaaDavkhar'] = instance.khashaaDavkhar;
  if (instance.khaalgaDugaar != null)
    json['khaalgaDugaar'] = instance.khaalgaDugaar;
  if (instance.branchAddress != null)
    json['branchAddress'] = instance.branchAddress;
  if (instance.count != null) json['count'] = instance.count;
  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.isDefault != null) json['isDefault'] = instance.isDefault;
  if (instance.businessStatus != null)
    json['businessStatus'] = instance.businessStatus;
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.profileNameEng != null)
    json['profileNameEng'] = instance.profileNameEng;
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.profileInfo != null) json['profileInfo'] = instance.profileInfo;
  if (instance.isAnchorBusiness != null)
    json['isAnchorBusiness'] = instance.isAnchorBusiness;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.partnerName != null) json['partnerName'] = instance.partnerName;
  if (instance.partnerNameEng != null)
    json['partnerNameEng'] = instance.partnerNameEng;
  if (instance.partnerEmail != null)
    json['partnerEmail'] = instance.partnerEmail;
  if (instance.partnerEmail2 != null)
    json['partnerEmail2'] = instance.partnerEmail2;
  if (instance.partnerPhone != null)
    json['partnerPhone'] = instance.partnerPhone;
  if (instance.partnerPhone2 != null)
    json['partnerPhone2'] = instance.partnerPhone2;
  if (instance.legalEntityType != null)
    json['legalEntityType'] = instance.legalEntityType;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.businessName != null)
    json['businessName'] = instance.businessName;
  if (instance.receiverBrach != null)
    json['receiverBrach'] = instance.receiverBrach;
  if (instance.receiverBranch != null)
    json['receiverBranch'] = instance.receiverBranch;
  if (instance.nameEng != null) json['nameEng'] = instance.nameEng;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.receiverStaff != null)
    json['receiverStaff'] = instance.receiverStaff;
  if (instance.receiverFinStaff != null)
    json['receiverFinStaff'] = instance.receiverFinStaff;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.region != null) json['region'] = instance.region;
  if (instance.direction != null) json['direction'] = instance.direction;
  if (instance.category != null) json['category'] = instance.category;
  if (instance.priority != null) json['priority'] = instance.priority;
  if (instance.staff != null) json['staff'] = instance.staff;
  if (instance.networkStatus != null)
    json['networkStatus'] = instance.networkStatus;

  return json;
}
