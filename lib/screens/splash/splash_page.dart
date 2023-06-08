import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/auth/login_page.dart';
import 'package:dehub/screens/first_page/first_page.dart';
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
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    try {
      print('===================1========================');
      await Provider.of<UserProvider>(context, listen: false).me(false);
      print('===================1========================');
      print('===================2========================');
      await Provider.of<UserProvider>(context, listen: false).partnerMe(false);
      print('===================2========================');
      await Provider.of<GeneralProvider>(context, listen: false).init(false);
      print('===================3========================');
      print('===================3========================');
      await Provider.of<GeneralProvider>(context, listen: false)
          .businessInit(false);
      await Navigator.of(context).pushNamed(FirstPage.routeName);
    } catch (e) {
      print('===================ERROR=================');
      print(e.toString());
      print('===================ERROR=================');
      await Navigator.of(context).pushNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: mainColor,
        ),
      ),
    );
  }
}
