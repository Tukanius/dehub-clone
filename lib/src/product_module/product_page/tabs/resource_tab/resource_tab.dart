import 'package:dehub/src/product_module/product_page/tabs/resource_tab/tabs/remaining_stock.dart';
import 'package:dehub/src/product_module/product_page/tabs/resource_tab/tabs/residual_setting.dart';
import 'package:dehub/src/product_module/screens/adjustment/adjustment.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ResourceTab extends StatefulWidget {
  const ResourceTab({super.key});

  @override
  State<ResourceTab> createState() => _ResourceTabState();
}

class _ResourceTabState extends State<ResourceTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Stack(
                children: [
                  const ResidualSetting(),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: productColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(Adjustment.routeName);
                      },
                      child: const Icon(
                        Icons.add,
                        color: white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
