import 'package:dehub/models/access_levels.dart';
import 'package:dehub/models/actions.dart';
import 'package:dehub/models/adjustment_status.dart';
import 'package:dehub/models/bank_names.dart';
import 'package:dehub/models/branch_status.dart';
import 'package:dehub/models/business_sectors.dart';
import 'package:dehub/models/business_staff_roles.dart';
import 'package:dehub/models/business_status.dart';
import 'package:dehub/models/client_classification.dart';
import 'package:dehub/models/countries.dart';
import 'package:dehub/models/delivery_note_status.dart';
import 'package:dehub/models/department_units.dart';
import 'package:dehub/models/distribution_areas.dart';
import 'package:dehub/models/employee_units.dart';
import 'package:dehub/models/equity_types.dart';
import 'package:dehub/models/finance_role_status.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/invoice_history_log_types.dart';
import 'package:dehub/models/invoice_over_due_status.dart';
import 'package:dehub/models/modules.dart';
import 'package:dehub/models/order_status.dart';
import 'package:dehub/models/partner_staffs.dart';
import 'package:dehub/models/payment_term_conditions.dart';
import 'package:dehub/models/payment_term_config_types.dart';
import 'package:dehub/models/permissions.dart';
import 'package:dehub/models/price_change_types.dart';
import 'package:dehub/models/price_end_types.dart';
import 'package:dehub/models/per_types.dart';
import 'package:dehub/models/payment_term_rules.dart';
import 'package:dehub/models/payment_method.dart';
import 'package:dehub/models/over_due_status.dart';
import 'package:dehub/models/order_confirm_terms.dart';
import 'package:dehub/models/number_units.dart';
import 'package:dehub/models/item_status.dart';
import 'package:dehub/models/invoice_payment_status.dart';
import 'package:dehub/models/invoice_history_types.dart';
import 'package:dehub/models/invoice_status.dart';
import 'package:dehub/models/price_group_types.dart';
import 'package:dehub/models/product_buyer_fee_rules.dart';
import 'package:dehub/models/product_buyer_penalty_types.dart';
import 'package:dehub/models/product_supp_fee_rules.dart';
import 'package:dehub/models/product_supp_penalty_types.dart';
import 'package:dehub/models/program_types.dart';
import 'package:dehub/models/pull_sheet_status.dart';
import 'package:dehub/models/purchase_types.dart';
import 'package:dehub/models/repayment_over_due_status.dart';
import 'package:dehub/models/repayment_status.dart';
import 'package:dehub/models/request_status.dart';
import 'package:dehub/models/request_types.dart';
import 'package:dehub/models/role_status.dart';
import 'package:dehub/models/role_types.dart';
import 'package:dehub/models/roles.dart';
import 'package:dehub/models/service_category_types.dart';
import 'package:dehub/models/settlement_status.dart';
import 'package:dehub/models/stock_movement_types.dart';
import 'package:dehub/models/supp.dart';
import 'package:dehub/models/supplier_businesses.dart';
import 'package:dehub/models/supplier_types.dart';
import 'package:dehub/models/system_usage_type.dart';
import 'package:dehub/models/types.dart';
import 'package:dehub/models/invoice_types.dart';
import 'package:dehub/models/bank_accounts.dart';
import 'package:dehub/models/discount_types.dart';
import 'package:dehub/models/unit_space_labels.dart';
import 'package:dehub/models/unit_weight_labels.dart';
// import 'package:dehub/models/networks.dart';
import 'package:dehub/models/transaction_types.dart';
import 'package:dehub/models/currencies.dart';
import 'package:dehub/models/staffs.dart';
import 'package:dehub/models/return_types.dart';
import 'package:dehub/models/unit_convert_types.dart';
import 'package:dehub/models/districts.dart';
import 'package:dehub/models/khoroos.dart';
import 'package:dehub/models/provinces.dart';
import 'package:dehub/models/branch_types.dart';
import 'package:dehub/models/contract_doc_types.dart';
import 'package:dehub/models/invitation_status.dart';
import 'package:dehub/models/invitation_types.dart';
import 'package:dehub/models/legal_entity_types.dart';
import 'package:dehub/models/partner_classifications.dart';
import 'package:dehub/models/partner_register_status.dart';
import 'package:dehub/models/partner_types.dart';
import 'package:dehub/models/product_category_types.dart';
import 'package:dehub/models/reference_list_types.dart';
import 'package:dehub/models/reference_types.dart';
import 'package:dehub/models/units.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/models/user_register_status.dart';
import 'package:dehub/models/user_status.dart';
import 'package:dehub/models/vat_types.dart';
import 'package:dehub/models/warehouse_status.dart';
import 'package:dehub/models/zip_codes.dart';
part '../parts/general.dart';

