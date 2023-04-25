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
import 'package:dehub/models/types.dart';
import 'package:dehub/models/invoice_types.dart';
import 'package:dehub/models/bank_accounts.dart';
import 'package:dehub/models/discount_types.dart';
import 'package:dehub/models/unit_space_labels.dart';
import 'package:dehub/models/unit_weight_labels.dart';
import 'package:dehub/models/networks.dart';
import 'package:dehub/models/transaction_types.dart';
import 'package:dehub/models/currencies.dart';
import 'package:dehub/models/staffs.dart';
import 'package:dehub/models/return_types.dart';
import 'package:dehub/models/unit_convert_types.dart';
import 'package:dehub/models/districts.dart';
import 'package:dehub/models/khoroos.dart';
import 'package:dehub/models/provinces.dart';
part '../parts/general.dart';

class General {
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

  General({
    this.provinces,
    this.districts,
    this.khoroos,
    this.bankAccounts,
    this.staffs,
    this.networks,
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
    this.overDueStatus,
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
  });

  static $fromJson(Map<String, dynamic> json) => _$GeneralFromJson(json);

  factory General.fromJson(Map<String, dynamic> json) =>
      _$GeneralFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralToJson(this);
}
