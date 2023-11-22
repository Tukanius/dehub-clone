part of "../models/general.dart";

General _$GeneralFromJson(Map<String, dynamic> json) {
  return General(
    provinces: json['provinces'] != null
        ? (json['provinces'] as List).map((e) => Provinces.fromJson(e)).toList()
        : null,
    districts: json['districts'] != null
        ? (json['districts'] as List).map((e) => Districts.fromJson(e)).toList()
        : null,
    khoroos: json['khoroos'] != null
        ? (json['khoroos'] as List).map((e) => Khoroos.fromJson(e)).toList()
        : null,
    bankAccounts: json['bankAccounts'] != null
        ? (json['bankAccounts'] as List)
            .map((e) => BankAccounts.fromJson(e))
            .toList()
        : null,
    staffs: json['staffs'] != null
        ? (json['staffs'] as List).map((e) => Staffs.fromJson(e)).toList()
        : null,
    repaymentOverDueStatus: json['repaymentOverDueStatus'] != null
        ? (json['repaymentOverDueStatus'] as List)
            .map((e) => RepaymentOverDueStatus.fromJson(e))
            .toList()
        : null,
    scfRequestStatus: json['scfRequestStatus'] != null
        ? (json['scfRequestStatus'] as List)
            .map((e) => RequestStatus.fromJson(e))
            .toList()
        : null,
    orderStatus: json['orderStatus'] != null
        ? (json['orderStatus'] as List)
            .map((e) => OrderStatus.fromJson(e))
            .toList()
        : null,
    // networks: json['networks'] != null
    //     ? (json['networks'] as List).map((e) => Networks.fromJson(e)).toList()
    //     : null,
    currencies: json['currencies'] != null
        ? (json['currencies'] as List)
            .map((e) => Currencies.fromJson(e))
            .toList()
        : null,
    repaymentStatus: json['repaymentStatus'] != null
        ? (json['repaymentStatus'] as List)
            .map((e) => RepaymentStatus.fromJson(e))
            .toList()
        : null,
    scfRequestTypes: json['scfRequestTypes'] != null
        ? (json['scfRequestTypes'] as List)
            .map((e) => RequestTypes.fromJson(e))
            .toList()
        : null,
    invoiceOverdueStatus: json['invoiceOverdueStatus'] != null
        ? (json['invoiceOverdueStatus'] as List)
            .map((e) => InvoiceOverdueStatus.fromJson(e))
            .toList()
        : null,
    paymentTermConfigTypes: json['paymentTermConfigTypes'] != null
        ? (json['paymentTermConfigTypes'] as List)
            .map((e) => PaymentTermConfigTypes.fromJson(e))
            .toList()
        : null,
    paymentTermConditions: json['paymentTermConditions'] != null
        ? (json['paymentTermConditions'] as List)
            .map((e) => PaymentTermConditions.fromJson(e))
            .toList()
        : null,
    discountTypes: json['discountTypes'] != null
        ? (json['discountTypes'] as List)
            .map((e) => DiscountTypes.fromJson(e))
            .toList()
        : null,
    invoiceHistoryTypes: json['invoiceHistoryTypes'] != null
        ? (json['invoiceHistoryTypes'] as List)
            .map((e) => InvoiceHistoryTypes.fromJson(e))
            .toList()
        : null,
    invoiceTypes: json['invoiceTypes'] != null
        ? (json['invoiceTypes'] as List)
            .map((e) => InvoiceTypes.fromJson(e))
            .toList()
        : null,
    invoicePaymentStatus: json['invoicePaymentStatus'] != null
        ? (json['invoicePaymentStatus'] as List)
            .map((e) => InvoicePaymentStatus.fromJson(e))
            .toList()
        : null,
    invoiceStatus: json['invoiceStatus'] != null
        ? (json['invoiceStatus'] as List)
            .map((e) => InvoiceStatus.fromJson(e))
            .toList()
        : null,
    itemStatus: json['itemStatus'] != null
        ? (json['itemStatus'] as List)
            .map((e) => ItemStatus.fromJson(e))
            .toList()
        : null,
    types: json['types'] != null
        ? (json['types'] as List).map((e) => Types.fromJson(e)).toList()
        : null,
    numberUnits: json['numberUnits'] != null
        ? (json['numberUnits'] as List)
            .map((e) => NumberUnits.fromJson(e))
            .toList()
        : null,
    orderConfirmTerms: json['orderConfirmTerms'] != null
        ? (json['orderConfirmTerms'] as List)
            .map((e) => OrderConfirmTerms.fromJson(e))
            .toList()
        : null,
    overDueStatus: json['overDueStatus'] != null
        ? (json['overDueStatus'] as List)
            .map((e) => OverDueStatus.fromJson(e))
            .toList()
        : null,
    paymentMethod: json['paymentMethod'] != null
        ? (json['paymentMethod'] as List)
            .map((e) => PaymentMethod.fromJson(e))
            .toList()
        : null,
    paymentTermRules: json['paymentTermRules'] != null
        ? (json['paymentTermRules'] as List)
            .map((e) => PaymentTermRules.fromJson(e))
            .toList()
        : null,
    perTypes: json['perTypes'] != null
        ? (json['perTypes'] as List).map((e) => PerTypes.fromJson(e)).toList()
        : null,
    priceChangeTypes: json['priceChangeTypes'] != null
        ? (json['priceChangeTypes'] as List)
            .map((e) => PriceChangeTypes.fromJson(e))
            .toList()
        : null,
    returnTypes: json['returnTypes'] != null
        ? (json['returnTypes'] as List)
            .map((e) => ReturnTypes.fromJson(e))
            .toList()
        : null,
    transactionTypes: json['transactionTypes'] != null
        ? (json['transactionTypes'] as List)
            .map((e) => TransactionTypes.fromJson(e))
            .toList()
        : null,
    unitConvertTypes: json['unitConvertTypes'] != null
        ? (json['unitConvertTypes'] as List)
            .map((e) => UnitConvertTypes.fromJson(e))
            .toList()
        : null,
    unitSpaceLabels: json['unitSpaceLabels'] != null
        ? (json['unitSpaceLabels'] as List)
            .map((e) => UnitSpaceLabels.fromJson(e))
            .toList()
        : null,
    unitWeightLabels: json['unitWeightLabels'] != null
        ? (json['unitWeightLabels'] as List)
            .map((e) => UnitWeightLabels.fromJson(e))
            .toList()
        : null,
    priceEndTypes: json['priceEndTypes'] != null
        ? (json['priceEndTypes'] as List)
            .map((e) => PriceEndTypes.fromJson(e))
            .toList()
        : null,
    branchStatus: json['branchStatus'] != null
        ? (json['branchStatus'] as List)
            .map((e) => BranchStatus.fromJson(e))
            .toList()
        : null,
    branchTypes: json['branchTypes'] != null
        ? (json['branchTypes'] as List)
            .map((e) => BranchTypes.fromJson(e))
            .toList()
        : null,
    businessSectors: json['businessSectors'] != null
        ? (json['businessSectors'] as List)
            .map((e) => BusinessSectors.fromJson(e))
            .toList()
        : null,
    businessStaffRoles: json['businessStaffRoles'] != null
        ? (json['businessStaffRoles'] as List)
            .map((e) => BusinessStaffRoles.fromJson(e))
            .toList()
        : null,
    businessStatus: json['businessStatus'] != null
        ? (json['businessStatus'] as List)
            .map((e) => BusinessStatus.fromJson(e))
            .toList()
        : null,
    contractDocTypes: json['contractDocTypes'] != null
        ? (json['contractDocTypes'] as List)
            .map((e) => ContractDocTypes.fromJson(e))
            .toList()
        : null,
    equityTypes: json['equityTypes'] != null
        ? (json['equityTypes'] as List)
            .map((e) => EquityTypes.fromJson(e))
            .toList()
        : null,
    invitationStatus: json['invitationStatus'] != null
        ? (json['invitationStatus'] as List)
            .map((e) => InvitationStatus.fromJson(e))
            .toList()
        : null,
    invitationTypes: json['invitationTypes'] != null
        ? (json['invitationTypes'] as List)
            .map((e) => InvitationTypes.fromJson(e))
            .toList()
        : null,
    legalEntityTypes: json['legalEntityTypes'] != null
        ? (json['legalEntityTypes'] as List)
            .map((e) => LegalEntityTypes.fromJson(e))
            .toList()
        : null,
    partnerClassifications: json['partnerClassifications'] != null
        ? (json['partnerClassifications'] as List)
            .map((e) => PartnerClassifications.fromJson(e))
            .toList()
        : null,
    partnerRegisterStatus: json['partnerRegisterStatus'] != null
        ? (json['partnerRegisterStatus'] as List)
            .map((e) => PartnerRegisterStatus.fromJson(e))
            .toList()
        : null,
    partnerTypes: json['partnerTypes'] != null
        ? (json['partnerTypes'] as List)
            .map((e) => PartnerTypes.fromJson(e))
            .toList()
        : null,
    permissions: json['permissions'] != null
        ? (json['permissions'] as List)
            .map((e) => Permissions.fromJson(e))
            .toList()
        : null,
    productCategoryTypes: json['productCategoryTypes'] != null
        ? (json['productCategoryTypes'] as List)
            .map((e) => ProductCategoryTypes.fromJson(e))
            .toList()
        : null,
    purchaseTypes: json['purchaseTypes'] != null
        ? (json['purchaseTypes'] as List)
            .map((e) => PurchaseTypes.fromJson(e))
            .toList()
        : null,
    // referenceListTypes: json['referenceListTypes'] != null
    //     ? ReferenceListTypes.fromJson(
    //         json['referenceListTypes'] as Map<String, dynamic>)
    //     : null,
    referenceTypes: json['referenceTypes'] != null
        ? (json['referenceTypes'] as List)
            .map((e) => ReferenceTypes.fromJson(e))
            .toList()
        : null,
    serviceCategoryTypes: json['serviceCategoryTypes'] != null
        ? (json['serviceCategoryTypes'] as List)
            .map((e) => ServiceCategoryTypes.fromJson(e))
            .toList()
        : null,
    distributionAreas: json['distributionAreas'] != null
        ? (json['distributionAreas'] as List)
            .map((e) => DistributionAreas.fromJson(e))
            .toList()
        : null,
    clientClassifications: json['clientClassifications'] != null
        ? (json['clientClassifications'] as List)
            .map((e) => ClientClassifications.fromJson(e))
            .toList()
        : null,

    deliveryNoteStatus: json['deliveryNoteStatus'] != null
        ? (json['deliveryNoteStatus'] as List)
            .map((e) => DeliveryNoteStatus.fromJson(e))
            .toList()
        : null,
    pullSheetStatus: json['pullSheetStatus'] != null
        ? (json['pullSheetStatus'] as List)
            .map((e) => PullSheetStatus.fromJson(e))
            .toList()
        : null,
    bankNames: json['bankNames'] != null
        ? (json['bankNames'] as List).map((e) => BankNames.fromJson(e)).toList()
        : null,
    zipCodes: json['zipCodes'] != null
        ? (json['zipCodes'] as List).map((e) => ZipCodes.fromJson(e)).toList()
        : null,
  );
}

