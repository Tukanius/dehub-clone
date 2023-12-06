import 'package:dehub/components/avaible_funding_card/avaible_funding_card.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/avaible_funding_detail/avaible_funding_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvaibleFundingPage extends StatefulWidget {
  static const routeName = '/AvaibleFundingPage';
  const AvaibleFundingPage({super.key});

  @override
  State<AvaibleFundingPage> createState() => _AvaibleFundingPageState();
}

class _AvaibleFundingPageState extends State<AvaibleFundingPage> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        surfaceTintColor: backgroundColor,
        backgroundColor: backgroundColor,
        leading: CustomBackButton(
          color: source.currentColor,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade200,
            ),
            width: 35,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                'Санхүүжих боломжтой',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            AvaibleFundingCard(
              onClick: () {
                Navigator.of(context)
                    .pushNamed(AvaibleFundingDetailPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
