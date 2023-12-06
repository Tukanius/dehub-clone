import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/repayment_page/tabs/buyer_led.dart';
import 'package:dehub/src/finance_module/screens/repayment_page/tabs/supplier_led.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RePayment extends StatefulWidget {
  static const routeName = '/RePayment';
  const RePayment({Key? key}) : super(key: key);

  @override
  State<RePayment> createState() => _RePaymentState();
}

class _RePaymentState extends State<RePayment>
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
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: grey,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: DashboardCard(
              boxColor: source.currentColor,
              padding: 10,
              labelText: 'Эргэн төлөлтүүд',
              svgColor: white,
              svg: 'assets/svg/payback.svg',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, bottom: 10),
            child: Text(
              'Эргэн төлөлтүүд',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  pageController.animateToPage(0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: currentIndex == 0
                        ? source.currentColor
                        : backgroundColor,
                  ),
                  child: Text(
                    'Buyer-Led',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: currentIndex == 0 ? white : black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              GestureDetector(
                onTap: () {
                  pageController.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: currentIndex == 1
                        ? source.currentColor
                        : backgroundColor,
                  ),
                  child: Text(
                    'Supplier-Led',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: currentIndex == 1 ? white : black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              children: [
                BuyerLed(),
                SupplierLed(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
