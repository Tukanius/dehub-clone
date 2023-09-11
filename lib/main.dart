import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/account_info_page/account_info_page.dart';
import 'package:dehub/screens/account_info_page/tabs/tabs/transaction_detail_page.dart';
import 'package:dehub/screens/add_bank_account_page/add_bank_account_page.dart';
import 'package:dehub/screens/auth/financing_login.dart';
import 'package:dehub/screens/auth/login_page.dart';
import 'package:dehub/screens/avaible_funding_page/avaible_funding_detail_page.dart';
import 'package:dehub/screens/avaible_funding_page/avaible_funding_page.dart';
import 'package:dehub/screens/avaible_funding_page/request_approval_page.dart';
import 'package:dehub/screens/debt_page/debt_page.dart';
import 'package:dehub/screens/enter_phone_page/enter_phone_page.dart';
import 'package:dehub/screens/expenses_page/expenses_page.dart';
import 'package:dehub/screens/financing_page/financing_page.dart';
import 'package:dehub/screens/first_page/first_page.dart';
import 'package:dehub/screens/funding_request_page/funding_request_detail_page.dart';
import 'package:dehub/screens/home_page/home_page.dart';
import 'package:dehub/screens/income_guarantee/income_Guarantee.dart';
import 'package:dehub/screens/invoice/closed_invoice_page.dart';
import 'package:dehub/screens/invoice/new_invoice/add_product/add_product.dart';
import 'package:dehub/screens/invoice/new_invoice/sector-choose/sector-choose.dart';
import 'package:dehub/screens/invoice/payment_page/payment_page.dart';
import 'package:dehub/screens/invoice/payment_page/qpay_page.dart';
import 'package:dehub/screens/invoice/tabs/give.dart';
import 'package:dehub/screens/invoice/tabs/take.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/category_page/add_category.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/direction_page/add_direction.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/direction_page/direction_detail_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/direction_page/direction_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/invoice_condition_page/invoice_condition_detail_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/invoice_condition_page/invoice_condition_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/invoice_condition_page/new_condition_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/category_page/category_detail_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/category_page/category_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/rank_page/add_rank.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/rank_page/rank_detail_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/rank_page/rank_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/reference_information_page/reference_information_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/partner_page/partner_detail_page/partner_detail_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/partner_page/partner_detail_page/payment_condition_page/payment_condition_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/partner_page/partner_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/zoning_page/add_zoning.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/zoning_page/zoning_detail_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/zoning_page/zoning_page.dart';
import 'package:dehub/screens/network_page/tabs/inbox_tab/new_invitation_page/invitation_sent_page/invitation_sent_page.dart';
import 'package:dehub/screens/network_page/tabs/inbox_tab/new_invitation_page/new_invitation_page.dart';
import 'package:dehub/screens/network_page/tabs/inbox_tab/tabs/invitation_detail_page/invitation_detail_page.dart';
import 'package:dehub/screens/invoice/invoice_page.dart';
import 'package:dehub/screens/invoice/new_invoice/add_product/add_product_tabs/shirhegeer.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose.dart';
// import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/bugd.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/gereet.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/gereet_bish.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/salbar_songoh.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/harah.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/index1.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/pdf_page.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/send_page.dart';
import 'package:dehub/screens/invoice/new_invoice/new_invoice.dart';
import 'package:dehub/screens/invoice/payment_page/payment_approval_page.dart';
import 'package:dehub/screens/invoice_detail_page/invoice_detail_page.dart';
import 'package:dehub/screens/link_account_page/link_account_page.dart';
import 'package:dehub/screens/main/main_page.dart';
import 'package:dehub/screens/menu/menu_page.dart';
import 'package:dehub/screens/network_page/network_page.dart';
import 'package:dehub/screens/network_page/tabs/sent_tab/tabs/invitation_detail_page/invitation_detail_page.dart';
import 'package:dehub/screens/new_order/add_attachment.dart';
import 'package:dehub/screens/new_order/add_row.dart';
import 'package:dehub/screens/new_order/change_branch_name.dart';
import 'package:dehub/screens/new_order/new_order.dart';
import 'package:dehub/screens/new_order/order_payment.dart';
import 'package:dehub/screens/new_order/order_send/order_send_customer.dart';
import 'package:dehub/screens/new_order/order_send/order_send_page.dart';
import 'package:dehub/screens/new_order/product_choose/product_choose_in_pieces/product_choose.dart';
import 'package:dehub/screens/order_cash_approval/order_cash_approval.dart';
import 'package:dehub/screens/order_delivery/delivery_detail/delivery_detail.dart';
import 'package:dehub/screens/order_delivery/order_delivery.dart';
import 'package:dehub/screens/order_delivery/delivery/delivery.dart';
import 'package:dehub/screens/order_invoice/order_invoice.dart';
import 'package:dehub/screens/order_page/order_page.dart';
import 'package:dehub/screens/order_cash_payment/order_cash_payment.dart';
import 'package:dehub/screens/order_payment_page/order_payment_page.dart';
import 'package:dehub/screens/order_shipment/order_shipment.dart';
import 'package:dehub/screens/order_shipping/order_shipping.dart';
import 'package:dehub/screens/otp_page/create_password.dart';
import 'package:dehub/screens/otp_page/otp-phone-verify.dart';
import 'package:dehub/screens/otp_page/otp_page.dart';
import 'package:dehub/screens/partner_page/partner_page.dart';
import 'package:dehub/screens/payment_page/payment_page.dart';
import 'package:dehub/screens/product_give/product_give.dart';
import 'package:dehub/screens/product_page/product_page.dart';
import 'package:dehub/screens/product_page/tabs/dashboard_tab/product_detail_page/product_detail_page.dart';
import 'package:dehub/screens/product_page/tabs/dashboard_tab/product_list_page/product_list_page.dart';
import 'package:dehub/screens/received_funding_page/give_funding_detail_page.dart';
import 'package:dehub/screens/received_funding_page/received_funding_detail_page.dart';
import 'package:dehub/screens/received_funding_page/received_funding_page.dart';
import 'package:dehub/screens/received_order_detail/received_order_detail.dart';
import 'package:dehub/screens/receiver_otp_verify/receiver_otp_verify.dart';
import 'package:dehub/screens/register-page/register-page.dart';
import 'package:dehub/screens/shopping/shopping_page.dart';
import 'package:dehub/screens/menu/suppliers/suppliers_page.dart';
import 'package:dehub/screens/menu/tabs/purchase_page.dart';
import 'package:dehub/screens/menu/tabs/sales_page.dart';
import 'package:dehub/screens/profile/information/partner_info.dart';
import 'package:dehub/screens/profile/profile_page.dart';
import 'package:dehub/screens/splash/splash_page.dart';
import 'package:dehub/screens/user_management_page/user_management_page.dart';
import 'package:dehub/services/dialog.dart';
import 'package:dehub/services/navigation.dart';
import 'package:dehub/widgets/dialog_manager/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:dehub/screens/main_invoice_page/invoice_page.dart';
import 'package:dehub/screens/funding_request_page/funding_request_page.dart';
import 'package:dehub/screens/new_order/customer_choose.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  runApp(const MyApp());
}

