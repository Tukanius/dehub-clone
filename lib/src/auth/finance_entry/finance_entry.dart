import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/src/auth/financing_login.dart';
import 'package:provider/provider.dart';

class FinanceEntry extends StatefulWidget {
  static const routeName = '/FinanceEntry';
  const FinanceEntry({Key? key}) : super(key: key);

  @override
  State<FinanceEntry> createState() => _FinanceEntryState();
}

class _FinanceEntryState extends State<FinanceEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            GestureDetector(
              onTap: () async {
                await Provider.of<FinanceProvider>(context, listen: false)
                    .colorChange("Голомт Банк");
                await Navigator.of(context).pushNamed(FinancingLogin.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: transparent,
                  border: Border.all(
                    color: grey,
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/svg/golomt.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                await Provider.of<FinanceProvider>(context, listen: false)
                    .colorChange("Богд Банк");
                await Navigator.of(context).pushNamed(FinancingLogin.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                await Provider.of<FinanceProvider>(context, listen: false)
                    .colorChange("DeHUB");
                await Navigator.of(context).pushNamed(FinancingLogin.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: grey,
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/logo.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DeHUB',
                          style: TextStyle(
                            color: Color(0xff2e3192),
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          'Digital Era',
                          style: TextStyle(
                            color: Color(0xff2e3192),
                            fontSize: 25,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // if (widget.isFinanceLogin == true) {
                //   Navigator.of(context).pushNamed(FinancingPage.routeName);
                // } else {
                //   Navigator.of(context).pushNamed(FinancingLogin.routeName);
                // }