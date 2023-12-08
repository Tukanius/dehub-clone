import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/finance_module/financing_page/financing_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/src/auth/financing_login.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class FinanceEntry extends StatefulWidget {
  static const routeName = '/FinanceEntry';
  const FinanceEntry({Key? key}) : super(key: key);

  @override
  State<FinanceEntry> createState() => _FinanceEntryState();
}

class _FinanceEntryState extends State<FinanceEntry> with AfterLayoutMixin {
  bool isLoading = true;
  @override
  afterFirstLayout(BuildContext context) async {
    try {
      await Provider.of<UserProvider>(context, listen: false).financeMe();
      Navigator.of(context).pushNamed(FinancingPage.routeName);
      isLoading = false;
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Scaffold()
        : Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              surfaceTintColor: white,
              title: Text(
                'Санхүүжилт модуль',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  GridView.count(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    shrinkWrap: true,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 25,
                    crossAxisCount: 2,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Provider.of<FinanceProvider>(context,
                                  listen: false)
                              .colorChange("Голомт Банк");
                          await Navigator.of(context)
                              .pushNamed(FinancingLogin.routeName);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: transparent,
                            border: Border.all(
                              color: grey,
                            ),
                            image: DecorationImage(
                              image: AssetImage('images/golomt.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Provider.of<FinanceProvider>(context,
                                  listen: false)
                              .colorChange("Богд Банк");
                          await Navigator.of(context)
                              .pushNamed(FinancingLogin.routeName);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: transparent,
                            border: Border.all(
                              color: grey,
                            ),
                          ),
                          child: Image.asset(
                            'images/bogd.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Provider.of<FinanceProvider>(context,
                                  listen: false)
                              .colorChange("DeHUB");
                          await Navigator.of(context)
                              .pushNamed(FinancingLogin.routeName);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: transparent,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: grey,
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/logo.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Санхүүжилтийн хөтөлбөрт хамрагдах банкаа сонгоно уу.',
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
  }
}
