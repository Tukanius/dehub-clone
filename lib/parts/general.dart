part of "../models/general.dart";

General _$GeneralFromJson(Map<String, dynamic> json) {
  List<Provinces>? provinces;
  List<Districts>? districts;
  List<Khoroos>? khoroos;
  List<BankAccounts>? bankAccounts;
  List<Staffs>? staffs;
  List<Networks>? networks;
  List<Currencies>? currencies;
  List<DiscountTypes>? discountTypes;
  List<InvoiceHistoryTypes>? invoiceHistoryTypes;
  List<InvoiceTypes>? invoiceTypes;
  List<InvoicePaymentStatus>? invoicePaymentStatus;
  List<InvoiceStatus>? invoiceStatus;
  List<ItemStatus>? itemStatus;
  List<Types>? types;
  List<NumberUnits>? numberUnits;
  List<OrderConfirmTerms>? orderConfirmTerms;
  List<OverDueStatus>? overDueStatus;
  List<PaymentMethod>? paymentMethod;
  List<PaymentTermRules>? paymentTermRules;
  List<PerTypes>? perTypes;
  List<PriceChangeTypes>? priceChangeTypes;
  List<PriceEndTypes>? priceEndTypes;
  List<ReturnTypes>? returnTypes;
  List<TransactionTypes>? transactionTypes;
  List<UnitConvertTypes>? unitConvertTypes;
  List<UnitSpaceLabels>? unitSpaceLabels;
  List<UnitWeightLabels>? unitWeightLabels;

  List<BranchStatus>? branchStatus;
  List<BranchTypes>? branchTypes;
  List<BusinessSectors>? businessSectors;
  List<BusinessStaffRoles>? businessStaffRoles;
  List<BusinessStatus>? businessStatus;
  List<ContractDocTypes>? contractDocTypes;
  List<EquityTypes>? equityTypes;
  List<InvitationStatus>? invitationStatus;
  List<InvitationTypes>? invitationTypes;
  List<LegalEntityTypes>? legalEntityTypes;
  List<PartnerClassifications>? partnerClassifications;
  List<PartnerRegisterStatus>? partnerRegisterStatus;
  List<PartnerTypes>? partnerTypes;
  List<Permissions>? permissions;
  List<ProductCategoryTypes>? productCategoryTypes;
  List<PurchaseTypes>? purchaseTypes;
  ReferenceListTypes? referenceListTypes;
  List<ReferenceTypes>? referenceTypes;
  List<ServiceCategoryTypes>? serviceCategoryTypes;

  if (json['branchStatus'] != null) {
    branchStatus = (json['branchStatus'] as List)
        .map((e) => BranchStatus.fromJson(e))
        .toList();
  }
  if (json['referenceListTypes'] != null) {
    referenceListTypes = ReferenceListTypes.fromJson(
        json['referenceListTypes'] as Map<String, dynamic>);
  }
  if (json['branchTypes'] != null) {
    branchTypes = (json['branchTypes'] as List)
        .map((e) => BranchTypes.fromJson(e))
        .toList();
  }
  if (json['businessSectors'] != null) {
    businessSectors = (json['businessSectors'] as List)
        .map((e) => BusinessSectors.fromJson(e))
        .toList();
  }
  if (json['businessStaffRoles'] != null) {
    businessStaffRoles = (json['businessStaffRoles'] as List)
        .map((e) => BusinessStaffRoles.fromJson(e))
        .toList();
  }
  if (json['businessStatus'] != null) {
    businessStatus = (json['businessStatus'] as List)
        .map((e) => BusinessStatus.fromJson(e))
        .toList();
  }
  if (json['contractDocTypes'] != null) {
    contractDocTypes = (json['contractDocTypes'] as List)
        .map((e) => ContractDocTypes.fromJson(e))
        .toList();
  }
  if (json['equityTypes'] != null) {
    equityTypes = (json['equityTypes'] as List)
        .map((e) => EquityTypes.fromJson(e))
        .toList();
  }
  if (json['invitationStatus'] != null) {
    invitationStatus = (json['invitationStatus'] as List)
        .map((e) => InvitationStatus.fromJson(e))
        .toList();
  }
  if (json['invitationTypes'] != null) {
    invitationTypes = (json['invitationTypes'] as List)
        .map((e) => InvitationTypes.fromJson(e))
        .toList();
  }
  if (json['legalEntityTypes'] != null) {
    legalEntityTypes = (json['legalEntityTypes'] as List)
        .map((e) => LegalEntityTypes.fromJson(e))
        .toList();
  }
  if (json['partnerClassifications'] != null) {
    partnerClassifications = (json['partnerClassifications'] as List)
        .map((e) => PartnerClassifications.fromJson(e))
        .toList();
  }
  if (json['partnerRegisterStatus'] != null) {
    partnerRegisterStatus = (json['partnerRegisterStatus'] as List)
        .map((e) => PartnerRegisterStatus.fromJson(e))
        .toList();
  }
  if (json['partnerTypes'] != null) {
    partnerTypes = (json['partnerTypes'] as List)
        .map((e) => PartnerTypes.fromJson(e))
        .toList();
  }
  if (json['permissions'] != null) {
    permissions = (json['permissions'] as List)
        .map((e) => Permissions.fromJson(e))
        .toList();
  }
  if (json['productCategoryTypes'] != null) {
    productCategoryTypes = (json['productCategoryTypes'] as List)
        .map((e) => ProductCategoryTypes.fromJson(e))
        .toList();
  }
  if (json['purchaseTypes'] != null) {
    purchaseTypes = (json['purchaseTypes'] as List)
        .map((e) => PurchaseTypes.fromJson(e))
        .toList();
  }
  if (json['referenceTypes'] != null) {
    referenceTypes = (json['referenceTypes'] as List)
        .map((e) => ReferenceTypes.fromJson(e))
        .toList();
  }
  if (json['serviceCategoryTypes'] != null) {
    serviceCategoryTypes = (json['serviceCategoryTypes'] as List)
        .map((e) => ServiceCategoryTypes.fromJson(e))
        .toList();
  }
  if (json['provinces'] != null) {
    provinces =
        (json['provinces'] as List).map((e) => Provinces.fromJson(e)).toList();
  }
  if (json['districts'] != null) {
    districts =
        (json['districts'] as List).map((e) => Districts.fromJson(e)).toList();
  }
  if (json['khoroos'] != null) {
    khoroos =
        (json['khoroos'] as List).map((e) => Khoroos.fromJson(e)).toList();
  }
  if (json['bankAccounts'] != null) {
    bankAccounts = (json['bankAccounts'] as List)
        .map((e) => BankAccounts.fromJson(e))
        .toList();
  }
  if (json['staffs'] != null) {
    staffs = (json['staffs'] as List).map((e) => Staffs.fromJson(e)).toList();
  }
  if (json['networks'] != null) {
    networks =
        (json['networks'] as List).map((e) => Networks.fromJson(e)).toList();
  }
  if (json['currencies'] != null) {
    currencies = (json['currencies'] as List)
        .map((e) => Currencies.fromJson(e))
        .toList();
  }
  if (json['discountTypes'] != null) {
    discountTypes = (json['discountTypes'] as List)
        .map((e) => DiscountTypes.fromJson(e))
        .toList();
  }
  if (json['invoiceHistoryTypes'] != null) {
    invoiceHistoryTypes = (json['invoiceHistoryTypes'] as List)
        .map((e) => InvoiceHistoryTypes.fromJson(e))
        .toList();
  }
  if (json['invoiceTypes'] != null) {
    invoiceTypes = (json['invoiceTypes'] as List)
        .map((e) => InvoiceTypes.fromJson(e))
        .toList();
  }
  if (json['invoicePaymentStatus'] != null) {
    invoicePaymentStatus = (json['invoicePaymentStatus'] as List)
        .map((e) => InvoicePaymentStatus.fromJson(e))
        .toList();
  }
  if (json['invoiceStatus'] != null) {
    invoiceStatus = (json['invoiceStatus'] as List)
        .map((e) => InvoiceStatus.fromJson(e))
        .toList();
  }
  if (json['itemStatus'] != null) {
    itemStatus = (json['itemStatus'] as List)
        .map((e) => ItemStatus.fromJson(e))
        .toList();
  }
  if (json['types'] != null) {
    types = (json['types'] as List).map((e) => Types.fromJson(e)).toList();
  }
  if (json['numberUnits'] != null) {
    numberUnits = (json['numberUnits'] as List)
        .map((e) => NumberUnits.fromJson(e))
        .toList();
  }
  if (json['orderConfirmTerms'] != null) {
    orderConfirmTerms = (json['orderConfirmTerms'] as List)
        .map((e) => OrderConfirmTerms.fromJson(e))
        .toList();
  }
  if (json['overDueStatus'] != null) {
    overDueStatus = (json['overDueStatus'] as List)
        .map((e) => OverDueStatus.fromJson(e))
        .toList();
  }
  if (json['paymentMethod'] != null) {
    paymentMethod = (json['paymentMethod'] as List)
        .map((e) => PaymentMethod.fromJson(e))
        .toList();
  }
  if (json['paymentTermRules'] != null) {
    paymentTermRules = (json['paymentTermRules'] as List)
        .map((e) => PaymentTermRules.fromJson(e))
        .toList();
  }
  if (json['perTypes'] != null) {
    perTypes =
        (json['perTypes'] as List).map((e) => PerTypes.fromJson(e)).toList();
  }
  if (json['priceChangeTypes'] != null) {
    priceChangeTypes = (json['priceChangeTypes'] as List)
        .map((e) => PriceChangeTypes.fromJson(e))
        .toList();
  }
  if (json['priceEndTypes'] != null) {
    priceEndTypes = (json['priceEndTypes'] as List)
        .map((e) => PriceEndTypes.fromJson(e))
        .toList();
  }
  if (json['returnTypes'] != null) {
    returnTypes = (json['returnTypes'] as List)
        .map((e) => ReturnTypes.fromJson(e))
        .toList();
  }
  if (json['transactionTypes'] != null) {
    transactionTypes = (json['transactionTypes'] as List)
        .map((e) => TransactionTypes.fromJson(e))
        .toList();
  }
  if (json['unitConvertTypes'] != null) {
    unitConvertTypes = (json['unitConvertTypes'] as List)
        .map((e) => UnitConvertTypes.fromJson(e))
        .toList();
  }
  if (json['unitSpaceLabels'] != null) {
    unitSpaceLabels = (json['unitSpaceLabels'] as List)
        .map((e) => UnitSpaceLabels.fromJson(e))
        .toList();
  }
  if (json['unitWeightLabels'] != null) {
    unitWeightLabels = (json['unitWeightLabels'] as List)
        .map((e) => UnitWeightLabels.fromJson(e))
        .toList();
  }

  return General(
    provinces: provinces,
    districts: districts,
    khoroos: khoroos,
    bankAccounts: bankAccounts,
    staffs: staffs,
    networks: networks,
    currencies: currencies,
    discountTypes: discountTypes,
    invoiceHistoryTypes: invoiceHistoryTypes,
    invoiceTypes: invoiceTypes,
    invoicePaymentStatus: invoicePaymentStatus,
    invoiceStatus: invoiceStatus,
    itemStatus: itemStatus,
    types: types,
    numberUnits: numberUnits,
    orderConfirmTerms: orderConfirmTerms,
    overDueStatus: overDueStatus,
    paymentMethod: paymentMethod,
    paymentTermRules: paymentTermRules,
    perTypes: perTypes,
    priceChangeTypes: priceChangeTypes,
    returnTypes: returnTypes,
    transactionTypes: transactionTypes,
    unitConvertTypes: unitConvertTypes,
    unitSpaceLabels: unitSpaceLabels,
    unitWeightLabels: unitWeightLabels,
    priceEndTypes: priceEndTypes,
    branchStatus: branchStatus,
    branchTypes: branchTypes,
    businessSectors: businessSectors,
    businessStaffRoles: businessStaffRoles,
    businessStatus: businessStatus,
    contractDocTypes: contractDocTypes,
    equityTypes: equityTypes,
    invitationStatus: invitationStatus,
    invitationTypes: invitationTypes,
    legalEntityTypes: legalEntityTypes,
    partnerClassifications: partnerClassifications,
    partnerRegisterStatus: partnerRegisterStatus,
    partnerTypes: partnerTypes,
    permissions: permissions,
    productCategoryTypes: productCategoryTypes,
    purchaseTypes: purchaseTypes,
    referenceListTypes: referenceListTypes,
    referenceTypes: referenceTypes,
    serviceCategoryTypes: serviceCategoryTypes,
  );
}

