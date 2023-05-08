import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/account_info_page/account_info_page.dart';
import 'package:dehub/screens/account_info_page/tabs/tabs/transaction_detail_page.dart';
import 'package:dehub/screens/add_bank_account_page/add_bank_account_page.dart';
import 'package:dehub/screens/auth/login_page.dart';
import 'package:dehub/screens/avaible_funding_page/avaible_funding_detail_page.dart';
import 'package:dehub/screens/avaible_funding_page/avaible_funding_page.dart';
import 'package:dehub/screens/avaible_funding_page/request_approval_page.dart';
import 'package:dehub/screens/debt_page/debt_page.dart';
import 'package:dehub/screens/financing_page/financing_page.dart';
import 'package:dehub/screens/first_page/first_page.dart';
import 'package:dehub/screens/home_page/home_page.dart';
import 'package:dehub/screens/invoice/payment_page/qpay_page.dart';
import 'package:dehub/screens/network_page/tabs/inbox_tab/tabs/invitation_detail_page/invitation_detail_page.dart';
import 'package:dehub/screens/invoice/invoice_page.dart';
import 'package:dehub/screens/invoice/new_invoice/add_product/add_product_tabs/shirhegeer.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/bugd.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/gereet.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/gereet_bish.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/salbar_songoh.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/harah.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/index1.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/pdf_page.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/send_page.dart';
import 'package:dehub/screens/invoice/new_invoice/new_invoice.dart';
import 'package:dehub/screens/invoice/payment_page/payment_approval_page.dart';
import 'package:dehub/screens/invoice/product_return/product_return.dart';
import 'package:dehub/screens/link_account_page/link_account_page.dart';
import 'package:dehub/screens/main/main_page.dart';
import 'package:dehub/screens/menu/menu_page.dart';
import 'package:dehub/screens/network_page/network_page.dart';
import 'package:dehub/screens/order_page/order_page.dart';
import 'package:dehub/screens/partner_page/partner_page.dart';
import 'package:dehub/screens/payment_page/payment_page.dart';
import 'package:dehub/screens/product_page/product_page.dart';
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
                    return MaterialPageRoute(builder: (context) {
                      return const InvitationDetailPage();
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
                    return MaterialPageRoute(builder: (context) {
                      return CustomerChoose();
                    });
                  case SalbarSongoh.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return SalbarSongoh();
                    });
                  case Bugd.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return Bugd();
                    });
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

                  case Shirhegeer.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return Shirhegeer();
                    });
                  case Harah.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return Harah();
                    });
                  case FirstPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return FirstPage();
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
                  case ProductReturnPage.routeName:
                    ProductReturnPageArguments arguments =
                        settings.arguments as ProductReturnPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ProductReturnPage(
                        id: arguments.id,
                      );
                    });
                  case ProductReturnPage.routeName:
                    ProductReturnPageArguments arguments =
                        settings.arguments as ProductReturnPageArguments;
                    return MaterialPageRoute(builder: (context) {
                      return ProductReturnPage(
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
                    return MaterialPageRoute(builder: (context) {
                      return MenuPage();
                    });
                  case DebtPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return DebtPage();
                    });
                  case FinancingPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return FinancingPage();
                    });
                  case MainInvoicePage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return MainInvoicePage();
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
                  case UserMangementPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return UserMangementPage();
                    });
                  case PartnerPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return PartnerPage();
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
                  default:
                    return MaterialPageRoute(
                      builder: (_) => MainPage(),
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
