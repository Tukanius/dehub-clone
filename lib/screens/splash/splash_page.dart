import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/auth/login_page.dart';
import 'package:dehub/screens/main/main_page.dart';
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
  User user = User();
  @override
  afterFirstLayout(BuildContext context) async {
    try {
      if (user.id == null) {
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      } else {
        Navigator.of(context).pushNamed(MainPage.routeName);
      }
    } catch (e) {
      Navigator.of(context).pushReplacementNamed(MainPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      body: Center(),
    );
  }
}
