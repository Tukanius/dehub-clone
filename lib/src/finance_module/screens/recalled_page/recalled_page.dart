import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/recalled_page/tabs/supplier_led.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReCalledPage extends StatefulWidget {
  static const routeName = '/ReCalledPage';
  const ReCalledPage({super.key});

  @override
  State<ReCalledPage> createState() => _ReCalledPageState();
}

class _ReCalledPageState extends State<ReCalledPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        leading: CustomBackButton(color: source.currentColor),
        actions: const [
          CircleAvatar(
            radius: 18,
            backgroundColor: grey,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 10),
                    child: DashboardCard(
                      boxColor: source.currentColor,
                      padding: 10,
                      labelText: 'Буцаан дуудсан',
                      svgColor: white,
                      svg: 'assets/svg/return.svg',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Буцаан дуудсан',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: const SupplierLed(),
      ),
    );
  }
}
