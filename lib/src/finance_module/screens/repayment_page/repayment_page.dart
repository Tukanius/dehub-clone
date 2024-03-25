import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/repayment_page/tabs/supplier_led.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RePayment extends StatefulWidget {
  static const routeName = '/RePayment';
  const RePayment({super.key});

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
            margin: const EdgeInsets.only(left: 15),
            child: const Text(
              'Эргэн төлөлтүүд',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const Expanded(
            child: SupplierLed(),
          ),
        ],
      ),
    );
  }
}
