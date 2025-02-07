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
    programParticipantStatus: json['programParticipantStatus'] != null
        ? (json['programParticipantStatus'] as List)
            .map((e) => ProgramParticipantStatus.fromJson(e))
            .toList()
        : null,
    stockMovementTypes: json['stockMovementTypes'] != null
        ? (json['stockMovementTypes'] as List)
            .map((e) => StockMovementTypes.fromJson(e))
            .toList()
        : null,
    networkDiscountTypes: json['networkDiscountTypes'] != null
        ? (json['networkDiscountTypes'] as List)
            .map((e) => NetworkTypes.fromJson(e))
            .toList()
        : null,
    networkPenaltyTypes: json['networkPenaltyTypes'] != null
        ? (json['networkPenaltyTypes'] as List)
            .map((e) => NetworkTypes.fromJson(e))
            .toList()
        : null,
    actions: json['actions'] != null
        ? (json['actions'] as List).map((e) => Actions.fromJson(e)).toList()
        : null,
    financeRoleStatus: json['financeRoleStatus'] != null
        ? (json['financeRoleStatus'] as List)
            .map((e) => FinanceRoleStatus.fromJson(e))
            .toList()
        : null,
    invoiceHistoryLogTypes: json['invoiceHistoryLogTypes'] != null
        ? (json['invoiceHistoryLogTypes'] as List)
            .map((e) => InvoiceHistoryLogTypes.fromJson(e))
            .toList()
        : null,
    settlementStatus: json['settlementStatus'] != null
        ? (json['settlementStatus'] as List)
            .map((e) => SettlementStatus.fromJson(e))
            .toList()
        : null,
    modules: json['modules'] != null
        ? (json['modules'] as List).map((e) => Modules.fromJson(e)).toList()
        : null,
    roles: json['roles'] != null
        ? (json['roles'] as List).map((e) => Roles.fromJson(e)).toList()
        : null,
    userRoleTypes: json['userRoleTypes'] != null
        ? (json['userRoleTypes'] as List).map((e) => Roles.fromJson(e)).toList()
        : null,
    roleTypes: json['roleTypes'] != null
        ? (json['roleTypes'] as List).map((e) => RoleTypes.fromJson(e)).toList()
        : null,
    accessLevels: json['accessLevels'] != null
        ? (json['accessLevels'] as List)
            .map((e) => AccessLevels.fromJson(e))
            .toList()
        : null,
    systemUsageTypes: json['systemUsageTypes'] != null
        ? (json['systemUsageTypes'] as List)
            .map((e) => SystemUsageType.fromJson(e))
            .toList()
        : null,
    businesses: json['businesses'] != null
        ? (json['businesses'] as List).map((e) => User.fromJson(e)).toList()
        : null,
    branches: json['branches'] != null
        ? (json['branches'] as List).map((e) => User.fromJson(e)).toList()
        : null,
    roleStatus: json['roleStatus'] != null
        ? (json['roleStatus'] as List)
            .map((e) => RoleStatus.fromJson(e))
            .toList()
        : null,
    priceGroupTypes: json['priceGroupTypes'] != null
        ? (json['priceGroupTypes'] as List)
            .map((e) => PriceGroupTypes.fromJson(e))
            .toList()
        : null,
    userRegisterStatus: json['userRegisterStatus'] != null
        ? (json['userRegisterStatus'] as List)
            .map((e) => UserRegisterStatus.fromJson(e))
            .toList()
        : null,
    userStatus: json['userStatus'] != null
        ? (json['userStatus'] as List)
            .map((e) => UserStatus.fromJson(e))
            .toList()
        : null,
    partnerCategories: json['partnerCategories'] != null
        ? (json['partnerCategories'] as List).map((e) => e as String).toList()
        : null,
    partnerStaffs: json['partnerStaffs'] != null
        ? (json['partnerStaffs'] as List)
            .map((e) => PartnerStaffs.fromJson(e))
            .toList()
        : null,
    departmentUnits: json['departmentUnits'] != null
        ? (json['departmentUnits'] as List)
            .map((e) => DepartmentUnits.fromJson(e))
            .toList()
        : null,
    employeeUnits: json['employeeUnits'] != null
        ? (json['employeeUnits'] as List)
            .map((e) => EmployeeUnits.fromJson(e))
            .toList()
        : null,
    priceGroupStatus: json['priceGroupStatus'] != null
        ? (json['priceGroupStatus'] as List)
            .map((e) => PriceGroupTypes.fromJson(e))
            .toList()
        : null,
    staffs: json['staffs'] != null
        ? (json['staffs'] as List).map((e) => Staffs.fromJson(e)).toList()
        : null,
    programTypes: json['programTypes'] != null
        ? (json['programTypes'] as List)
            .map((e) => ProgramTypes.fromJson(e))
            .toList()
        : null,
    lbfProgramStatus: json['lbfProgramStatus'] != null
        ? (json['lbfProgramStatus'] as List)
            .map((e) => ProgramTypes.fromJson(e))
            .toList()
        : null,
    adjustmentStatus: json['adjustmentStatus'] != null
        ? (json['adjustmentStatus'] as List)
            .map((e) => AdjustmentStatus.fromJson(e))
            .toList()
        : null,
    suppliers: json['suppliers'] != null
        ? (json['suppliers'] as List).map((e) => Suppliers.fromJson(e)).toList()
        : null,
    fieldTypes: json['fieldTypes'] != null
        ? (json['fieldTypes'] as List).map((e) => e as String).toList()
        : null,
    supplierTypes: json['supplierTypes'] != null
        ? (json['supplierTypes'] as List)
            .map((e) => SupplierTypes.fromJson(e))
            .toList()
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
    warehouseStatus: json['warehouseStatus'] != null
        ? (json['warehouseStatus'] as List)
            .map((e) => WarehouseStatus.fromJson(e))
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
    vatTypes: json['vatTypes'] != null
        ? (json['vatTypes'] as List).map((e) => VatTypes.fromJson(e)).toList()
        : null,
    repaymentStatus: json['repaymentStatus'] != null
        ? (json['repaymentStatus'] as List)
            .map((e) => RepaymentStatus.fromJson(e))
            .toList()
        : null,
    repaymentPaymentStatus: json['repaymentPaymentStatus'] != null
        ? (json['repaymentPaymentStatus'] as List)
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
    units: json['units'] != null
        ? (json['units'] as List).map((e) => Units.fromJson(e)).toList()
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
    countries: json['countries'] != null
        ? (json['countries'] as List).map((e) => Countries.fromJson(e)).toList()
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
    overdueStatus: json['overdueStatus'] != null
        ? (json['overdueStatus'] as List)
            .map((e) => OverDueStatus.fromJson(e))
            .toList()
        : null,
    paymentMethod: json['paymentMethod'] != null
        ? (json['paymentMethod'] as List)
            .map((e) => PaymentMethod.fromJson(e))
            .toList()
        : null,
    paymentMethods: json['paymentMethods'] != null
        ? (json['paymentMethods'] as List)
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
    productBuyerFeeRules: json['productBuyerFeeRules'] != null
        ? (json['productBuyerFeeRules'] as List)
            .map((e) => ProductBuyerFeeRules.fromJson(e))
            .toList()
        : null,
    productSuppFeeRules: json['productSuppFeeRules'] != null
        ? (json['productSuppFeeRules'] as List)
            .map((e) => ProductSuppFeeRules.fromJson(e))
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
    supplierBusinesses: json['supplierBusinesses'] != null
        ? (json['supplierBusinesses'] as List)
            .map((e) => SupplierBusinesses.fromJson(e))
            .toList()
        : null,
    tiers: json['tiers'] != null
        ? (json['tiers'] as List)
            .map((e) => InventoryGoods.fromJson(e))
            .toList()
        : null,
    productSuppPenaltyTypes: json['productSuppPenaltyTypes'] != null
        ? (json['productSuppPenaltyTypes'] as List)
            .map((e) => ProductSuppPenaltyTypes.fromJson(e))
            .toList()
        : null,
    productBuyerPenaltyTypes: json['productBuyerPenaltyTypes'] != null
        ? (json['productBuyerPenaltyTypes'] as List)
            .map((e) => ProductBuyerPenaltyTypes.fromJson(e))
            .toList()
        : null,
  );
}

