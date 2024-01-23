import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/providers/finance_provider.dart';
import './tabs/buyer_led.dart';
import './tabs/supplier_led.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        elevation: 0,
        leadingWidth: 100,
        leading: CustomBackButton(color: source.currentColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: DashboardCard(
              boxColor: source.currentColor,
              padding: 8,
              labelText: 'Авсан санхүүжилт',
              svgColor: white,
              svg: 'assets/svg/camera.svg',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: const Text(
              'Авсан санхүүжилт',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color:
                        currentIndex == 0 ? source.currentColor : transparent,
                    borderRadius: BorderRadius.circular(10),
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
              const SizedBox(
                width: 20,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color:
                        currentIndex == 1 ? source.currentColor : transparent,
                    borderRadius: BorderRadius.circular(10),
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
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              children: const [
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
