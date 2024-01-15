import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import './tabs/supplier_led.dart';
import './tabs/buyer_led.dart';

class AvailableFundingPageArguments {
  String id;
  AvailableFundingPageArguments({
    required this.id,
  });
}

class AvailableFundingPage extends StatefulWidget {
  static const routeName = '/AvailableFundingPage';
  final String id;
  const AvailableFundingPage({
    super.key,
    required this.id,
  });

  @override
  State<AvailableFundingPage> createState() => _AvailableFundingPageState();
}

class _AvailableFundingPageState extends State<AvailableFundingPage>
    with AfterLayoutMixin {
  bool isLoading = true;
  PageController pageController = PageController();
  int initialIndex = 0;

  @override
  afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leadingWidth: 130,
        leading: CustomBackButton(color: source.currentColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: DashboardCard(
              boxColor: source.currentColor,
              padding: 10,
              labelText: 'Боломжит нэхэмжлэх',
              svgColor: white,
              svg: 'assets/svg/available_invoice.svg',
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Боломжит нэхэмжлэхүүд',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        initialIndex == 0 ? source.currentColor : transparent,
                  ),
                  child: Text(
                    'Supplier Led',
                    style: TextStyle(
                      color: initialIndex == 0 ? white : black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        initialIndex == 1 ? source.currentColor : transparent,
                  ),
                  child: Text(
                    'Buyer Led',
                    style: TextStyle(
                      color: initialIndex == 1 ? white : black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                  initialIndex = value;
                });
              },
              children: [
                SupplierLed(
                  id: widget.id,
                ),
                BuyerLed(
                  id: widget.id,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
