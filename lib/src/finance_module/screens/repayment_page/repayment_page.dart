import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/src/finance_module/screens/repayment_page/tabs/buyer_led.dart';
import 'package:dehub/src/finance_module/screens/repayment_page/tabs/supplier_led.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: CustomBackButton(color: financingColor),
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
              boxColor: financingColor,
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
              tabButton(0, "Buyer-Led"),
              SizedBox(
                width: 25,
              ),
              tabButton(1, "Supplier-Led"),
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

  Widget tabButton(int index, String label) {
    return GestureDetector(
      onTap: () {
        pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: currentIndex == index ? financingColor : backgroundColor,
        ),
        child: Text(
          '${label}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: currentIndex == index ? white : black,
          ),
        ),
      ),
    );
  }
}
