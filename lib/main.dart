import 'package:dehub/components/dashboard_screen/dashboard_screen.dart';
import 'package:dehub/components/full_picture/full_picture.dart';
import 'package:dehub/providers/checkout_provider.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/order_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/providers/user_module_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/camera_page/camera_page.dart';
import 'package:dehub/src/auth/password_recovery/password_recovery.dart';
import 'package:dehub/src/entry_point/finance_entry/finance_entry.dart';
import 'package:dehub/src/finance_module/screens/account_detail_page/account_detail_page.dart';
import 'package:dehub/src/finance_module/screens/available_funding_page/available_funding_page.dart';
import 'package:dehub/src/finance_module/screens/buyer_proposal/buyer_proposal.dart';
import 'package:dehub/src/finance_module/screens/compromise_page/compromise_page.dart';
import 'package:dehub/src/finance_module/screens/finance_qpay/finance_qpay.dart';
import 'package:dehub/src/finance_module/screens/payment_page/payment_page.dart';
import 'package:dehub/src/finance_module/screens/payment_received_funds/payment_received_funds.dart';
import 'package:dehub/src/finance_module/screens/recalled_page/recalled_page.dart';
import 'package:dehub/src/finance_module/screens/set_limit_page/set_limit_page.dart';
import 'package:dehub/src/finance_module/screens/settlement_respond/settlement_respond.dart';
import 'package:dehub/src/invoice_module/screens/payment_register/payment_register.dart';
import 'package:dehub/src/invoice_module/screens/invoice_transaction/invoice_transaction.dart';
import 'package:dehub/src/invoice_module/screens/network_settlement_detail/network_settlement_detail.dart';
import 'package:dehub/src/invoice_module/screens/settlement_detail/settlement_detail.dart';
import 'package:dehub/src/network_module/screens/account_setting/account_setting.dart';
import 'package:dehub/src/network_module/screens/account_setting/account_setting_detail/account_setting_detail.dart';
import 'package:dehub/src/network_module/screens/account_setting/set_account/set_account.dart';
import 'package:dehub/src/network_module/screens/add_cod_term/add_cod_term.dart';
import 'package:dehub/src/order_module/screens/create_back_order/create_back_order.dart';
import 'package:dehub/src/order_module/screens/customers/customers.dart';
import 'package:dehub/src/order_module/screens/delivery_management/delivery_management.dart';
import 'package:dehub/src/order_module/screens/dropship_create/dropship_create.dart';
import 'package:dehub/src/order_module/screens/dropship_order/dropship_order.dart';
import 'package:dehub/src/order_module/screens/set_delivery_distribution/set_delivery_distribution.dart';
import 'package:dehub/src/order_module/screens/shipment_distribution/shipment_distribution.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/partner_profile.dart';
import 'package:dehub/src/partner_module/screens/branch_create/branch_create.dart';
import 'package:dehub/src/partner_module/screens/update_business/update_business.dart';
import 'package:dehub/src/partner_module/screens/warehouse_create/warehouse_create.dart';
import 'package:dehub/src/payment_module/screens/account_statement/account_statement.dart';
import 'package:dehub/src/network_module/screens/client_classifications/client_classification_detail/client_classification_detail.dart';
import 'package:dehub/src/network_module/screens/client_classifications/client_classifications.dart';
import 'package:dehub/src/network_module/screens/client_classifications/set_client_classification/set_client_classification.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/payment_approval_page.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/payment_page.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/qpay_page.dart';
import 'package:dehub/src/auth/no_internet/no_internet_screen.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/repayment_detail.dart';
import 'package:dehub/src/finance_module/screens/repayment_page/repayment_page.dart';
import 'package:dehub/src/payment_module/screens/transaction_detail_page/transaction_detail_page.dart';
import 'package:dehub/src/payment_module/screens/bank_account_detail/bank_account_detail.dart';
import 'package:dehub/src/network_module/screens/distribution_areas/distribution_area_detail/distribution_area_detail.dart';
import 'package:dehub/src/network_module/screens/distribution_areas/distribution_areas.dart';
import 'package:dehub/src/network_module/screens/client_staffs/set_client_staff/set_client_staff.dart';
import 'package:dehub/src/auth/change_password/change_password.dart';
import 'package:dehub/src/entry_point/entry_point.dart';
import 'package:dehub/src/order_module/screens/order_payment_page/order_cbd_payment.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/src/payment_module/payment_page/tabs/add_bank_account_page/add_bank_account_page.dart';
import 'package:dehub/src/auth/check_biometric.dart';
import 'package:dehub/src/auth/financing_login.dart';
import 'package:dehub/src/auth/login_page.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/avaible_funding_detail_page.dart';
import 'package:dehub/src/finance_module/screens/program_page/program_page.dart';
import 'package:dehub/src/debt_module/debt_page/debt_page.dart';
import 'package:dehub/src/auth/enter_phone_page/enter_phone_page.dart';
import 'package:dehub/src/order_module/screens/expenses_page/expenses_page.dart';
import 'package:dehub/src/finance_module/financing_page/financing_page.dart';
import 'package:dehub/src/finance_module/screens/funding_request_detail/funding_request_detail_page.dart';
import 'package:dehub/src/invoice_module/screens/closed_invoice/closed_invoice_page.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/add_product/add_product.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/add_row/invoice_add_row.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/sector-choose/sector_choose.dart';
import 'package:dehub/src/invoice_module/screens/invoice_list/invoice_list.dart';
import 'package:dehub/src/network_module/screens/category_page/add_category.dart';
import 'package:dehub/src/network_module/screens/direction_page/add_direction.dart';
import 'package:dehub/src/network_module/screens/direction_page/direction_detail_page.dart';
import 'package:dehub/src/network_module/screens/invoice_condition_page/invoice_condition_detail_page.dart';
import 'package:dehub/src/network_module/screens/invoice_condition_page/invoice_condition_page.dart';
import 'package:dehub/src/network_module/screens/invoice_condition_page/new_condition_page.dart';
import 'package:dehub/src/network_module/screens/category_page/category_detail_page.dart';
import 'package:dehub/src/network_module/screens/rank_page/add_rank.dart';
import 'package:dehub/src/network_module/screens/rank_page/rank_detail_page.dart';
import 'package:dehub/src/network_module/screens/reference_information_page/reference_information_page.dart';
import 'package:dehub/src/network_module/screens/partner_page/partner_detail_page/partner_detail_page.dart';
import 'package:dehub/src/network_module/screens/partner_page/partner_page.dart';
import 'package:dehub/src/network_module/screens/zoning_page/add_zoning.dart';
import 'package:dehub/src/network_module/screens/zoning_page/zoning_detail_page.dart';
import 'package:dehub/src/network_module/screens/new_invitation_page/invitation_sent_page/invitation_sent_page.dart';
import 'package:dehub/src/network_module/screens/new_invitation_page/new_invitation_page.dart';
import 'package:dehub/src/network_module/screens/invitation_detail_page/invitation_detail_page.dart';
import 'package:dehub/src/invoice_module/main_page/invoice_page.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/customer_choose/customer_choose.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/customer_choose/salbar_songoh.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/harah.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/new_invoice.dart';
import 'package:dehub/src/invoice_module/screens/invoice_detail_page/invoice_detail_page.dart';
import 'package:dehub/src/payment_module/screens/link_account_page/link_account_page.dart';
import 'package:dehub/src/entry_point/menu/menu_page.dart';
import 'package:dehub/src/network_module/network_page/network_page.dart';
import 'package:dehub/src/network_module/screens/sent_invitation_detail/sent_invitation_detail_page.dart';
import 'package:dehub/src/order_module/screens/new_order/add_attachment/add_attachment.dart';
import 'package:dehub/src/order_module/screens/new_order/add_row/order_add_row.dart';
import 'package:dehub/src/order_module/screens/new_order/change_branch/change_branch_name.dart';
import 'package:dehub/src/order_module/screens/new_order/new_order.dart';
import 'package:dehub/src/order_module/screens/new_order/order_send/order_send_customer.dart';
import 'package:dehub/src/order_module/screens/new_order/order_send/order_send_page.dart';
import 'package:dehub/src/order_module/screens/new_order/product_choose/product_choose.dart';
import 'package:dehub/src/order_module/screens/order_cash_approval/order_cash_approval.dart';
import 'package:dehub/src/order_module/screens/delivery_detail/delivery_detail.dart';
import 'package:dehub/src/order_module/screens/order_delivery/order_delivery.dart';
import 'package:dehub/src/order_module/screens/order_delivery/delivery/delivery.dart';
import 'package:dehub/src/order_module/screens/order_invoice/order_invoice.dart';
import 'package:dehub/src/order_module/order_page/order_page.dart';
import 'package:dehub/src/order_module/screens/order_cash_payment/order_cash_payment.dart';
import 'package:dehub/src/order_module/screens/order_payment_page/order_cod_payment.dart';
import 'package:dehub/src/order_module/screens/order_shipment/order_shipment.dart';
import 'package:dehub/src/order_module/screens/order_shipping/order_shipping.dart';
import 'package:dehub/src/auth/otp_page/create_password.dart';
import 'package:dehub/src/auth/otp_page/otp_phone_verify.dart';
import 'package:dehub/src/auth/otp_page/otp_page.dart';
import 'package:dehub/src/partner_module/partner_page/partner_page.dart';
import 'package:dehub/src/payment_module/payment_page/payment_page.dart';
import 'package:dehub/src/auth/pin_code/new_pin.dart';
import 'package:dehub/src/auth/pin_code/pin_code.dart';
import 'package:dehub/src/auth/pin_code/pin_confirmation.dart';
import 'package:dehub/src/order_module/screens/product_give/product_give.dart';
import 'package:dehub/src/product_module/product_page/product_page.dart';
import 'package:dehub/src/product_module/screens/adjustment/adjustment.dart';
import 'package:dehub/src/product_module/screens/change_standard_price/change_standard_price.dart';
import 'package:dehub/src/product_module/screens/goods_price_change_history/goods_price_change_history.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/adjustment_note/adjustment_note.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/brand/brand.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/classification/inventory_classification.dart';
import 'package:dehub/src/product_module/screens/create_sub_category/create_sub_category.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/delivery_type/delivery_type.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/distributor/distributor.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/dynamic_information/dynamic_information.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/inactive_types/inactive_types.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/inventory_reference.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/item_type/inventory_item_type.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/manufacturer/manufacturer.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/options/options.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/package_type/package_type.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/price_tiers/price_tiers.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/tag/tag.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/unit/unit.dart';
import 'package:dehub/src/product_module/screens/new_product/new_product.dart';
import 'package:dehub/src/product_module/screens/price_group/price_group.dart';
import 'package:dehub/src/product_module/screens/price_history_detail/price_group_detail.dart';
import 'package:dehub/src/product_module/screens/product_detail_page/product_detail_page.dart';
import 'package:dehub/src/product_module/screens/product_list_page/product_list_page.dart';
import 'package:dehub/src/order_module/screens/pull_sheet_expenses/pull_sheet_expenses.dart';
import 'package:dehub/src/finance_module/screens/received_funding_detail/received_funding_detail_page.dart';
import 'package:dehub/src/finance_module/screens/received_funding_page/received_funding_page.dart';
import 'package:dehub/src/order_module/screens/received_order_detail/received_order_detail.dart';
import 'package:dehub/src/auth/receiver_otp_verify/receiver_otp_verify.dart';
import 'package:dehub/src/auth/register-page/register_page.dart';
import 'package:dehub/src/network_module/screens/client_staffs/client_staffs.dart';
import 'package:dehub/src/network_module/screens/client_staffs/client_staff_detail/client_staff_detail.dart';
import 'package:dehub/src/network_module/screens/distribution_areas/set_distribution_area/set_distribution_area.dart';
import 'package:dehub/src/network_module/screens/payment_terms/set_payment_term/set_payment_term.dart';
import 'package:dehub/src/network_module/screens/payment_terms/set_payment_term_detail/set_payment_term_detail.dart';
import 'package:dehub/src/network_module/screens/payment_terms/payment_terms.dart';
import 'package:dehub/src/product_module/screens/set_price/set_price.dart';
import 'package:dehub/src/product_module/screens/set_price_group/set_price_group.dart';
import 'package:dehub/src/product_module/screens/set_warehouse/set_warehouse.dart';
import 'package:dehub/src/product_module/screens/supplier_list/supplier_list.dart';
import 'package:dehub/src/product_module/screens/supplier_product/supplier_product_list.dart';
import 'package:dehub/src/profile/profile_page.dart';
import 'package:dehub/src/splash/splash_page.dart';
import 'package:dehub/src/payment_module/screens/transaction_history/transaction_history.dart';
import 'package:dehub/src/user_module/screens/create_user/create_user.dart';
import 'package:dehub/src/user_module/screens/finance_request/finance_request.dart';
import 'package:dehub/src/user_module/screens/finance_role_assign/finance_role_assign.dart';
import 'package:dehub/src/user_module/screens/invitation_send/invitation_send.dart';
import 'package:dehub/src/user_module/screens/role_assign/role_assign.dart';
import 'package:dehub/src/user_module/screens/update_user/update_user_page.dart';
import 'package:dehub/src/user_module/user_management_page/user_management_page.dart';
import 'package:dehub/services/dialog.dart';
import 'package:dehub/services/navigation.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/dialog_manager/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:dehub/src/finance_module/screens/funding_request_page/funding_request_page.dart';
import 'package:dehub/src/order_module/screens/new_order/customer_choose/customer_choose.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  runApp(ChangeNotifierProvider(
    create: (_) => LoadingProvider(),
    lazy: false,
    child: const MyApp(),
  ));
}