Map<String, dynamic> _$GeneralToJson(General instance) {
  Map<String, dynamic> json = {};

  if (instance.branchStatus != null)
    json['branchStatus'] = instance.branchStatus;
  if (instance.branchTypes != null) json['branchTypes'] = instance.branchTypes;
  if (instance.businessSectors != null)
    json['businessSectors'] = instance.businessSectors;
  if (instance.businessStaffRoles != null)
    json['businessStaffRoles'] = instance.businessStaffRoles;
  if (instance.businessStatus != null)
    json['businessStatus'] = instance.businessStatus;
  if (instance.contractDocTypes != null)
    json['contractDocTypes'] = instance.contractDocTypes;
  if (instance.equityTypes != null) json['equityTypes'] = instance.equityTypes;
  if (instance.invitationStatus != null)
    json['invitationStatus'] = instance.invitationStatus;
  if (instance.invitationTypes != null)
    json['invitationTypes'] = instance.invitationTypes;
  if (instance.legalEntityTypes != null)
    json['legalEntityTypes'] = instance.legalEntityTypes;
  if (instance.partnerClassifications != null)
    json['partnerClassifications'] = instance.partnerClassifications;
  if (instance.partnerRegisterStatus != null)
    json['partnerRegisterStatus'] = instance.partnerRegisterStatus;
  if (instance.partnerTypes != null)
    json['partnerTypes'] = instance.partnerTypes;
  if (instance.permissions != null) json['permissions'] = instance.permissions;
  if (instance.productCategoryTypes != null)
    json['productCategoryTypes'] = instance.productCategoryTypes;
  if (instance.purchaseTypes != null)
    json['purchaseTypes'] = instance.purchaseTypes;
  if (instance.referenceListTypes != null)
    json['referenceListTypes'] = instance.referenceListTypes;
  if (instance.referenceTypes != null)
    json['referenceTypes'] = instance.referenceTypes;
  if (instance.serviceCategoryTypes != null)
    json['serviceCategoryTypes'] = instance.serviceCategoryTypes;

  if (instance.priceEndTypes != null)
    json['priceEndTypes'] = instance.priceEndTypes;
  if (instance.provinces != null) json['provinces'] = instance.provinces;
  if (instance.districts != null) json['districts'] = instance.districts;
  if (instance.khoroos != null) json['khoroos'] = instance.khoroos;
  if (instance.bankAccounts != null)
    json['bankAccounts'] = instance.bankAccounts;
  if (instance.staffs != null) json['staffs'] = instance.staffs;
  if (instance.networks != null) json['networks'] = instance.networks;
  if (instance.currencies != null) json['currencies'] = instance.currencies;
  if (instance.discountTypes != null)
    json['discountTypes'] = instance.discountTypes;
  if (instance.invoiceHistoryTypes != null)
    json['invoiceHistoryTypes'] = instance.invoiceHistoryTypes;
  if (instance.invoiceTypes != null)
    json['invoiceTypes'] = instance.invoiceTypes;
  if (instance.invoicePaymentStatus != null)
    json['invoicePaymentStatus'] = instance.invoicePaymentStatus;
  if (instance.invoiceStatus != null)
    json['invoiceStatus'] = instance.invoiceStatus;
  if (instance.itemStatus != null) json['itemStatus'] = instance.itemStatus;
  if (instance.types != null) json['types'] = instance.types;
  if (instance.numberUnits != null) json['numberUnits'] = instance.numberUnits;
  if (instance.orderConfirmTerms != null)
    json['orderConfirmTerms'] = instance.orderConfirmTerms;
  if (instance.overDueStatus != null)
    json['overDueStatus'] = instance.overDueStatus;
  if (instance.paymentMethod != null)
    json['paymentMethod'] = instance.paymentMethod;
  if (instance.paymentTermRules != null)
    json['paymentTermRules'] = instance.paymentTermRules;
  if (instance.perTypes != null) json['perTypes'] = instance.perTypes;
  if (instance.priceChangeTypes != null)
    json['priceChangeTypes'] = instance.priceChangeTypes;
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
