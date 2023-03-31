import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/auth/login_page.dart';
import 'package:dehub/screens/invoice/invoice.dart';
import 'package:dehub/screens/invoice/new_invoice/add_product/add_product_tabs/bagtsaar.dart';
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
import 'package:dehub/screens/main/main_page.dart';
import 'package:dehub/screens/profile/information/partner_info.dart';
import 'package:dehub/screens/profile/profile_page.dart';
import 'package:dehub/screens/splash/splash_page.dart';
import 'package:dehub/services/dialog.dart';
import 'package:dehub/services/navigation.dart';
import 'package:dehub/widgets/dialog_manager/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

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
        ],
        child: Stack(
          children: [
            MaterialApp(
              title: 'E-Darkhan',
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
                  case NewInvoice.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return NewInvoice();
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
                  case GereetBish.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return GereetBish();
                    });
                  case Bagtsaar.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return Bagtsaar();
                    });
                  case Shirhegeer.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return Shirhegeer();
                    });
                  case Harah.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return Harah();
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
                    return MaterialPageRoute(builder: (context) {
                      return ProductReturnPage();
                    });
                  case PaymentApprovalPage.routeName:
                    return MaterialPageRoute(builder: (context) {
                      return PaymentApprovalPage();
                    });
                  default:
                    return MaterialPageRoute(
                      builder: (_) => const MainPage(),
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
