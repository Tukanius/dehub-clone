import 'package:dehub/providers/checkout-provider.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/entry_point/finance_entry/finance_entry.dart';
import 'package:dehub/src/finance_module/screens/recalled_page/recalled_page.dart';
import 'package:dehub/src/invoice_module/screens/invoice_transaction/invoice_transaction.dart';
import 'package:dehub/src/invoice_module/screens/statement_detail/statement_detail.dart';
import 'package:dehub/src/invoice_module/screens/transaction_detail/transaction_detail.dart';
import 'package:dehub/src/network_module/screens/account_setting/account_setting.dart';
import 'package:dehub/src/network_module/screens/account_setting/account_setting_detail/account_setting_detail.dart';
import 'package:dehub/src/network_module/screens/account_setting/set_account/set_account.dart';
import 'package:dehub/src/order_module/screens/delivery_management/delivery_management.dart';
import 'package:dehub/src/order_module/screens/set_delivery_distribution/set_delivery_distribution.dart';
import 'package:dehub/src/order_module/screens/shipment_distribution/shipment_distribution.dart';
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
import 'package:dehub/src/auth/check-biometric.dart';
import 'package:dehub/src/auth/financing_login.dart';
import 'package:dehub/src/auth/login_page.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/avaible_funding_detail_page.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_page/avaible_funding_page.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_page/request_approval_page.dart';
import 'package:dehub/src/debt_module/debt_page/debt_page.dart';
import 'package:dehub/src/auth/enter_phone_page/enter_phone_page.dart';
import 'package:dehub/src/order_module/screens/expenses_page/expenses_page.dart';
import 'package:dehub/src/finance_module/financing_page/financing_page.dart';
import 'package:dehub/src/entry_point/first_page/first_page.dart';
import 'package:dehub/src/finance_module/screens/funding_request_detail/funding_request_detail_page.dart';
import 'package:dehub/src/invoice_module/screens/closed_invoice/closed_invoice_page.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/add_product/add_product.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/add_row/invoice_add_row.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/sector-choose/sector-choose.dart';
import 'package:dehub/src/invoice_module/screens/invoice_list/give.dart';
import 'package:dehub/src/network_module/screens/category_page/add_category.dart';
import 'package:dehub/src/network_module/screens/direction_page/add_direction.dart';
import 'package:dehub/src/network_module/screens/direction_page/direction_detail_page.dart';
import 'package:dehub/src/network_module/screens/direction_page/direction_page.dart';
import 'package:dehub/src/network_module/screens/invoice_condition_page/invoice_condition_detail_page.dart';
import 'package:dehub/src/network_module/screens/invoice_condition_page/invoice_condition_page.dart';
import 'package:dehub/src/network_module/screens/invoice_condition_page/new_condition_page.dart';
import 'package:dehub/src/network_module/screens/category_page/category_detail_page.dart';
import 'package:dehub/src/network_module/screens/category_page/category_page.dart';
import 'package:dehub/src/network_module/screens/rank_page/add_rank.dart';
import 'package:dehub/src/network_module/screens/rank_page/rank_detail_page.dart';
import 'package:dehub/src/network_module/screens/rank_page/rank_page.dart';
import 'package:dehub/src/network_module/screens/reference_information_page/reference_information_page.dart';
import 'package:dehub/src/network_module/screens/partner_page/partner_detail_page/partner_detail_page.dart';
import 'package:dehub/src/network_module/screens/partner_page/partner_page.dart';
import 'package:dehub/src/network_module/screens/zoning_page/add_zoning.dart';
import 'package:dehub/src/network_module/screens/zoning_page/zoning_detail_page.dart';
import 'package:dehub/src/network_module/screens/zoning_page/zoning_page.dart';
import 'package:dehub/src/network_module/screens/new_invitation_page/invitation_sent_page/invitation_sent_page.dart';
import 'package:dehub/src/network_module/screens/new_invitation_page/new_invitation_page.dart';
import 'package:dehub/src/network_module/network_page/tabs/inbox_tab/invitation_detail_page/invitation_detail_page.dart';
import 'package:dehub/src/invoice_module/main_page/invoice_page.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/customer_choose/customer_choose.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/customer_choose/customer_choose_tabs/gereet.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/customer_choose/customer_choose_tabs/gereet_bish.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/customer_choose/salbar_songoh.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/harah.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/send_page.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/new_invoice.dart';
import 'package:dehub/src/invoice_module/screens/invoice_detail_page/invoice_detail_page.dart';
import 'package:dehub/src/payment_module/screens/link_account_page/link_account_page.dart';
import 'package:dehub/src/entry_point/menu/menu_page.dart';
import 'package:dehub/src/network_module/network_page/network_page.dart';
import 'package:dehub/src/network_module/screens/invitation_detail_page/invitation_detail_page.dart';
import 'package:dehub/src/order_module/screens/new_order/add_attachment/add_attachment.dart';
import 'package:dehub/src/order_module/screens/new_order/add_row/order_add_row.dart';
import 'package:dehub/src/order_module/screens/new_order/change_branch/change_branch_name.dart';
import 'package:dehub/src/order_module/screens/new_order/new_order.dart';
import 'package:dehub/src/order_module/screens/order_payment/order_payment.dart';
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
import 'package:dehub/src/auth/otp_page/otp-phone-verify.dart';
import 'package:dehub/src/auth/otp_page/otp_page.dart';
import 'package:dehub/src/partner_module/partner_page/partner_page.dart';
import 'package:dehub/src/payment_module/payment_page/payment_page.dart';
import 'package:dehub/src/auth/pin_code/new_pin.dart';
import 'package:dehub/src/auth/pin_code/pin_code.dart';
import 'package:dehub/src/auth/pin_code/pin_confirmation.dart';
import 'package:dehub/src/order_module/screens/product_give/product_give.dart';
import 'package:dehub/src/product_module/product_page/product_page.dart';
import 'package:dehub/src/product_module/screens/brand/brand.dart';
import 'package:dehub/src/product_module/screens/classification/inventory_classification.dart';
import 'package:dehub/src/product_module/screens/create_sub_category/create_sub_category.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/inventory_reference.dart';
import 'package:dehub/src/product_module/screens/item_type/inventory_item_type.dart';
import 'package:dehub/src/product_module/screens/new_product/new_product.dart';
import 'package:dehub/src/product_module/screens/product_detail_page/product_detail_page.dart';
import 'package:dehub/src/product_module/screens/product_list_page/product_list_page.dart';
import 'package:dehub/src/order_module/screens/pull_sheet_expenses/pull_sheet_expenses.dart';
import 'package:dehub/src/finance_module/screens/received_funding_detail/received_funding_detail_page.dart';
import 'package:dehub/src/finance_module/screens/received_funding_page/received_funding_page.dart';
import 'package:dehub/src/order_module/screens/received_order_detail/received_order_detail.dart';
import 'package:dehub/src/auth/receiver_otp_verify/receiver_otp_verify.dart';
import 'package:dehub/src/auth/register-page/register-page.dart';
import 'package:dehub/src/network_module/screens/client_staffs/client_staffs.dart';
import 'package:dehub/src/network_module/screens/client_staffs/client_staff_detail/client_staff_detail.dart';
import 'package:dehub/src/network_module/screens/distribution_areas/set_distribution_area/set_distribution_area.dart';
import 'package:dehub/src/network_module/screens/payment_terms/set_payment_term/set_payment_term.dart';
import 'package:dehub/src/network_module/screens/payment_terms/set_payment_term_detail/set_payment_term_detail.dart';
import 'package:dehub/src/network_module/screens/payment_terms/payment_terms.dart';
import 'package:dehub/src/entry_point/menu/shopping/shopping_page.dart';
import 'package:dehub/src/entry_point/menu/suppliers/suppliers_page.dart';
import 'package:dehub/src/product_module/screens/set_price/set_price.dart';
import 'package:dehub/src/product_module/screens/set_warehouse/set_warehouse.dart';
import 'package:dehub/src/product_module/screens/supplier_list/supplier_list.dart';
import 'package:dehub/src/product_module/screens/supplier_product/supplier_product_list.dart';
import 'package:dehub/src/profile/profile_page.dart';
import 'package:dehub/src/splash/splash_page.dart';
import 'package:dehub/src/payment_module/screens/transaction_history/transaction_history.dart';
import 'package:dehub/src/user_module/user_management_page/user_management_page.dart';
import 'package:dehub/services/dialog.dart';
import 'package:dehub/services/navigation.dart';
import 'package:dehub/widgets/dialog_manager/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:dehub/src/finance_module/screens/funding_request_page/funding_request_page.dart';
import 'package:dehub/src/order_module/screens/new_order/customer_choose/customer_choose.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  runApp(const MyApp());
}