Map<String, dynamic> _$GeneralToJson(General instance) {
  Map<String, dynamic> json = {};

  if (instance.productSuppPenaltyTypes != null) {
    json['productSuppPenaltyTypes'] = instance.productSuppPenaltyTypes;
  }
  if (instance.networkDiscountTypes != null) {
    json['networkDiscountTypes'] = instance.networkDiscountTypes;
  }
  if (instance.networkPenaltyTypes != null) {
    json['networkPenaltyTypes'] = instance.networkPenaltyTypes;
  }
  if (instance.programParticipantStatus != null) {
    json['programParticipantStatus'] = instance.programParticipantStatus;
  }
  if (instance.invoiceHistoryLogTypes != null) {
    json['invoiceHistoryLogTypes'] = instance.invoiceHistoryLogTypes;
  }
  if (instance.financeRoleStatus != null) {
    json['financeRoleStatus'] = instance.financeRoleStatus;
  }
  if (instance.accessLevels != null) {
    json['accessLevels'] = instance.accessLevels;
  }
  if (instance.settlementStatus != null) {
    json['settlementStatus'] = instance.settlementStatus;
  }
  if (instance.systemUsageTypes != null) {
    json['systemUsageTypes'] = instance.systemUsageTypes;
  }
  if (instance.roleStatus != null) {
    json['roleStatus'] = instance.roleStatus;
  }
  if (instance.userRoleTypes != null) {
    json['userRoleTypes'] = instance.userRoleTypes;
  }
  if (instance.roleTypes != null) {
    json['roleTypes'] = instance.roleTypes;
  }
  if (instance.departmentUnits != null) {
    json['departmentUnits'] = instance.departmentUnits;
  }
  if (instance.employeeUnits != null) {
    json['employeeUnits'] = instance.employeeUnits;
  }
  if (instance.partnerCategories != null) {
    json['partnerCategories'] = instance.partnerCategories;
  }
  if (instance.partnerStaffs != null) {
    json['partnerStaffs'] = instance.partnerStaffs;
  }
  if (instance.warehouseStatus != null) {
    json['warehouseStatus'] = instance.warehouseStatus;
  }
  if (instance.stockMovementTypes != null) {
    json['stockMovementTypes'] = instance.stockMovementTypes;
  }
  if (instance.priceGroupTypes != null) {
    json['priceGroupTypes'] = instance.priceGroupTypes;
  }
  if (instance.priceGroupStatus != null) {
    json['priceGroupStatus'] = instance.priceGroupStatus;
  }
  if (instance.repaymentPaymentStatus != null) {
    json['repaymentPaymentStatus'] = instance.repaymentPaymentStatus;
  }
  if (instance.productBuyerPenaltyTypes != null) {
    json['productBuyerPenaltyTypes'] = instance.productBuyerPenaltyTypes;
  }
  if (instance.programTypes != null) {
    json['programTypes'] = instance.programTypes;
  }
  if (instance.lbfProgramStatus != null) {
    json['lbfProgramStatus'] = instance.lbfProgramStatus;
  }
  if (instance.userStatus != null) json['userStatus'] = instance.userStatus;

  if (instance.userRegisterStatus != null) {
    json['userRegisterStatus'] = instance.userRegisterStatus;
  }
  if (instance.adjustmentStatus != null) {
    json['adjustmentStatus'] = instance.adjustmentStatus;
  }
  if (instance.tiers != null) json['tiers'] = instance.tiers;
  if (instance.actions != null) json['actions'] = instance.actions;
  if (instance.modules != null) json['modules'] = instance.modules;
  if (instance.roles != null) json['roles'] = instance.roles;
  if (instance.branches != null) json['branches'] = instance.branches;
  if (instance.businesses != null) json['businesses'] = instance.businesses;
  if (instance.vatTypes != null) json['vatTypes'] = instance.vatTypes;
  if (instance.fieldTypes != null) json['fieldTypes'] = instance.fieldTypes;
  if (instance.suppliers != null) json['suppliers'] = instance.suppliers;
  if (instance.countries != null) json['countries'] = instance.countries;
  if (instance.supplierTypes != null) {
    json['supplierTypes'] = instance.supplierTypes;
  }
  if (instance.scfRequestTypes != null) {
    json['scfRequestTypes'] = instance.scfRequestTypes;
  }
  if (instance.invoiceOverdueStatus != null) {
    json['invoiceOverdueStatus'] = instance.invoiceOverdueStatus;
  }
  if (instance.supplierBusinesses != null) {
    json['supplierBusinesses'] = instance.supplierBusinesses;
  }
  if (instance.zipCodes != null) json['zipCodes'] = instance.zipCodes;
  if (instance.scfRequestStatus != null) {
    json['scfRequestStatus'] = instance.scfRequestStatus;
  }
  if (instance.paymentTermConditions != null) {
    json['paymentTermConditions'] = instance.paymentTermConditions;
  }
  if (instance.repaymentStatus != null) {
    json['repaymentStatus'] = instance.repaymentStatus;
  }
  if (instance.paymentTermConfigTypes != null) {
    json['paymentTermConfigTypes'] = instance.paymentTermConfigTypes;
  }
  if (instance.bankNames != null) json['bankNames'] = instance.bankNames;
  if (instance.pullSheetStatus != null) {
    json['pullSheetStatus'] = instance.pullSheetStatus;
  }
  if (instance.units != null) json['units'] = instance.units;
  if (instance.orderStatus != null) json['orderStatus'] = instance.orderStatus;
  if (instance.deliveryNoteStatus != null) {
    json['deliveryNoteStatus'] = instance.deliveryNoteStatus;
  }
  if (instance.distributionAreas != null) {
    json['distributionAreas'] = instance.distributionAreas;
  }
  if (instance.branchStatus != null) {
    json['branchStatus'] = instance.branchStatus;
  }
  if (instance.branchTypes != null) json['branchTypes'] = instance.branchTypes;
  if (instance.businessSectors != null) {
    json['businessSectors'] = instance.businessSectors;
  }
  if (instance.businessStaffRoles != null) {
    json['businessStaffRoles'] = instance.businessStaffRoles;
  }
  if (instance.businessStatus != null) {
    json['businessStatus'] = instance.businessStatus;
  }
  if (instance.contractDocTypes != null) {
    json['contractDocTypes'] = instance.contractDocTypes;
  }
  if (instance.equityTypes != null) json['equityTypes'] = instance.equityTypes;
  if (instance.invitationStatus != null) {
    json['invitationStatus'] = instance.invitationStatus;
  }
  if (instance.invitationTypes != null) {
    json['invitationTypes'] = instance.invitationTypes;
  }
  if (instance.legalEntityTypes != null) {
    json['legalEntityTypes'] = instance.legalEntityTypes;
  }
  if (instance.partnerClassifications != null) {
    json['partnerClassifications'] = instance.partnerClassifications;
  }
  if (instance.partnerRegisterStatus != null) {
    json['partnerRegisterStatus'] = instance.partnerRegisterStatus;
  }
  if (instance.partnerTypes != null) {
    json['partnerTypes'] = instance.partnerTypes;
  }
  if (instance.permissions != null) json['permissions'] = instance.permissions;
  if (instance.productCategoryTypes != null) {
    json['productCategoryTypes'] = instance.productCategoryTypes;
  }
  if (instance.purchaseTypes != null) {
    json['purchaseTypes'] = instance.purchaseTypes;
  }
  if (instance.referenceListTypes != null) {
    json['referenceListTypes'] = instance.referenceListTypes;
  }
  if (instance.referenceTypes != null) {
    json['referenceTypes'] = instance.referenceTypes;
  }
  if (instance.serviceCategoryTypes != null) {
    json['serviceCategoryTypes'] = instance.serviceCategoryTypes;
  }

  if (instance.priceEndTypes != null) {
    json['priceEndTypes'] = instance.priceEndTypes;
  }
  if (instance.provinces != null) json['provinces'] = instance.provinces;
  if (instance.districts != null) json['districts'] = instance.districts;
  if (instance.khoroos != null) json['khoroos'] = instance.khoroos;
  if (instance.bankAccounts != null) {
    json['bankAccounts'] = instance.bankAccounts;
  }
  if (instance.staffs != null) json['staffs'] = instance.staffs;
  // if (instance.networks != null) json['networks'] = instance.networks;
  if (instance.currencies != null) json['currencies'] = instance.currencies;
  if (instance.discountTypes != null) {
    json['discountTypes'] = instance.discountTypes;
  }
  if (instance.invoiceHistoryTypes != null) {
    json['invoiceHistoryTypes'] = instance.invoiceHistoryTypes;
  }
  if (instance.invoiceTypes != null) {
    json['invoiceTypes'] = instance.invoiceTypes;
  }
  if (instance.invoicePaymentStatus != null) {
    json['invoicePaymentStatus'] = instance.invoicePaymentStatus;
  }
  if (instance.invoiceStatus != null) {
    json['invoiceStatus'] = instance.invoiceStatus;
  }
  if (instance.itemStatus != null) json['itemStatus'] = instance.itemStatus;
  if (instance.types != null) json['types'] = instance.types;
  if (instance.numberUnits != null) json['numberUnits'] = instance.numberUnits;
  if (instance.orderConfirmTerms != null) {
    json['orderConfirmTerms'] = instance.orderConfirmTerms;
  }
  if (instance.overdueStatus != null) {
    json['overdueStatus'] = instance.overdueStatus;
  }
  if (instance.paymentMethod != null) {
    json['paymentMethod'] = instance.paymentMethod;
  }
  if (instance.paymentMethods != null) {
    json['paymentMethods'] = instance.paymentMethods;
  }
  if (instance.paymentTermRules != null) {
    json['paymentTermRules'] = instance.paymentTermRules;
  }
  if (instance.perTypes != null) json['perTypes'] = instance.perTypes;
  if (instance.priceChangeTypes != null) {
    json['priceChangeTypes'] = instance.priceChangeTypes;
  }
  if (instance.returnTypes != null) json['returnTypes'] = instance.returnTypes;
  if (instance.transactionTypes != null) {
    json['transactionTypes'] = instance.transactionTypes;
  }
  if (instance.unitConvertTypes != null) {
    json['unitConvertTypes'] = instance.unitConvertTypes;
  }
  if (instance.unitSpaceLabels != null) {
    json['unitSpaceLabels'] = instance.unitSpaceLabels;
  }
  if (instance.unitWeightLabels != null) {
    json['unitWeightLabels'] = instance.unitWeightLabels;
  }

  return json;
}
