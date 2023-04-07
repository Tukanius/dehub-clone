import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/auth/login_page.dart';
import 'package:dehub/screens/home/home_page.dart';
import 'package:dehub/screens/main/main_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splashpage';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with AfterLayoutMixin<SplashPage> {
  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).me(true);
    var accessToken = await UserProvider.getAccessToken();
    if (accessToken != null) {
      await Navigator.of(context).pushNamed(MainPage.routeName);
    } else {
      await Navigator.of(context).pushNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          // child: CircularProgressIndicator(
          //   color: buttonColor,
          // ),
          ),
    );
  }
}
