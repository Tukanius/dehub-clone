import 'package:dehub/src/product_module/screens/price_group/tabs/special_price.dart';
import 'package:dehub/src/product_module/screens/price_group/tabs/standard_price_history.dart';
import 'package:dehub/src/product_module/screens/price_group/tabs/standard_price_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class PriceGroupPage extends StatefulWidget {
  static const routeName = '/PriceGrouPage';
  const PriceGroupPage({super.key});

  @override
  State<PriceGroupPage> createState() => _PriceGroupPageState();
}

class _PriceGroupPageState extends State<PriceGroupPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: white,
          surfaceTintColor: white,
          iconTheme: const IconThemeData(color: productColor),
          title: const Text(
            'Үнийн бодлого',
            style: TextStyle(
              color: productColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: productColor,
            labelColor: productColor,
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            unselectedLabelColor: grey2,
            tabs: const [
              Tab(
                text: 'Стандарт үнэ',
              ),
              Tab(
                text: 'Стандарт үнийн түүх',
              ),
              Tab(
                text: 'Тусгай үнэ',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            StandardPriceTab(),
            StandardPriceHistory(),
            SpecialPrice(),
          ],
        ),
      ),
    );
  }
}
