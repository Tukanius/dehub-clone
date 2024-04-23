import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/product_page/tabs/resource_tab/tabs/remaining_stock.dart';
import 'package:dehub/src/product_module/product_page/tabs/resource_tab/tabs/residual_setting.dart';
import 'package:dehub/src/product_module/screens/adjustment/adjustment.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResourceTab extends StatefulWidget {
  const ResourceTab({super.key});

  @override
  State<ResourceTab> createState() => _ResourceTabState();
}

class _ResourceTabState extends State<ResourceTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  User user = User();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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
      floatingActionButton: tabController.index == 1 &&
              Permission().check(user, "ERP_STOCK_ADJ", boolean: 'isCreate')
          ? FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: productColor,
              onPressed: () {
                Navigator.of(context).pushNamed(Adjustment.routeName);
              },
              child: const Icon(
                Icons.add,
                color: white,
              ),
            )
          : null,
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            labelColor: productColor,
            unselectedLabelColor: grey2,
            isScrollable: true,
            indicatorColor: productColor,
            tabAlignment: TabAlignment.start,
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade200),
            tabs: const [
              Tab(
                text: 'Үлдэгдэл нөөц',
              ),
              Tab(
                text: 'Үлдэгдэл тохиргоо',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                const RemainingStock(),
                Permission().check(user, "ERP_STOCK_ADJ", boolean: 'isView')
                    ? const ResidualSetting()
                    : const NotFound(
                        module: "INVENTORY",
                        labelText: 'Хандах эрх хүрэлцэхгүй байна',
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
