import 'package:dehub/screens/auth/login_page.dart';
import 'package:dehub/screens/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

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
    try {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    } catch (e) {
      Navigator.of(context).pushReplacementNamed(MainPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
