import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/src/auth/financing_login.dart';
import 'package:provider/provider.dart';

class FinanceEntry extends StatefulWidget {
  static const routeName = '/FinanceEntry';
  const FinanceEntry({super.key});

  @override
  State<FinanceEntry> createState() => _FinanceEntryState();
}

class _FinanceEntryState extends State<FinanceEntry> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        title: const Text(
          'Санхүүжилт модуль',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 45),
              shrinkWrap: true,
              mainAxisSpacing: 25,
              crossAxisSpacing: 25,
              crossAxisCount: 2,
              children: [
                GestureDetector(
                  onTap: () async {
                    await source.bankSelect("Голомт Банк");
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
                      image: const DecorationImage(
                        image: AssetImage('images/golomt.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await source.bankSelect("Богд Банк");
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
                    await source.bankSelect("DeHUB");
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
            const SizedBox(
              height: 30,
            ),
            const Text(
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
