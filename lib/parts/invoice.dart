part of '../models/invoice.dart';

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return Invoice(
    method: json['method'] != null ? json['method'] as String : null,
    creditAccountId: json['creditAccountId'] != null
        ? json['creditAccountId'] as String
        : null,
    amount: json['amount'] != null ? double.parse('${json['amount']}') : null,
    count: json['count'] != null ? int.parse("${json['count']}") : null,
    rows: json['rows'] != null
        ? (json['rows'] as List).map((e) => Invoice.fromJson(e)).toList()
        : null,
    values: json['values'] != null
        ? (json['values'] as List).map((e) => Invoice.fromJson(e)).toList()
        : null,
    additionalLines: json['additionalLines'] != null
        ? (json['additionalLines'] as List)
            .map((e) => Invoice.fromJson(e))
            .toList()
        : null,
    lines: json['lines'] != null
        ? (json['lines'] as List).map((e) => Invoice.fromJson(e)).toList()
        : null,
    stats: json['stats'] != null
        ? (json['stats'] as List).map((e) => Invoice.fromJson(e)).toList()
        : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'].toString())
        : null,
    paidDate: json['paidDate'] != null
        ? DateTime.parse(json['paidDate'].toString())
        : null,
    configType:
        json['configType'] != null ? json['configType'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    paymentMethod:
        json['paymentMethod'] != null ? json['paymentMethod'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    senderUserId:
        json['senderUserId'] != null ? json['senderUserId'] as String : null,
    senderBusinessId: json['senderBusinessId'] != null
        ? json['senderBusinessId'] as String
        : null,
    senderFinUserId: json['senderFinUserId'] != null
        ? json['senderFinUserId'] as String
        : null,
    send: json['send'] != null ? json['send'] as bool : null,
    confirm: json['confirm'] != null ? json['confirm'] as bool : null,
    senderBranchId: json['senderBranchId'] != null
        ? json['senderBranchId'] as String
        : null,
    senderAccId:
        json['senderAccId'] != null ? json['senderAccId'] as String : null,
    salesOrderId:
        json['salesOrderId'] != null ? json['salesOrderId'] as String : null,
    purchaseOrderId: json['purchaseOrderId'] != null
        ? json['purchaseOrderId'] as String
        : null,
    paymentTermId:
        json['paymentTermId'] != null ? json['paymentTermId'] as String : null,
    paymentDate: json['paymentDate'] != null
        ? DateTime.parse(json['paymentDate'].toString())
        : null,
    header: json['header'] != null
        ? DateTime.parse(json['header'].toString())
        : null,
    receiverBusinessId: json['receiverBusinessId'] != null
        ? json['receiverBusinessId'] as String
        : null,
    receiverAccId:
        json['receiverAccId'] != null ? json['receiverAccId'] as String : null,
    receiverAddress: json['receiverAddress'] != null
        ? json['receiverAddress'] as String
        : null,
    receiverBranchId: json['receiverBranchId'] != null
        ? json['receiverBranchId'] as String
        : null,
    receiverFinUserId: json['receiverFinUserId'] != null
        ? json['receiverFinUserId'] as String
        : null,
    shippingAmount: json['shippingAmount'] != null
        ? double.parse("${json['shippingAmount']}")
        : null,
    trxAmount:
        json['trxAmount'] != null ? double.parse("${json['trxAmount']}") : null,
    vatAmount:
        json['vatAmount'] != null ? double.parse("${json['vatAmount']}") : null,
    taxAmount:
        json['taxAmount'] != null ? double.parse("${json['taxAmount']}") : null,
    discountType:
        json['discountType'] != null ? json['discountType'] as String : null,
    discountValue: json['discountValue'] != null
        ? double.parse("${json['discountValue']}")
        : null,
    discountAmount: json['discountAmount'] != null
        ? double.parse("${json['discountAmount']}")
        : null,
    itemsTotal: json['itemsTotal'] != null
        ? double.parse("${json['itemsTotal']}")
        : null,
    totalAmount: json['totalAmount'] != null
        ? double.parse("${json['totalAmount']}")
        : null,
    confirmedAmount: json['confirmedAmount'] != null
        ? double.parse("${json['confirmedAmount']}")
        : null,
    paidAmount: json['paidAmount'] != null
        ? double.parse("${json['paidAmount']}")
        : null,
    amountToPay: json['amountToPay'] != null
        ? double.parse("${json['amountToPay']}")
        : null,
    paymentStatus:
        json['paymentStatus'] != null ? json['paymentStatus'] as String : null,
    invoiceStatus:
        json['invoiceStatus'] != null ? json['invoiceStatus'] as String : null,
    overdueStatus:
        json['overdueStatus'] != null ? json['overdueStatus'] as String : null,
    sentDate: json['sentDate'] != null
        ? DateTime.parse(json['sentDate'].toString())
        : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    confirmedUserId: json['confirmedUserId'] != null
        ? json['confirmedUserId'] as String
        : null,
    confirmedDate: json['confirmedDate'] != null
        ? DateTime.parse(json['confirmedDate'].toString())
        : null,
    respondText:
        json['respondText'] != null ? json['respondText'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    receiverBusiness: json['receiverBusiness'] != null
        ? Invoice.fromJson(json['receiverBusiness'] as Map<String, dynamic>)
        : null,
    actionUser: json['actionUser'] != null
        ? Invoice.fromJson(json['actionUser'] as Map<String, dynamic>)
        : null,
    business: json['business'] != null
        ? Invoice.fromJson(json['business'] as Map<String, dynamic>)
        : null,
    branch: json['branch'] != null
        ? Invoice.fromJson(json['branch'] as Map<String, dynamic>)
        : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    salesCode: json['salesCode'] != null ? json['salesCode'] as String : null,
    purchaseCode:
        json['purchaseCode'] != null ? json['purchaseCode'] as String : null,
    stateRegNum:
        json['stateRegNum'] != null ? json['stateRegNum'] as String : null,
    partnerName:
        json['partnerName'] != null ? json['partnerName'] as String : null,
    partnerNameEng: json['partnerNameEng'] != null
        ? json['partnerNameEng'] as String
        : null,
    isVatPayer: json['isVatPayer'] != null ? json['isVatPayer'] as bool : null,
    partnerEmail:
        json['partnerEmail'] != null ? json['partnerEmail'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    partnerPhone:
        json['partnerPhone'] != null ? json['partnerPhone'] as String : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
    profileNameEng: json['profileNameEng'] != null
        ? json['profileNameEng'] as String
        : null,
    logo: json['logo'] != null ? json['logo'] as String : null,
    profileInfo:
        json['profileInfo'] != null ? json['profileInfo'] as String : null,
    partner: json['partner'] != null
        ? Invoice.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    businessNameEng: json['businessNameEng'] != null
        ? json['businessNameEng'] as String
        : null,
    senderUser: json['senderUser'] != null
        ? Invoice.fromJson(json['senderUser'] as Map<String, dynamic>)
        : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    confirmedUser: json['confirmedUser'] != null
        ? Invoice.fromJson(json['confirmedUser'] as Map<String, dynamic>)
        : null,
    salesOrder: json['salesOrder'] != null
        ? Invoice.fromJson(json['salesOrder'] as Map<String, dynamic>)
        : null,
    purchaseOrder: json['purchaseOrder'] != null
        ? Invoice.fromJson(json['purchaseOrder'] as Map<String, dynamic>)
        : null,
    remainingDays: json['remainingDays'] != null
        ? int.parse('${json['remainingDays']}')
        : null,
    confirmationDay: json['confirmationDay'] != null
        ? int.parse('${json['confirmationDay']}')
        : null,
    senderBusiness: json['senderBusiness'] != null
        ? Invoice.fromJson(json['senderBusiness'] as Map<String, dynamic>)
        : null,
    senderFinUser: json['senderFinUser'] != null
        ? Invoice.fromJson(json['senderFinUser'] as Map<String, dynamic>)
        : null,
    senderBranch: json['senderBranch'] != null
        ? Invoice.fromJson(json['senderBranch'] as Map<String, dynamic>)
        : null,
    name: json['name'] != null ? json['name'] as String : null,
    nameEng: json['nameEng'] != null ? json['nameEng'] as String : null,
    branchStatus:
        json['branchStatus'] != null ? json['branchStatus'] as String : null,
    provinceId:
        json['provinceId'] != null ? json['provinceId'] as String : null,
    districtId:
        json['districtId'] != null ? json['districtId'] as String : null,
    khorooId: json['khorooId'] != null ? json['khorooId'] as String : null,
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
    locationLat: json['locationLat'] != null
        ? double.parse("${json['locationLat']}")
        : null,
    invoicesCount: json['invoicesCount'] != null
        ? int.parse("${json['invoicesCount']}")
        : null,
    invoicesAmount: json['invoicesAmount'] != null
        ? double.parse("${json['invoicesAmount']}")
        : null,
    overdueInvoicesCount: json['overdueInvoicesCount'] != null
        ? int.parse("${json['overdueInvoicesCount']}")
        : null,
    overdueInvoicesAmount: json['overdueInvoicesAmount'] != null
        ? double.parse("${json['overdueInvoicesAmount']}")
        : null,
    locationLng: json['locationLng'] != null
        ? double.parse("${json['locationLng']}")
        : null,
    senderAcc: json['senderAcc'] != null
        ? Invoice.fromJson(json['senderAcc'] as Map<String, dynamic>)
        : null,
    bankName: json['bankName'] != null ? json['bankName'] as String : null,
    number: json['number'] != null ? json['number'] as String : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    icon: json['icon'] != null ? json['icon'] as String : null,
    paymentTerm: json['paymentTerm'] != null
        ? Invoice.fromJson(json['paymentTerm'] as Map<String, dynamic>)
        : null,
    modifiedUserId: json['modifiedUserId'] != null
        ? json['modifiedUserId'] as String
        : null,
    termRule: json['termRule'] != null ? json['termRule'] as String : null,
    orderConfirmTerm: json['orderConfirmTerm'] != null
        ? json['orderConfirmTerm'] as String
        : null,
    expireDayCount: json['expireDayCount'] != null
        ? int.parse("${json['expireDayCount']}")
        : null,
    month: json['month'] != null ? json['month'] as String : null,
    paymentDay: json['paymentDay'] != null
        ? int.parse(json['paymentDay'].toString())
        : null,
    isMain: json['isMain'] != null ? json['isMain'] as bool : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    isOpen: json['isOpen'] != null ? json['isOpen'] as bool : null,
    receiverFinUser: json['receiverFinUser'] != null
        ? Invoice.fromJson(json['receiverFinUser'] as Map<String, dynamic>)
        : null,
    receiverBranch: json['receiverBranch'] != null
        ? Invoice.fromJson(json['receiverBranch'] as Map<String, dynamic>)
        : null,
    receiverAcc: json['receiverAcc'] != null
        ? Invoice.fromJson(json['receiverAcc'] as Map<String, dynamic>)
        : null,
    invoiceLines: json['invoiceLines'] != null
        ? (json['invoiceLines'] as List)
            .map((e) => Invoice.fromJson(e))
            .toList()
        : null,
    invoiceId: json['invoiceId'] != null ? json['invoiceId'] as String : null,
    variantId: json['variantId'] != null ? json['variantId'] as String : null,
    price: json['price'] != null ? double.parse("${json['price']}") : null,
    quantity:
        json['quantity'] != null ? int.parse("${json['quantity']}") : null,
    hasVat: json['hasVat'] != null ? json['hasVat'] as bool : null,
    vatPercent: json['vatPercent'] != null
        ? double.parse("${json['vatPercent']}")
        : null,
    hasTax: json['hasTax'] != null ? json['hasTax'] as bool : null,
    taxPercent: json['taxPercent'] != null
        ? double.parse("${json['taxPercent']}")
        : null,
    lineTotalAmount: json['lineTotalAmount'] != null
        ? double.parse("${json['lineTotalAmount']}")
        : null,
    skuCode: json['skuCode'] != null ? json['skuCode'] as String : null,
    barCode: json['barCode'] != null ? json['barCode'] as String : null,
    erpCode: json['erpCode'] != null ? json['erpCode'] as String : null,
    nameMon: json['nameMon'] != null ? json['nameMon'] as String : null,
    nameBill: json['nameBill'] != null ? json['nameBill'] as String : null,
    nameWeb: json['nameWeb'] != null ? json['nameWeb'] as String : null,
    nameApp: json['nameApp'] != null ? json['nameApp'] as String : null,
    image: json['image'] != null ? json['image'] as String : null,
    priceStartDate: json['priceStartDate'] != null
        ? DateTime.parse(json['priceStartDate'].toString())
        : null,
    unit: json['unit'] != null ? json['unit'] as String : null,
    convertType:
        json['convertType'] != null ? json['convertType'] as String : null,
    convertValue: json['convertValue'] != null
        ? int.parse(json['convertValue'].toString())
        : null,
    attachments: json['attachments'] != null
        ? (json['attachments'] as List).map((e) => Invoice.fromJson(e)).toList()
        : null,
    unitName: json['unitName'] != null ? json['unitName'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    businessAddress: json['businessAddress'] != null
        ? json['businessAddress'] as String
        : null,
    staff: json['staff'] != null
        ? Invoice.fromJson(json['staff'] as Map<String, dynamic>)
        : null,
    category: json['category'] != null ? json['category'] as String : null,
    supplier: json['supplier'] != null ? json['supplier'] as String : null,
    brand: json['brand'] != null ? json['brand'] as String : null,
    optionValues: json['optionValues'] != null
        ? (json['optionValues'] as List)
            .map((e) => Invoice.fromJson(e))
            .toList()
        : null,
    optionId: json['optionId'] != null ? json['optionId'] as String : null,
    invoiceRefCode: json['invoiceRefCode'] != null
        ? json['invoiceRefCode'] as String
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
    urls: json['urls'] != null
        ? (json['urls'] as List).map((e) => Urls.fromJson(e)).toList()
        : null,
    qr_image: json['qr_image'] != null ? json['qr_image'] as String : null,
  );
}

Map<String, dynamic> _$InvoiceToJson(Invoice instance) {
  Map<String, dynamic> json = {};

  if (instance.paidDate != null) json['paidDate'] = instance.paidDate;
  if (instance.actionUser != null) json['actionUser'] = instance.actionUser;
  if (instance.invoicesCount != null) {
    json['invoicesCount'] = instance.invoicesCount;
  }
  if (instance.invoicesAmount != null) {
    json['invoicesAmount'] = instance.invoicesAmount;
  }
  if (instance.trxAmount != null) json['trxAmount'] = instance.trxAmount;
  if (instance.overdueInvoicesCount != null) {
    json['overdueInvoicesCount'] = instance.overdueInvoicesCount;
  }
  if (instance.overdueInvoicesAmount != null) {
    json['overdueInvoicesAmount'] = instance.overdueInvoicesAmount;
  }
  if (instance.email != null) json['email'] = instance.email;
  if (instance.business != null) json['business'] = instance.business;
  if (instance.branch != null) json['branch'] = instance.branch;
  if (instance.confirmationDay != null) {
    json['confirmationDay'] = instance.confirmationDay;
  }
  if (instance.values != null) json['values'] = instance.values;
  if (instance.header != null) json['header'] = instance.header;
  if (instance.stats != null) json['stats'] = instance.stats;
  if (instance.configType != null) json['configType'] = instance.configType;
  if (instance.salesCode != null) json['salesCode'] = instance.salesCode;
  if (instance.purchaseCode != null) {
    json['purchaseCode'] = instance.purchaseCode;
  }
  if (instance.urls != null) json['urls'] = instance.urls;
  if (instance.qr_image != null) json['qr_image'] = instance.qr_image;
  if (instance.invoiceRefCode != null) {
    json['invoiceRefCode'] = instance.invoiceRefCode;
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
  if (instance.category != null) json['category'] = instance.category;
  if (instance.supplier != null) json['supplier'] = instance.supplier;
  if (instance.brand != null) json['brand'] = instance.brand;
  if (instance.optionValues != null) {
    json['optionValues'] = instance.optionValues;
  }
  if (instance.paymentMethod != null) {
    json['paymentMethod'] = instance.paymentMethod;
  }
  if (instance.optionId != null) json['optionId'] = instance.optionId;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.businessAddress != null) {
    json['businessAddress'] = instance.businessAddress;
  }
  if (instance.staff != null) json['staff'] = instance.staff;
  if (instance.unitName != null) json['unitName'] = instance.unitName;
  if (instance.confirm != null) json['confirm'] = instance.confirm;
  if (instance.send != null) json['send'] = instance.send;
  if (instance.lines != null) json['lines'] = instance.lines;
  if (instance.method != null) json['method'] = instance.method;
  if (instance.creditAccountId != null) {
    json['creditAccountId'] = instance.creditAccountId;
  }
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.count != null) json['count'] = instance.count;
  if (instance.additionalLines != null) {
    json['additionalLines'] = instance.additionalLines;
  }
  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.senderUserId != null) {
    json['senderUserId'] = instance.senderUserId;
  }
  if (instance.senderBusinessId != null) {
    json['senderBusinessId'] = instance.senderBusinessId;
  }
  if (instance.senderFinUserId != null) {
    json['senderFinUserId'] = instance.senderFinUserId;
  }
  if (instance.senderBranchId != null) {
    json['senderBranchId'] = instance.senderBranchId;
  }
  if (instance.senderAccId != null) json['senderAccId'] = instance.senderAccId;
  if (instance.salesOrderId != null) {
    json['salesOrderId'] = instance.salesOrderId;
  }
  if (instance.purchaseOrderId != null) {
    json['purchaseOrderId'] = instance.purchaseOrderId;
  }
  if (instance.paymentTermId != null) {
    json['paymentTermId'] = instance.paymentTermId;
  }
  if (instance.paymentDate != null) json['paymentDate'] = instance.paymentDate;
  if (instance.receiverBusinessId != null) {
    json['receiverBusinessId'] = instance.receiverBusinessId;
  }
  if (instance.receiverAccId != null) {
    json['receiverAccId'] = instance.receiverAccId;
  }
  if (instance.receiverAddress != null) {
    json['receiverAddress'] = instance.receiverAddress;
  }
  if (instance.receiverBranchId != null) {
    json['receiverBranchId'] = instance.receiverBranchId;
  }
  if (instance.receiverFinUserId != null) {
    json['receiverFinUserId'] = instance.receiverFinUserId;
  }
  if (instance.shippingAmount != null) {
    json['shippingAmount'] = instance.shippingAmount;
  }
  if (instance.vatAmount != null) json['vatAmount'] = instance.vatAmount;
  if (instance.taxAmount != null) json['taxAmount'] = instance.taxAmount;
  if (instance.discountType != null) {
    json['discountType'] = instance.discountType;
  }
  if (instance.discountValue != null) {
    json['discountValue'] = instance.discountValue;
  }
  if (instance.discountAmount != null) {
    json['discountAmount'] = instance.discountAmount;
  }
  if (instance.itemsTotal != null) json['itemsTotal'] = instance.itemsTotal;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.confirmedAmount != null) {
    json['confirmedAmount'] = instance.confirmedAmount;
  }
  if (instance.paidAmount != null) json['paidAmount'] = instance.paidAmount;
  if (instance.amountToPay != null) json['amountToPay'] = instance.amountToPay;
  if (instance.paymentStatus != null) {
    json['paymentStatus'] = instance.paymentStatus;
  }
  if (instance.invoiceStatus != null) {
    json['invoiceStatus'] = instance.invoiceStatus;
  }
  if (instance.overdueStatus != null) {
    json['overdueStatus'] = instance.overdueStatus;
  }
  if (instance.sentDate != null) json['sentDate'] = instance.sentDate;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.confirmedUserId != null) {
    json['confirmedUserId'] = instance.confirmedUserId;
  }
  if (instance.confirmedDate != null) {
    json['confirmedDate'] = instance.confirmedDate;
  }
  if (instance.respondText != null) json['respondText'] = instance.respondText;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.receiverBusiness != null) {
    json['receiverBusiness'] = instance.receiverBusiness;
  }
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.stateRegNum != null) json['stateRegNum'] = instance.stateRegNum;
  if (instance.partnerName != null) json['partnerName'] = instance.partnerName;
  if (instance.partnerNameEng != null) {
    json['partnerNameEng'] = instance.partnerNameEng;
  }
  if (instance.isVatPayer != null) json['isVatPayer'] = instance.isVatPayer;
  if (instance.partnerEmail != null) {
    json['partnerEmail'] = instance.partnerEmail;
  }
  if (instance.partnerPhone != null) {
    json['partnerPhone'] = instance.partnerPhone;
  }
  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.profileNameEng != null) {
    json['profileNameEng'] = instance.profileNameEng;
  }
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.profileInfo != null) json['profileInfo'] = instance.profileInfo;
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.businessName != null) {
    json['businessName'] = instance.businessName;
  }
  if (instance.businessNameEng != null) {
    json['businessNameEng'] = instance.businessNameEng;
  }
  if (instance.senderUser != null) json['senderUser'] = instance.senderUser;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.confirmedUser != null) {
    json['confirmedUser'] = instance.confirmedUser;
  }
  if (instance.salesOrder != null) json['salesOrder'] = instance.salesOrder;
  if (instance.purchaseOrder != null) {
    json['purchaseOrder'] = instance.purchaseOrder;
  }
  if (instance.remainingDays != null) {
    json['remainingDays'] = instance.remainingDays;
  }
  if (instance.senderBusiness != null) {
    json['senderBusiness'] = instance.senderBusiness;
  }
  if (instance.senderFinUser != null) {
    json['senderFinUser'] = instance.senderFinUser;
  }
  if (instance.senderBranch != null) {
    json['senderBranch'] = instance.senderBranch;
  }
  if (instance.name != null) json['name'] = instance.name;
  if (instance.nameEng != null) json['nameEng'] = instance.nameEng;
  if (instance.branchStatus != null) {
    json['branchStatus'] = instance.branchStatus;
  }
  if (instance.provinceId != null) json['provinceId'] = instance.provinceId;
  if (instance.districtId != null) json['districtId'] = instance.districtId;
  if (instance.khorooId != null) json['khorooId'] = instance.khorooId;
  if (instance.khoroolol != null) json['khoroolol'] = instance.khoroolol;
  if (instance.khotkhonBair != null) {
    json['khotkhonBair'] = instance.khotkhonBair;
  }
  if (instance.khashaaDavkhar != null) {
    json['khashaaDavkhar'] = instance.khashaaDavkhar;
  }
  if (instance.khaalgaDugaar != null) {
    json['khaalgaDugaar'] = instance.khaalgaDugaar;
  }
  if (instance.branchAddress != null) {
    json['branchAddress'] = instance.branchAddress;
  }
  if (instance.locationLat != null) json['locationLat'] = instance.locationLat;
  if (instance.locationLng != null) json['locationLng'] = instance.locationLng;
  if (instance.senderAcc != null) json['senderAcc'] = instance.senderAcc;
  if (instance.bankName != null) json['bankName'] = instance.bankName;
  if (instance.number != null) json['number'] = instance.number;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.icon != null) json['icon'] = instance.icon;
  if (instance.paymentTerm != null) json['paymentTerm'] = instance.paymentTerm;
  if (instance.modifiedUserId != null) {
    json['modifiedUserId'] = instance.modifiedUserId;
  }
  if (instance.termRule != null) json['termRule'] = instance.termRule;
  if (instance.orderConfirmTerm != null) {
    json['orderConfirmTerm'] = instance.orderConfirmTerm;
  }
  if (instance.expireDayCount != null) {
    json['expireDayCount'] = instance.expireDayCount;
  }
  if (instance.month != null) json['month'] = instance.month;
  if (instance.paymentDay != null) json['paymentDay'] = instance.paymentDay;
  if (instance.isMain != null) json['isMain'] = instance.isMain;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.isOpen != null) json['isOpen'] = instance.isOpen;
  if (instance.receiverFinUser != null) {
    json['receiverFinUser'] = instance.receiverFinUser;
  }
  if (instance.receiverBranch != null) {
    json['receiverBranch'] = instance.receiverBranch;
  }
  if (instance.receiverAcc != null) json['receiverAcc'] = instance.receiverAcc;
  if (instance.invoiceLines != null) {
    json['invoiceLines'] = instance.invoiceLines;
  }
  if (instance.invoiceId != null) json['invoiceId'] = instance.invoiceId;
  if (instance.variantId != null) json['variantId'] = instance.variantId;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.quantity != null) json['quantity'] = instance.quantity;
  if (instance.hasVat != null) json['hasVat'] = instance.hasVat;
  if (instance.vatPercent != null) json['vatPercent'] = instance.vatPercent;
  if (instance.hasTax != null) json['hasTax'] = instance.hasTax;
  if (instance.taxPercent != null) json['taxPercent'] = instance.taxPercent;
  if (instance.lineTotalAmount != null) {
    json['lineTotalAmount'] = instance.lineTotalAmount;
  }
  if (instance.skuCode != null) json['skuCode'] = instance.skuCode;
  if (instance.barCode != null) json['barCode'] = instance.barCode;
  if (instance.erpCode != null) json['erpCode'] = instance.erpCode;
  if (instance.nameMon != null) json['nameMon'] = instance.nameMon;
  if (instance.nameBill != null) json['nameBill'] = instance.nameBill;
  if (instance.nameWeb != null) json['nameWeb'] = instance.nameWeb;
  if (instance.nameApp != null) json['nameApp'] = instance.nameApp;
  if (instance.image != null) json['image'] = instance.image;
  if (instance.priceStartDate != null) {
    json['priceStartDate'] = instance.priceStartDate;
  }
  if (instance.unit != null) json['unit'] = instance.unit;
  if (instance.convertType != null) json['convertType'] = instance.convertType;
  if (instance.convertValue != null) {
    json['convertValue'] = instance.convertValue;
  }
  if (instance.attachments != null) json['attachments'] = instance.attachments;

  return json;
}
