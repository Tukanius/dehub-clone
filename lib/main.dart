import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/auth/login_page.dart';
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