GetIt locator = GetIt.instance;

class MyApp extends StatelessWidget {
  static const routeName = '/MyApp';
  const MyApp({Key? key}) : super(key: key);
  static DialogService? dialogService = locator<DialogService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Darkhan',
      theme: ThemeData(useMaterial3: true),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => GeneralProvider()),
          ChangeNotifierProvider(create: (_) => IndexProvider()),
          ChangeNotifierProvider(create: (_) => CheckOutProvider()),
          ChangeNotifierProvider(create: (_) => FinanceProvider()),
          ChangeNotifierProvider(create: (_) => InventoryProvider()),
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
                switch (settings.name) {
                  case SplashPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const SplashPage();
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
                      return CreateSubCategory();
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
                      return FundingRequestPage();
                    });
                  case NetworkPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return NetworkPage();
                    });
                  case NewProduct.routeName:
                    NewProductArguments arguments =
                        settings.arguments as NewProductArguments;
                    return MaterialPageRoute(builder: (context) {
                      return NewProduct(
                        initialIndex: arguments.initialIndex,
                        id: arguments.id,
                      );
                    });
                  case NewInvoice.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return NewInvoice();
                    });
                  case AccountSetting.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return AccountSetting();
                    });
                  case PinCode.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return PinCode();
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
                      return FinanceEntry();
                    });
                  case AccountSettingDetail.routeName:
                    AccountSettingDetailArguments arguments =
                        settings.arguments as AccountSettingDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return AccountSettingDetail(
                        id: arguments.id,
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
                      return PaymentTerms();
                    });
                  case ClientStaffDetail.routeName:
                    ClientStaffDetailArguments arguments =
                        settings.arguments as ClientStaffDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ClientStaffDetail(
                        id: arguments.id,
                      );
                    });
                  case ClientStaffs.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ClientStaffs();
                    });
                  case SetPaymentTermDetail.routeName:
                    SetPaymentTermDetailArguments arguments =
                        settings.arguments as SetPaymentTermDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SetPaymentTermDetail(
                        id: arguments.id,
                      );
                    });
                  case CustomerChoose.routeName:
                    CustomerChooseArguments arguments =
                        settings.arguments as CustomerChooseArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CustomerChoose(
                        listenController: arguments.listenController,
                        partnerListenController:
                            arguments.partnerListenController,
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
                        id: arguments.id,
                        partnerListenController:
                            arguments.partnerListenController,
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

                  case Gereet.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return Gereet();
                    });
                  case AvaibleFundingPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return AvaibleFundingPage();
                    });
                  case RequestApprovalPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return RequestApprovalPage();
                    });
                  case AvaibleFundingDetailPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return AvaibleFundingDetailPage();
                    });
                  case GereetBish.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return GereetBish();
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
                    return MaterialPageRoute(builder: (context) {
                      return CreatePasswordPage();
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
                      return RegisterPage();
                    });
                  case NetworkPartnerPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return NetworkPartnerPage();
                    });
                  case FirstPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return FirstPage();
                    });
                  case NewInvitationPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return NewInvitationPage();
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
                      );
                    });
                  case ZoningPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ZoningPage();
                    });
                  case ClientClassifications.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ClientClassifications();
                    });
                  case FinancingLogin.routeName:
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          FinancingLogin(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
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
                  case SentInvitationDetail.routeName:
                    SentInvitationDetailArguments arguments =
                        settings.arguments as SentInvitationDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SentInvitationDetail(
                        id: arguments.id,
                      );
                    });
                  case SendPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return SendPage();
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
                      );
                    });
                  case DistributionAreas.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return DistributionAreas();
                    });
                  case InvoiceDetailPage.routeName:
                    InvoiceDetailPageArguments arguments =
                        settings.arguments as InvoiceDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return InvoiceDetailPage(
                        id: arguments.id,
                      );
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
                  case TransactionDetailPage.routeName:
                    TransactionDetailPageArguments arguments =
                        settings.arguments as TransactionDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return TransactionDetailPage(
                        data: arguments.data,
                      );
                    });
                  case InvoiceTransactionDetail.routeName:
                    InvoiceTransactionDetailArguments arguments =
                        settings.arguments as InvoiceTransactionDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return InvoiceTransactionDetail(
                        id: arguments.id,
                      );
                    });
                  case MenuPage.routeName:
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MenuPage(),
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
                      return DebtPage();
                    });
                  case OrderCbdPayment.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return OrderCbdPayment();
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
                  case StatementDetail.routeName:
                    StatementDetailArguments arguments =
                        settings.arguments as StatementDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return StatementDetail(
                        data: arguments.data,
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
                    // RePaymentArguments arguments =
                    // settings.arguments as RePaymentArguments;
                    return MaterialPageRoute(builder: (context) {
                      return RePayment(
                          // id: arguments.id,
                          );
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
                      return ChangePassword();
                    });
                  case OrderCashApproval.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return OrderCashApproval();
                    });
                  case ReCalledPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ReCalledPage();
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
                  case FinancingPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return FinancingPage();
                    });
                  case InventoryItemType.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return InventoryItemType();
                    });
                  case InventoryClassification.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return InventoryClassification();
                    });
                  case OrderShipping.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return OrderShipping();
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
                      return Invoicepage();
                    });
                  case OrderDelivery.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return OrderDelivery();
                    });
                  case OrderPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return OrderPage();
                    });
                  case PaymentPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return PaymentPage();
                    });
                  case ProductPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ProductPage();
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
                      return UserMangementPage();
                    });
                  case ClosedInvoicePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ClosedInvoicePage();
                    });
                  case PartnerPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return PartnerPage();
                    });
                  case ReceivedFundingPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ReceivedFundingPage();
                    });
                  case AddBankAccountPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return AddBankAccountPage();
                    });
                  case LinkAccountPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return LinkAccountPage();
                    });
                  case SuppliersPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return SuppliersPage();
                    });
                  case ShoppingPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ShoppingPage();
                    });
                  case InventoryBrand.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return InventoryBrand();
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
                      return ReferenceInformationPage();
                    });
                  case InventoryReferencePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return InventoryReferencePage();
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
                        data: arguments.data,
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
                        additionalRowsListenController:
                            arguments.additionalRowsListenController,
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
                      return DeliveryManagement();
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
                      );
                    });
                  case SetDeliveryDistribution.routeName:
                    SetDeliveryDistributionArguments arguments =
                        settings.arguments as SetDeliveryDistributionArguments;
                    return MaterialPageRoute(builder: (context) {
                      return SetDeliveryDistribution(
                        data: arguments.data,
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
                  case OrderSendPage.routeName:
                    OrderSendPageArguments arguments =
                        settings.arguments as OrderSendPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return OrderSendPage(
                        onSubmit: arguments.onSubmit,
                        data: arguments.data,
                      );
                    });
                  case OrderSendCustomer.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return OrderSendCustomer();
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
                  case OrderPayment.routeName:
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          OrderPayment(),
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
                  case CategoryPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return CategoryPage();
                    });
                  case CategoryDetailPage.routeName:
                    CategoryDetailPageArguments arguments =
                        settings.arguments as CategoryDetailPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return CategoryDetailPage(
                        id: arguments.id,
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
                  case DirectionPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return DirectionPage();
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
                      return CheckBiometric();
                    });
                  case RankPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return RankPage();
                    });
                  case ProductListPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ProductListPage();
                    });
                  case EntryPoint.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return EntryPoint();
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
                  case GivePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return GivePage();
                    });
                  case SectorChoose.routeName:
                    SectorChooseArguments arguments =
                        settings.arguments as SectorChooseArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SectorChoose(
                        sectorListenController:
                            arguments.sectorListenController,
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
                  default:
                    return MaterialPageRoute(
                      builder: (_) => EntryPoint(),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget loading(BuildContext context, widget) {
    bool shouldPop = false;

    return PopScope(
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        body: Container(
          color: Colors.blue,
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
      canPop: shouldPop,
    );
  }
}
