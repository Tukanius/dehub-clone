import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import './tabs/buyer_led.dart';
import './tabs/supplier_led.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ReceivedFundingPage extends StatefulWidget {
  static const routeName = '/ReceivedFundingPage';
  const ReceivedFundingPage({super.key});

  @override
  State<ReceivedFundingPage> createState() => _ReceivedFundingPageState();
}

class _ReceivedFundingPageState extends State<ReceivedFundingPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.index = currentIndex;
    super.initState();
  }

  changePage(index) {
    setState(() {
      tabController.index = index;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        elevation: 0,
        leadingWidth: 100,
        leading: CustomBackButton(color: financingColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: DashboardCard(
              boxColor: financingColor,
              padding: 8,
              labelText: 'Авсан санхүүжилт',
              svgColor: white,
              svg: 'assets/svg/camera.svg',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Text(
              'Авсан санхүүжилт',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              tabButton(0, 'Buyer-Led'),
              SizedBox(
                width: 20,
              ),
              tabButton(1, 'Supplier-Led'),
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: currentIndex == index ? financingColor : backgroundColor,
          borderRadius: BorderRadius.circular(10),
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
