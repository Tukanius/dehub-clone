import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/auth/login_page.dart';
import 'package:dehub/screens/entry_point/entry_point.dart';
// import 'package:dehub/screens/first_page/first_page.dart';
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
      await Provider.of<UserProvider>(context, listen: false).me(false);
      await Provider.of<UserProvider>(context, listen: false).partnerMe(false);
      await Navigator.of(context).pushNamed(EntryPoint.routeName);
    } catch (e) {
      debugPrint('===================ERROR=================');
      debugPrint(e.toString());
      debugPrint('===================ERROR=================');
      await Navigator.of(context).pushNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: buttonColor,
        ),
      ),
    );
  }
}