class General {
  List<Provinces>? provinces;
  List<Districts>? districts;
  List<Khoroos>? khoroos;
  List<BankAccounts>? bankAccounts;
  List<Staffs>? staffs;
  // List<Networks>? networks;
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
  List<OverDueStatus>? overdueStatus;
  List<PaymentMethod>? paymentMethod;
  List<PaymentMethod>? paymentMethods;
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
  List<DistributionAreas>? distributionAreas;
  List<ClientClassifications>? clientClassifications;
  List<DeliveryNoteStatus>? deliveryNoteStatus;
  List<PullSheetStatus>? pullSheetStatus;
  List<BankNames>? bankNames;
  List<PaymentTermConfigTypes>? paymentTermConfigTypes;
  List<PaymentTermConditions>? paymentTermConditions;
  List<ZipCodes>? zipCodes;
  List<InvoiceOverdueStatus>? invoiceOverdueStatus;
  List<RequestTypes>? scfRequestTypes;
  List<RequestStatus>? scfRequestStatus;
  List<RepaymentOverDueStatus>? repaymentOverDueStatus;
  List<RepaymentStatus>? repaymentStatus;
  List<OrderStatus>? orderStatus;
  List<ProductBuyerFeeRules>? productBuyerFeeRules;
  List<ProductSuppFeeRules>? productSuppFeeRules;
  List<Countries>? countries;
  List<Units>? units;
  List<Suppliers>? suppliers;
  List<SupplierBusinesses>? supplierBusinesses;
  List<SupplierTypes>? supplierTypes;
  List<VatTypes>? vatTypes;
  List<InventoryGoods>? tiers;
  List<String>? fieldTypes;
  List<ProgramTypes>? programTypes;
  List<ProgramTypes>? lbfProgramStatus;
  List<ProductSuppPenaltyTypes>? productSuppPenaltyTypes;
  List<ProductBuyerPenaltyTypes>? productBuyerPenaltyTypes;
  List<RepaymentStatus>? repaymentPaymentStatus;
  List<StockMovementTypes>? stockMovementTypes;
  List<AdjustmentStatus>? adjustmentStatus;
  List<PriceGroupTypes>? priceGroupTypes;
  List<PriceGroupTypes>? priceGroupStatus;
  List<WarehouseStatus>? warehouseStatus;
  List<PartnerStaffs>? partnerStaffs;
  List<String>? partnerCategories;
  List<DepartmentUnits>? departmentUnits;
  List<EmployeeUnits>? employeeUnits;
  List<UserStatus>? userStatus;
  List<UserRegisterStatus>? userRegisterStatus;
  List<SystemUsageType>? systemUsageTypes;
  List<RoleStatus>? roleStatus;
  List<User>? businesses;
  List<User>? branches;
  List<Roles>? roles;
  List<Roles>? userRoleTypes;
  List<AccessLevels>? accessLevels;
  List<RoleTypes>? roleTypes;
  List<Actions>? actions;
  List<Modules>? modules;
  List<FinanceRoleStatus>? financeRoleStatus;
  List<SettlementStatus>? settlementStatus;
  List<InvoiceHistoryLogTypes>? invoiceHistoryLogTypes;

  General({
    this.invoiceHistoryLogTypes,
    this.settlementStatus,
    this.financeRoleStatus,
    this.modules,
    this.actions,
    this.userRoleTypes,
    this.roleTypes,
    this.accessLevels,
    this.roles,
    this.branches,
    this.businesses,
    this.roleStatus,
    this.systemUsageTypes,
    this.userStatus,
    this.userRegisterStatus,
    this.departmentUnits,
    this.employeeUnits,
    this.partnerCategories,
    this.partnerStaffs,
    this.warehouseStatus,
    this.priceGroupStatus,
    this.priceGroupTypes,
    this.adjustmentStatus,
    this.stockMovementTypes,
    this.lbfProgramStatus,
    this.paymentMethods,
    this.repaymentPaymentStatus,
    this.productSuppPenaltyTypes,
    this.productBuyerPenaltyTypes,
    this.programTypes,
    this.fieldTypes,
    this.tiers,
    this.vatTypes,
    this.supplierTypes,
    this.supplierBusinesses,
    this.suppliers,
    this.units,
    this.countries,
    this.productBuyerFeeRules,
    this.productSuppFeeRules,
    this.orderStatus,
    this.repaymentStatus,
    this.repaymentOverDueStatus,
    this.scfRequestStatus,
    this.scfRequestTypes,
    this.invoiceOverdueStatus,
    this.zipCodes,
    this.paymentTermConditions,
    this.paymentTermConfigTypes,
    this.bankNames,
    this.pullSheetStatus,
    this.deliveryNoteStatus,
    this.clientClassifications,
    this.distributionAreas,
    this.provinces,
    this.districts,
    this.khoroos,
    this.bankAccounts,
    this.staffs,
    // this.networks,
    this.currencies,
    this.discountTypes,
    this.invoiceHistoryTypes,
    this.invoiceTypes,
    this.invoicePaymentStatus,
    this.invoiceStatus,
    this.itemStatus,
    this.types,
    this.numberUnits,
    this.orderConfirmTerms,
    this.overdueStatus,
    this.paymentMethod,
    this.paymentTermRules,
    this.perTypes,
    this.priceChangeTypes,
    this.priceEndTypes,
    this.returnTypes,
    this.transactionTypes,
    this.unitSpaceLabels,
    this.unitWeightLabels,
    this.unitConvertTypes,
    this.branchStatus,
    this.branchTypes,
    this.businessSectors,
    this.businessStaffRoles,
    this.businessStatus,
    this.contractDocTypes,
    this.equityTypes,
    this.invitationStatus,
    this.invitationTypes,
    this.legalEntityTypes,
    this.partnerClassifications,
    this.partnerRegisterStatus,
    this.partnerTypes,
    this.permissions,
    this.productCategoryTypes,
    this.purchaseTypes,
    this.referenceListTypes,
    this.referenceTypes,
    this.serviceCategoryTypes,
  });

  static $fromJson(Map<String, dynamic> json) => _$GeneralFromJson(json);

  factory General.fromJson(Map<String, dynamic> json) =>
      _$GeneralFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralToJson(this);
}