Map<String, dynamic> _$GeneralToJson(General instance) {
  Map<String, dynamic> json = {};

  if (instance.scfRequestTypes != null)
    json['scfRequestTypes'] = instance.scfRequestTypes;
  if (instance.invoiceOverdueStatus != null)
    json['invoiceOverdueStatus'] = instance.invoiceOverdueStatus;
  if (instance.zipCodes != null) json['zipCodes'] = instance.zipCodes;
  if (instance.scfRequestStatus != null)
    json['scfRequestStatus'] = instance.scfRequestStatus;
  if (instance.paymentTermConditions != null)
    json['paymentTermConditions'] = instance.paymentTermConditions;
  if (instance.repaymentStatus != null)
    json['repaymentStatus'] = instance.repaymentStatus;
  if (instance.paymentTermConfigTypes != null)
    json['paymentTermConfigTypes'] = instance.paymentTermConfigTypes;
  if (instance.bankNames != null) json['bankNames'] = instance.bankNames;
  if (instance.pullSheetStatus != null)
    json['pullSheetStatus'] = instance.pullSheetStatus;
  if (instance.orderStatus != null) json['orderStatus'] = instance.orderStatus;
  if (instance.deliveryNoteStatus != null)
    json['deliveryNoteStatus'] = instance.deliveryNoteStatus;
  if (instance.distributionAreas != null)
    json['distributionAreas'] = instance.distributionAreas;
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
  // if (instance.networks != null) json['networks'] = instance.networks;
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