GetIt locator = GetIt.instance;
String currentRouteName = '';

class MyApp extends StatelessWidget {
  static const routeName = '/MyApp';
  const MyApp({super.key});
  static DialogService? dialogService = locator<DialogService>();

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<LoadingProvider>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeHUB',
      theme: ThemeData(useMaterial3: true),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => GeneralProvider()),
          ChangeNotifierProvider(create: (_) => IndexProvider()),
          ChangeNotifierProvider(create: (_) => CheckOutProvider()),
          ChangeNotifierProvider(create: (_) => FinanceProvider()),
          ChangeNotifierProvider(create: (_) => InventoryProvider()),
          ChangeNotifierProvider(create: (_) => InvoiceProvider()),
          ChangeNotifierProvider(create: (_) => PartnerProvider()),
          ChangeNotifierProvider(create: (_) => UserModuleProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
        ],
        child: Stack(
          children: [
            MaterialApp(
              theme: ThemeData(fontFamily: "Montserrat"),
              title: 'DeHub',
              builder: (context, widget) => Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) =>
                      DialogManager(child: loading(context, widget)),
                ),
              ),
              navigatorKey: locator<NavigationService>().navigatorKey,
              initialRoute: SplashPage.routeName,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (RouteSettings settings) {
                currentRouteName = settings.name.toString();
                switch (settings.name) {
                  case SplashPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const SplashPage();
                    });
                  case PaymentRegister.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const PaymentRegister();
                    });
                  case DropshipOrder.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const DropshipOrder();
                    });
                  case ChangeStandardPrice.routeName:
                    ChangeStandardPriceArguments arguments =
                        settings.arguments as ChangeStandardPriceArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ChangeStandardPrice(
                        type: arguments.type,
                      );
                    });
                  case AccountDetailPage.routeName:
                    AccountDetailPageArguments arguments =
                        settings.arguments as AccountDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return AccountDetailPage(
                        id: arguments.id,
                      );
                    });
                  case PaymentReceivedFunds.routeName:
                    PaymentReceivedFundsArguments arguments =
                        settings.arguments as PaymentReceivedFundsArguments;
                    return MaterialPageRoute(builder: (context) {
                      return PaymentReceivedFunds(
                        data: arguments.data,
                      );
                    });
                  case CreateBackOrder.routeName:
                    CreateBackOrderArguments arguments =
                        settings.arguments as CreateBackOrderArguments;
                    return MaterialPageRoute(builder: (context) {
                      return CreateBackOrder(
                        orders: arguments.orders,
                      );
                    });
                  case DropshipCreate.routeName:
                    DropshipCreateArguments arguments =
                        settings.arguments as DropshipCreateArguments;
                    return MaterialPageRoute(builder: (context) {
                      return DropshipCreate(
                        id: arguments.id,
                        lines: arguments.lines,
                      );
                    });
                  case PriceGroupPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const PriceGroupPage();
                    });
                  case CameraPage.routeName:
                    CameraPageArguments arguments =
                        settings.arguments as CameraPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return CameraPage(
                        listenController: arguments.listenController,
                      );
                    });
                  case OrderCustomers.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const OrderCustomers();
                    });
                  case NoInternetScreen.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const NoInternetScreen();
                    });
                  case InvitationDetailPage.routeName:
                    InvitationDetailPageArguments arguments =
                        settings.arguments as InvitationDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return InvitationDetailPage(
                        listenController: arguments.listenController,
                        id: arguments.id,
                      );
                    });
                  case GoodsPriceChangeHistory.routeName:
                    GoodsPriceChangeHistoryArguments arguments =
                        settings.arguments as GoodsPriceChangeHistoryArguments;
                    return MaterialPageRoute(builder: (context) {
                      return GoodsPriceChangeHistory(
                        id: arguments.id,
                      );
                    });
                  case SetPriceGroup.routeName:
                    SetPriceGroupArguments arguments =
                        settings.arguments as SetPriceGroupArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SetPriceGroup(
                        listenController: arguments.listenController,
                        list: arguments.list,
                      );
                    });
                  case PartnerDetailPage.routeName:
                    PartnerDetailPageArguments arguments =
                        settings.arguments as PartnerDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return PartnerDetailPage(
                        id: arguments.id,
                      );
                    });
                  case SupplierList.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const SupplierList();
                    });
                  case LoginPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    });
                  case ProfilePage.routeName:
                    ProfilePageArguments arguments =
                        settings.arguments as ProfilePageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ProfilePage(
                        index: arguments.index,
                      );
                    });
                  case SetWarehouse.routeName:
                    SetWarehouseArguments arguments =
                        settings.arguments as SetWarehouseArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SetWarehouse(
                        data: arguments.data,
                        listenController: arguments.listenController,
                      );
                    });
                  case CreateSubCategory.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const CreateSubCategory();
                    });
                  case PartnerProfile.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const PartnerProfile();
                    });
                  case FundingRequestDetailPage.routeName:
                    FundingRequestDetailPageArguments arguments =
                        settings.arguments as FundingRequestDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return FundingRequestDetailPage(
                        id: arguments.id,
                      );
                    });
                  case FundingRequestPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const FundingRequestPage();
                    });
                  case NetworkPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const NetworkPage();
                    });
                  case NewProduct.routeName:
                    NewProductArguments arguments =
                        settings.arguments as NewProductArguments;
                    return MaterialPageRoute(builder: (context) {
                      return NewProduct(
                        initialIndex: arguments.initialIndex,
                        data: arguments.data,
                      );
                    });
                  case PriceGroupDetail.routeName:
                    PriceGroupDetailArguments arguments =
                        settings.arguments as PriceGroupDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return PriceGroupDetail(
                        type: arguments.type,
                        id: arguments.id,
                      );
                    });
                  case NewInvoice.routeName:
                    NewInvoiceArguments arguments =
                        settings.arguments as NewInvoiceArguments;
                    return MaterialPageRoute(builder: (context) {
                      return NewInvoice(
                        data: arguments.data,
                      );
                    });
                  case AccountSetting.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const AccountSetting();
                    });
                  case PinCode.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const PinCode();
                    });
                  case NewPin.routeName:
                    NewPinArguments arguments =
                        settings.arguments as NewPinArguments;
                    return MaterialPageRoute(builder: (context) {
                      return NewPin(
                        oldPin: arguments.oldPin,
                      );
                    });
                  case FinanceEntry.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const FinanceEntry();
                    });
                  case AccountSettingDetail.routeName:
                    AccountSettingDetailArguments arguments =
                        settings.arguments as AccountSettingDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return AccountSettingDetail(
                        id: arguments.id,
                        listenController: arguments.listenController,
                      );
                    });
                  case PinConfirmation.routeName:
                    PinConfirmationArguments arguments =
                        settings.arguments as PinConfirmationArguments;
                    return MaterialPageRoute(builder: (context) {
                      return PinConfirmation(
                        oldPin: arguments.oldPin,
                        value: arguments.value,
                      );
                    });
                  case PaymentTerms.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const PaymentTerms();
                    });
                  case ClientStaffDetail.routeName:
                    ClientStaffDetailArguments arguments =
                        settings.arguments as ClientStaffDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ClientStaffDetail(
                        id: arguments.id,
                        listenController: arguments.listenController,
                      );
                    });
                  case ClientStaffs.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const ClientStaffs();
                    });
                  case SetPaymentTermDetail.routeName:
                    SetPaymentTermDetailArguments arguments =
                        settings.arguments as SetPaymentTermDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SetPaymentTermDetail(
                        id: arguments.id,
                        listenController: arguments.listenController,
                      );
                    });
                  case CustomerChoose.routeName:
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const CustomerChoose(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case SetAccount.routeName:
                    SetAccountArguments arguments =
                        settings.arguments as SetAccountArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SetAccount(
                        listenController: arguments.listenController,
                        id: arguments.id,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case BranchCreate.routeName:
                    BranchCreateArguments arguments =
                        settings.arguments as BranchCreateArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BranchCreate(
                        listenController: arguments.listenController,
                        data: arguments.data,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case WarehouseCreate.routeName:
                    WarehouseCreateArguments arguments =
                        settings.arguments as WarehouseCreateArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          WarehouseCreate(
                        listenController: arguments.listenController,
                        data: arguments.data,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case SettlementRespond.routeName:
                    SettlementRespondArguments arguments =
                        settings.arguments as SettlementRespondArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SettlementRespond(
                        data: arguments.data,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case InvitationSentPage.routeName:
                    InvitationSentPageArguments arguments =
                        settings.arguments as InvitationSentPageArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          InvitationSentPage(
                        listenController: arguments.listenController,
                        data: arguments.data,
                        invitationType: arguments.invitationType,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case SalbarSongoh.routeName:
                    SalbarSongohArguments arguments =
                        settings.arguments as SalbarSongohArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SalbarSongoh(
                        data: arguments.data,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case ProgramPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const ProgramPage();
                    });
                  case AvailableFundingPage.routeName:
                    AvailableFundingPageArguments arguments =
                        settings.arguments as AvailableFundingPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return AvailableFundingPage(
                        id: arguments.id,
                      );
                    });
                  case CompromisePage.routeName:
                    CompromisePageArguments arguments =
                        settings.arguments as CompromisePageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return CompromisePage(
                        data: arguments.data,
                      );
                    });
                  case FinanceQpay.routeName:
                    FinanceQpayArguments arguments =
                        settings.arguments as FinanceQpayArguments;
                    return MaterialPageRoute(builder: (context) {
                      return FinanceQpay(
                        color: arguments.color,
                        data: arguments.data,
                      );
                    });
                  case AvaibleFundingDetailPage.routeName:
                    AvaibleFundingDetailPageArguments arguments =
                        settings.arguments as AvaibleFundingDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return AvaibleFundingDetailPage(
                        id: arguments.id,
                        programId: arguments.programId,
                      );
                    });

                  case FinanceRoleAssign.routeName:
                    FinanceRoleAssignArguments arguments =
                        settings.arguments as FinanceRoleAssignArguments;
                    return MaterialPageRoute(builder: (context) {
                      return FinanceRoleAssign(
                        listenController: arguments.listenController,
                      );
                    });
                  case OtpVerifyPage.routeName:
                    OtpVerifyPageArguments arguments =
                        settings.arguments as OtpVerifyPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return OtpVerifyPage(
                        verifyId: arguments.verifyId,
                        email: arguments.email,
                        phone: arguments.phone,
                      );
                    });
                  case CreatePasswordPage.routeName:
                    CreatePasswordPageArguments arguments =
                        settings.arguments as CreatePasswordPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return CreatePasswordPage(
                        type: arguments.type,
                      );
                    });
                  case FinanceRequest.routeName:
                    FinanceRequestArguments arguments =
                        settings.arguments as FinanceRequestArguments;
                    return MaterialPageRoute(builder: (context) {
                      return FinanceRequest(
                        bank: arguments.bank,
                        name: arguments.name,
                        listenController: arguments.listenController,
                      );
                    });
                  case UpdateBusiness.routeName:
                    UpdateBusinessArguments arguments =
                        settings.arguments as UpdateBusinessArguments;
                    return MaterialPageRoute(builder: (context) {
                      return UpdateBusiness(
                        data: arguments.data,
                        listenController: arguments.listenController,
                      );
                    });
                  case OtpPhoneVerify.routeName:
                    OtpPhoneVerifyArguments arguments =
                        settings.arguments as OtpPhoneVerifyArguments;
                    return MaterialPageRoute(builder: (context) {
                      return OtpPhoneVerify(
                        phone: arguments.phone,
                      );
                    });
                  case RegisterPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const RegisterPage();
                    });
                  case NetworkPartnerPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const NetworkPartnerPage();
                    });
                  case NewInvitationPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const NewInvitationPage();
                    });
                  case Harah.routeName:
                    HarahArguments arguments =
                        settings.arguments as HarahArguments;
                    return MaterialPageRoute(builder: (context) {
                      return Harah(
                        isNewInvoice: arguments.isNewInvoice,
                        invoice: arguments.invoice,
                      );
                    });
                  case ZoningDetailPage.routeName:
                    ZoningDetailPageArguments arguments =
                        settings.arguments as ZoningDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ZoningDetailPage(
                        id: arguments.id,
                      );
                    });
                  case ClientClassificationDetail.routeName:
                    ClientClassificationDetailArguments arguments = settings
                        .arguments as ClientClassificationDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ClientClassificationDetail(
                        id: arguments.id,
                        listenController: arguments.listenController,
                      );
                    });
                  case ClientClassifications.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const ClientClassifications();
                    });
                  case FinancingLogin.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const FinancingLogin();
                    });
                  case SentInvitationDetail.routeName:
                    SentInvitationDetailArguments arguments =
                        settings.arguments as SentInvitationDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SentInvitationDetail(
                        id: arguments.id,
                      );
                    });
                  case InvoiceDetailPage.routeName:
                    InvoiceDetailPageArguments arguments =
                        settings.arguments as InvoiceDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return InvoiceDetailPage(
                        id: arguments.id,
                      );
                    });
                  case DistributionAreaDetail.routeName:
                    DistributionAreaDetailArguments arguments =
                        settings.arguments as DistributionAreaDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return DistributionAreaDetail(
                        id: arguments.id,
                        listenController: arguments.listenController,
                      );
                    });
                  case DistributionAreas.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const DistributionAreas();
                    });
                  case PaymentApprovalPage.routeName:
                    PaymentApprovalPageArguments arguments =
                        settings.arguments as PaymentApprovalPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return PaymentApprovalPage(
                        data: arguments.data,
                        amount: arguments.amount,
                      );
                    });
                  case BankAccountDetail.routeName:
                    BankAccountDetailArguments arguments =
                        settings.arguments as BankAccountDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return BankAccountDetail(
                        id: arguments.id,
                      );
                    });
                  case TransactionHistory.routeName:
                    TransactionHistoryArguments arguments =
                        settings.arguments as TransactionHistoryArguments;
                    return MaterialPageRoute(builder: (context) {
                      return TransactionHistory(
                        data: arguments.data,
                      );
                    });
                  case AccountStatement.routeName:
                    AccountStatementArguments arguments =
                        settings.arguments as AccountStatementArguments;
                    return MaterialPageRoute(builder: (context) {
                      return AccountStatement(
                        data: arguments.data,
                      );
                    });
                  case TransactionDetailPage.routeName:
                    TransactionDetailPageArguments arguments =
                        settings.arguments as TransactionDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return TransactionDetailPage(
                        data: arguments.data,
                      );
                    });
                  case MenuPage.routeName:
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const MenuPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(-1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case FullPicture.routeName:
                    FullPictureArguments arguments =
                        settings.arguments as FullPictureArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          FullPicture(
                        pictures: arguments.pictures,
                        initialPage: arguments.initialPage,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          // position: animation.drive(tween),
                          opacity: animation,
                          child: child,
                        );
                      },
                    );
                  case InvoicePaymentPage.routeName:
                    InvoicePaymentPageArguments arguments =
                        settings.arguments as InvoicePaymentPageArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          InvoicePaymentPage(
                        id: arguments.id,
                        data: arguments.data,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case Adjustment.routeName:
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const Adjustment(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case SetClientClassification.routeName:
                    SetClientClassificationArguments arguments =
                        settings.arguments as SetClientClassificationArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SetClientClassification(
                        listenController: arguments.listenController,
                        id: arguments.id,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case SetDistributionArea.routeName:
                    SetDistributionAreaArguments arguments =
                        settings.arguments as SetDistributionAreaArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SetDistributionArea(
                        id: arguments.id,
                        listenController: arguments.listenController,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case SetClientStaff.routeName:
                    SetClientStaffArguments arguments =
                        settings.arguments as SetClientStaffArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SetClientStaff(
                        listenController: arguments.listenController,
                        id: arguments.id,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case SetPaymentTerm.routeName:
                    SetPaymentTermArguments arguments =
                        settings.arguments as SetPaymentTermArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SetPaymentTerm(
                        listenController: arguments.listenController,
                        id: arguments.id,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case OrderCustomerChoose.routeName:
                    OrderCustomerChooseArguments arguments =
                        settings.arguments as OrderCustomerChooseArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          OrderCustomerChoose(
                        customerListenController:
                            arguments.customerListenController,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case OrderInvoice.routeName:
                    OrderInvoiceArguments arguments =
                        settings.arguments as OrderInvoiceArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          OrderInvoice(
                        lines: arguments.lines,
                        data: arguments.data,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case OrderCashPayment.routeName:
                    OrderCashPaymentArguments arguments =
                        settings.arguments as OrderCashPaymentArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          OrderCashPayment(
                        data: arguments.data,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case DebtPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const DebtPage();
                    });
                  case OrderCbdPayment.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const OrderCbdPayment();
                    });
                  case NewOrder.routeName:
                    NewOrderArguments arguments =
                        settings.arguments as NewOrderArguments;
                    return MaterialPageRoute(builder: (context) {
                      return NewOrder(
                        data: arguments.data,
                        id: arguments.id,
                      );
                    });
                  case NetworkSettlementDetail.routeName:
                    NetworkSettlementDetailArguments arguments =
                        settings.arguments as NetworkSettlementDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return NetworkSettlementDetail(
                        data: arguments.data,
                      );
                    });
                  case SettlementDetail.routeName:
                    SettlementDetailArguments arguments =
                        settings.arguments as SettlementDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SettlementDetail(
                        id: arguments.id,
                        status: arguments.status,
                      );
                    });
                  case InvoiceTransaction.routeName:
                    InvoiceTransactionArguments arguments =
                        settings.arguments as InvoiceTransactionArguments;
                    return MaterialPageRoute(builder: (context) {
                      return InvoiceTransaction(
                        data: arguments.data,
                      );
                    });
                  case RePaymentDetail.routeName:
                    RePaymentDetailArguments arguments =
                        settings.arguments as RePaymentDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return RePaymentDetail(
                        id: arguments.id,
                      );
                    });
                  case RePayment.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const RePayment();
                    });
                  case PullSheetExpenses.routeName:
                    PullSheetExpensesArguments arguments =
                        settings.arguments as PullSheetExpensesArguments;
                    return MaterialPageRoute(builder: (context) {
                      return PullSheetExpenses(
                        data: arguments.data,
                      );
                    });
                  case ChangePassword.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const ChangePassword();
                    });
                  case OrderCashApproval.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const OrderCashApproval();
                    });
                  case ReCalledPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const ReCalledPage();
                    });
                  case OrderCodPayment.routeName:
                    OrderCodPaymentArguments arguments =
                        settings.arguments as OrderCodPaymentArguments;
                    return MaterialPageRoute(builder: (context) {
                      return OrderCodPayment(
                        lines: arguments.lines,
                        id: arguments.id,
                      );
                    });
                  case FinancePayment.routeName:
                    FinancePaymentArguments arguments =
                        settings.arguments as FinancePaymentArguments;
                    return MaterialPageRoute(builder: (context) {
                      return FinancePayment(
                        id: arguments.id,
                        refCode: arguments.refCode,
                      );
                    });
                  case FinancingPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const FinancingPage();
                    });
                  case InventoryDistributor.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InventoryDistributor();
                    });
                  case InventoryItemType.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InventoryItemType();
                    });
                  case InventoryUnit.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InventoryUnit();
                    });
                  case InventoryManufacturer.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InventoryManufacturer();
                    });
                  case PackageType.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const PackageType();
                    });
                  case InventoryTag.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InventoryTag();
                    });
                  case InventoryClassification.routeName:
                    InventoryClassificationArguments arguments =
                        settings.arguments as InventoryClassificationArguments;
                    return MaterialPageRoute(builder: (context) {
                      return InventoryClassification(
                        type: arguments.type,
                      );
                    });
                  case OrderShipping.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const OrderShipping();
                    });
                  case OrderShipment.routeName:
                    OrderShipmentArguments arguments =
                        settings.arguments as OrderShipmentArguments;
                    return MaterialPageRoute(builder: (context) {
                      return OrderShipment(
                        data: arguments.data,
                      );
                    });
                  case Invoicepage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const Invoicepage();
                    });
                  case OrderDelivery.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const OrderDelivery();
                    });
                  case InActiveTypes.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InActiveTypes();
                    });
                  case Options.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const Options();
                    });
                  case DynamicInformation.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const DynamicInformation();
                    });
                  case AdjustmentNote.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const AdjustmentNote();
                    });
                  case InventoryPriceTiers.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InventoryPriceTiers();
                    });
                  case InventoryDeliveryType.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InventoryDeliveryType();
                    });
                  case OrderPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const OrderPage();
                    });
                  case PaymentPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const PaymentPage();
                    });
                  case ProductPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const ProductPage();
                    });
                  case ReceivedFundingDetailPage.routeName:
                    ReceivedFundingDetailPageArguments arguments = settings
                        .arguments as ReceivedFundingDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ReceivedFundingDetailPage(
                        id: arguments.id,
                      );
                    });
                  case UserMangementPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const UserMangementPage();
                    });
                  case ClosedInvoicePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const ClosedInvoicePage();
                    });
                  case PartnerPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const PartnerPage();
                    });
                  case ReceivedFundingPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const ReceivedFundingPage();
                    });
                  case AddBankAccountPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const AddBankAccountPage();
                    });
                  case LinkAccountPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const LinkAccountPage();
                    });
                  case InventoryBrand.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InventoryBrand();
                    });
                  case QpayPage.routeName:
                    QpayPageArguments arguments =
                        settings.arguments as QpayPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return QpayPage(
                        color: arguments.color,
                        data: arguments.data,
                      );
                    });
                  case ReferenceInformationPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const ReferenceInformationPage();
                    });
                  case InventoryReferencePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InventoryReferencePage();
                    });
                  case InvoiceConditionPage.routeName:
                    InvoiceConditionPageArguments arguments =
                        settings.arguments as InvoiceConditionPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return InvoiceConditionPage(
                        data: arguments.data,
                      );
                    });
                  case ChangeBranchNamePage.routeName:
                    ChangeBranchNamePageArguments arguments =
                        settings.arguments as ChangeBranchNamePageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ChangeBranchNamePage(
                        id: arguments.id,
                        receiverBranchController:
                            arguments.receiverBranchController,
                      );
                    });
                  case AddAttachment.routeName:
                    AddAttachmentArguments arguments =
                        settings.arguments as AddAttachmentArguments;
                    return MaterialPageRoute(builder: (context) {
                      return AddAttachment(
                        pickedFile: arguments.pickedFile,
                      );
                    });
                  case OrderAddRow.routeName:
                    OrderAddRowArguments arguments =
                        settings.arguments as OrderAddRowArguments;
                    return MaterialPageRoute(builder: (context) {
                      return OrderAddRow(
                        additionalRowsListenController:
                            arguments.additionalRowsListenController,
                      );
                    });
                  case InvoiceAddRow.routeName:
                    InvoiceAddRowArguments arguments =
                        settings.arguments as InvoiceAddRowArguments;
                    return MaterialPageRoute(builder: (context) {
                      return InvoiceAddRow(
                        discountAmount: arguments.discountAmount,
                        shippingAmount: arguments.shippingAmount,
                      );
                    });
                  case ProductGive.routeName:
                    ProductGiveArguments arguments =
                        settings.arguments as ProductGiveArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ProductGive(
                        data: arguments.data,
                      );
                    });
                  case ReceiverOtpVerify.routeName:
                    ReceiverOtpVerifyArguments arguments =
                        settings.arguments as ReceiverOtpVerifyArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ReceiverOtpVerify(
                        data: arguments.data,
                      );
                    });
                  case EnterPhonePage.routeName:
                    EnterPhonePageArguments arguments =
                        settings.arguments as EnterPhonePageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return EnterPhonePage(
                        data: arguments.data,
                      );
                    });
                  case DeliveryManagement.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const DeliveryManagement();
                    });
                  case ExpensesPage.routeName:
                    ExpensesPageArguments arguments =
                        settings.arguments as ExpensesPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ExpensesPage(
                        id: arguments.id,
                      );
                    });
                  case ShipmentDistribution.routeName:
                    ShipmentDistributionArguments arguments =
                        settings.arguments as ShipmentDistributionArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ShipmentDistribution(
                        id: arguments.id,
                        listenController: arguments.listenController,
                      );
                    });
                  case SetDeliveryDistribution.routeName:
                    SetDeliveryDistributionArguments arguments =
                        settings.arguments as SetDeliveryDistributionArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SetDeliveryDistribution(
                        data: arguments.data,
                        listenController: arguments.listenController,
                      );
                    });
                  case DeliveryPage.routeName:
                    DeliveryPageArguments arguments =
                        settings.arguments as DeliveryPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return DeliveryPage(
                        data: arguments.data,
                      );
                    });
                  case PasswordRecovery.routeName:
                    PasswordRecoveryArguments arguments =
                        settings.arguments as PasswordRecoveryArguments;
                    return MaterialPageRoute(builder: (context) {
                      return PasswordRecovery(
                        color: arguments.color,
                      );
                    });
                  case DeliveryDetail.routeName:
                    DeliveryDetailArguments arguments =
                        settings.arguments as DeliveryDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return DeliveryDetail(
                        data: arguments.data,
                      );
                    });
                  case PinCheckScreen.routeName:
                    PinCheckScreenArguments arguments =
                        settings.arguments as PinCheckScreenArguments;
                    return MaterialPageRoute(builder: (context) {
                      return PinCheckScreen(
                        onSubmit: arguments.onSubmit,
                        color: arguments.color,
                        labelText: arguments.labelText,
                        description: arguments.description,
                      );
                    });
                  case ReceivedOrderDetail.routeName:
                    ReceivedOrderDetailArguments arguments =
                        settings.arguments as ReceivedOrderDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ReceivedOrderDetail(
                        listenController: arguments.listenController,
                        id: arguments.id,
                      );
                    });
                  case RoleAssign.routeName:
                    RoleAssignArguments arguments =
                        settings.arguments as RoleAssignArguments;
                    return MaterialPageRoute(builder: (context) {
                      return RoleAssign(
                        id: arguments.id,
                        data: arguments.data,
                        listenController: arguments.listenController,
                      );
                    });
                  case OrderSendPage.routeName:
                    OrderSendPageArguments arguments =
                        settings.arguments as OrderSendPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return OrderSendPage(
                        onSubmit: arguments.onSubmit,
                        data: arguments.data,
                      );
                    });
                  case AddCodTerm.routeName:
                    AddCodTermArguments arguments =
                        settings.arguments as AddCodTermArguments;
                    return MaterialPageRoute(builder: (context) {
                      return AddCodTerm(
                        listenController: arguments.listenController,
                      );
                    });
                  case OrderSendCustomer.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const OrderSendCustomer();
                    });
                  case NewConditionPage.routeName:
                    NewConditionPageArguments arguments =
                        settings.arguments as NewConditionPageArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          NewConditionPage(
                        listenController: arguments.listenController,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case AddDirection.routeName:
                    AddDirectionArguments arguments =
                        settings.arguments as AddDirectionArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AddDirection(
                        parentId: arguments.parentId,
                        parentName: arguments.parentName,
                        parentRefCode: arguments.parentRefCode,
                        listenController: arguments.listenController,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case ProductChoose.routeName:
                    ProductChooseArguments arguments =
                        settings.arguments as ProductChooseArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ProductChoose(
                        listenController: arguments.listenController,
                        isPackage: arguments.isPackage,
                        businessId: arguments.businessId,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );

                  case AddZoning.routeName:
                    AddZoningArguments arguments =
                        settings.arguments as AddZoningArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AddZoning(
                        listenController: arguments.listenController,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case AddProduct.routeName:
                    AddProductArguments arguments =
                        settings.arguments as AddProductArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AddProduct(
                        businessId: arguments.businessId,
                        discountAmount: arguments.discountAmount,
                        shippingAmount: arguments.shippingAmount,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case UpdateUserPage.routeName:
                    UpdateUserPageArguments arguments =
                        settings.arguments as UpdateUserPageArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          UpdateUserPage(
                        data: arguments.data,
                        listenController: arguments.listenController,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case CreateUser.routeName:
                    CreateUserArguments arguments =
                        settings.arguments as CreateUserArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CreateUser(
                        listenController: arguments.listenController,
                        data: arguments.data,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case AddCategory.routeName:
                    AddCategoryArguments arguments =
                        settings.arguments as AddCategoryArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AddCategory(
                        listenController: arguments.listenController,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  case AddRank.routeName:
                    AddRankArguments arguments =
                        settings.arguments as AddRankArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AddRank(
                        parentRefCode: arguments.parentRefCode,
                        parentId: arguments.parentId,
                        parentName: arguments.parentName,
                        listenController: arguments.listenController,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );

                  case InvoiceConditionDetailPage.routeName:
                    InvoiceConditionDetailPageArguments arguments = settings
                        .arguments as InvoiceConditionDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return InvoiceConditionDetailPage(
                        id: arguments.id,
                      );
                    });
                  case UserInvitationSend.routeName:
                    UserInvitationSendArguments arguments =
                        settings.arguments as UserInvitationSendArguments;
                    return MaterialPageRoute(builder: (context) {
                      return UserInvitationSend(
                        data: arguments.data,
                      );
                    });
                  case CategoryDetailPage.routeName:
                    CategoryDetailPageArguments arguments =
                        settings.arguments as CategoryDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return CategoryDetailPage(
                        id: arguments.id,
                      );
                    });
                  case DashboardScreen.routeName:
                    DashboardScreenArguments arguments =
                        settings.arguments as DashboardScreenArguments;
                    return MaterialPageRoute(builder: (context) {
                      return DashboardScreen(
                        data: arguments.data,
                      );
                    });
                  case BuyerProposal.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const BuyerProposal();
                    });
                  case SetLimitPage.routeName:
                    SetLimitPageArguments arguments =
                        settings.arguments as SetLimitPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SetLimitPage(
                        data: arguments.data,
                      );
                    });
                  case SetPrice.routeName:
                    SetPriceArguments arguments =
                        settings.arguments as SetPriceArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SetPrice(
                        listenController: arguments.listenController,
                        data: arguments.data,
                      );
                    });
                  case DirectionDetailPage.routeName:
                    DirectionDetailPageArguments arguments =
                        settings.arguments as DirectionDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return DirectionDetailPage(
                        id: arguments.id,
                      );
                    });
                  case RankDetailPage.routeName:
                    RankDetailPageArguments arguments =
                        settings.arguments as RankDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return RankDetailPage(
                        id: arguments.id,
                      );
                    });
                  case CheckBiometric.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const CheckBiometric();
                    });
                  case ProductListPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const ProductListPage();
                    });
                  case EntryPoint.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const EntryPoint();
                    });
                  case SupplierProductList.routeName:
                    SupplierProductListArguments arguments =
                        settings.arguments as SupplierProductListArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SupplierProductList(
                        id: arguments.id,
                      );
                    });
                  case ProductDetailPage.routeName:
                    ProductDetailPageArguments arguments =
                        settings.arguments as ProductDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ProductDetailPage(
                        id: arguments.id!,
                      );
                    });
                  case InvoiceListPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const InvoiceListPage();
                    });
                  case SectorChoose.routeName:
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const SectorChoose(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    );
                  default:
                    return MaterialPageRoute(
                      builder: (_) => const EntryPoint(),
                    );
                }
              },
            ),
            if (source.isLoading == true)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: black.withOpacity(0.3),
                child: Lottie.asset('assets/lottie/loading.json'),
                // const CupertinoActivityIndicator(
                //   color: black,
                //   radius: 18,
                // ),
              ),
          ],
        ),
      ),
    );
  }

  Widget loading(BuildContext context, widget) {
    bool shouldPop = false;

    return PopScope(
      canPop: shouldPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          color: backgroundColor,
          child: SafeArea(
            bottom: false,
            top: false,
            child: Stack(
              children: [
                Opacity(
                  opacity: 1,
                  child: Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        widget,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
