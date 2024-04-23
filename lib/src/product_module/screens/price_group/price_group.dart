import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/change_standard_price/change_standard_price.dart';
import 'package:dehub/src/product_module/screens/price_group/tabs/special_price.dart';
import 'package:dehub/src/product_module/screens/price_group/tabs/standard_price_history.dart';
import 'package:dehub/src/product_module/screens/price_group/tabs/standard_price_tab.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceGroupPage extends StatefulWidget {
  static const routeName = '/PriceGrouPage';
  const PriceGroupPage({super.key});

  @override
  State<PriceGroupPage> createState() => _PriceGroupPageState();
}

class _PriceGroupPageState extends State<PriceGroupPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  User user = User();

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;
    return Scaffold(
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
        actions: [
          if (tabController.index == 0 &&
              Permission().check(user, "ERP_STD_PRICE"))
            AddButton(
              onClick: () {
                Navigator.of(context).pushNamed(
                  ChangeStandardPrice.routeName,
                  arguments: ChangeStandardPriceArguments(
                    type: "GROUP",
                  ),
                );
              },
              color: productColor,
            )
          else if (tabController.index == 2 &&
              Permission().check(user, "ERP_PG", boolean: 'isCreate'))
            AddButton(
              onClick: () {
                Navigator.of(context).pushNamed(
                  ChangeStandardPrice.routeName,
                  arguments: ChangeStandardPriceArguments(
                    type: "SPECIAL",
                  ),
                );
              },
              color: productColor,
            )
        ],
        bottom: TabBar(
          controller: tabController,
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
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const StandardPriceTab(),
          Permission().check(user, "ERP_PG", boolean: 'isview')
              ? const StandardPriceHistory()
              : const NotFound(
                  module: "INVENTORY",
                  labelText: 'Хандах эрх хүрэлцэхгүй байна',
                ),
          Permission().check(user, "ERP_PG", boolean: 'isview')
              ? const SpecialPrice()
              : const NotFound(
                  module: "INVENTORY",
                  labelText: 'Хандах эрх хүрэлцэхгүй байна',
                ),
        ],
      ),
    );
  }
}