GetIt locator = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
                  case HomePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    });
                  case LoginPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    });
                  case ProfilePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ProfilePage();
                    });
                  case FundingRequestDetailPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return FundingRequestDetailPage();
                    });
                  case FundingRequestPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return FundingRequestPage();
                    });
                  case PartnerInfo1.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return PartnerInfo1();
                    });
                  case NetworkPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return NetworkPage();
                    });
                  case TransactionDetailPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return TransactionDetailPage();
                    });
                  case NewInvoice.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return NewInvoice();
                    });
                  case AccountInfoPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return AccountInfoPage();
                    });
                  case InvoicePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return InvoicePage();
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
                        // listenController: arguments.listenController,
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
                  // case Bugd.routeName:
                  //   return MaterialPageRoute(builder: (context) {
                  //     return Bugd();
                  //   });
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
                  case Shirhegeer.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return Shirhegeer();
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
                        invoice: arguments.invoice,
                        data: arguments.data,
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
                  case ZoningPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ZoningPage();
                    });
                  case FinancingLogin.routeName:
                    // FinancingLoginArguments arguments =
                    //     settings.arguments as FinancingLoginArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          FinancingLogin(
                              // listenController: arguments.listenController,
                              // partnerListenController:
                              //     arguments.partnerListenController,
                              ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
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
                  case PdfPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return PdfPage();
                    });
                  case Index1.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return Index1();
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
                        method: arguments.method,
                        refCode: arguments.refCode,
                        amount: arguments.amount,
                        id: arguments.id,
                        creditAccountId: arguments.creditAccountId,
                      );
                    });

                  case MenuPage.routeName:
                    // MenuPageArguments arguments =
                    //     settings.arguments as MenuPageArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MenuPage(
                              // listenController: arguments.listenController,
                              // id: arguments.id,
                              // partnerListenController:
                              //     arguments.partnerListenController,
                              ),
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
                        var begin = const Offset(0.0, 0.1);
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
                    // OrderInvoiceArguments arguments =
                    // settings.arguments as OrderInvoiceArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          OrderInvoice(
                              // customerListenController:
                              // arguments.customerListenController,
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
                    // OrderCashPaymentArguments arguments =
                    // settings.arguments as OrderCashPaymentArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          OrderCashPayment(
                              // customerListenController:
                              // arguments.customerListenController,
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
                  case NewOrder.routeName:
                    NewOrderArguments arguments =
                        settings.arguments as NewOrderArguments;
                    return MaterialPageRoute(builder: (context) {
                      return NewOrder(
                        id: arguments.id,
                      );
                    });
                  case IncomeGuarantee.routeName:
                    // IncomeGuaranteeArguments arguments =
                    // settings.arguments as IncomeGuaranteeArguments;
                    return MaterialPageRoute(builder: (context) {
                      return IncomeGuarantee(
                          // id: arguments.id,
                          );
                    });
                  case OrderCashApproval.routeName:
                    // OrderCashApprovalArguments arguments =
                    // settings.arguments as OrderCashApprovalArguments;
                    return MaterialPageRoute(builder: (context) {
                      return OrderCashApproval(
                          // id: arguments.id,
                          );
                    });
                  case OrderPaymentPage.routeName:
                    // OrderPaymentPageArguments arguments =
                    // settings.arguments as OrderPaymentPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return OrderPaymentPage(
                          // id: arguments.id,
                          );
                    });
                  case FinancingPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return FinancingPage();
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
                  case MainInvoicePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return MainInvoicePage();
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
                    return MaterialPageRoute(builder: (context) {
                      return ReceivedFundingDetailPage();
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
                  case SalesPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return SalesPage();
                    });
                  case PurchasePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return PurchasePage();
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
                  case QpayPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return QpayPage();
                    });
                  case GiveFundingDetailPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return GiveFundingDetailPage();
                    });
                  case MainPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return MainPage();
                    });
                  case ReferenceInformationPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ReferenceInformationPage();
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
                  case PaymentConditionPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return PaymentConditionPage();
                    });
                  case AddAttachment.routeName:
                    AddAttachmentArguments arguments =
                        settings.arguments as AddAttachmentArguments;
                    return MaterialPageRoute(builder: (context) {
                      return AddAttachment(
                        pickedFile: arguments.pickedFile,
                      );
                    });
                  case AddRow.routeName:
                    AddRowArguments arguments =
                        settings.arguments as AddRowArguments;
                    return MaterialPageRoute(builder: (context) {
                      return AddRow(
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
                    // ReceiverOtpVerifyArguments arguments =
                    // settings.arguments as ReceiverOtpVerifyArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ReceiverOtpVerify(
                          // additionalRowsListenController:
                          // arguments.additionalRowsListenController,
                          );
                    });
                  case EnterPhonePage.routeName:
                    // EnterPhonePageArguments arguments =
                    // settings.arguments as EnterPhonePageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return EnterPhonePage(
                          // additionalRowsListenController:
                          // arguments.additionalRowsListenController,
                          );
                    });
                  case ExpensesPage.routeName:
                    ExpensesPageArguments arguments =
                        settings.arguments as ExpensesPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ExpensesPage(
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
                  case ReceivedOrderDetail.routeName:
                    ReceivedOrderDetailArguments arguments =
                        settings.arguments as ReceivedOrderDetailArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ReceivedOrderDetail(
                        id: arguments.id,
                      );
                    });
                  case OrderSendPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return OrderSendPage();
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
                    // OrderPaymentArguments arguments =
                    //     settings.arguments as OrderPaymentArguments;
                    return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          OrderPayment(
                              // listenController: arguments.listenController,
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
                        isPackage: arguments.isPackage,
                        businessId: arguments.businessId,
                        productListenController:
                            arguments.productListenController,
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
                        data: arguments.data,
                        goodsListenController: arguments.goodsListenController,
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
                    return MaterialPageRoute(builder: (context) {
                      return RankDetailPage();
                    });
                  case RankPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return RankPage();
                    });
                  case ProductListPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return ProductListPage();
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
                  case TakePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return TakePage();
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
                      builder: (_) => FirstPage(),
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

    return WillPopScope(
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
      onWillPop: () async {
        return shouldPop;
      },
    );
  }
}
