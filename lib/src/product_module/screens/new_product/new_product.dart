import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/tabs/dynamic_tab.dart';
import 'package:dehub/src/product_module/screens/new_product/tabs/main_tab.dart';
import 'package:dehub/src/product_module/screens/new_product/tabs/order_setting_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class NewProductArguments {
  int initialIndex;
  InventoryGoods? data;
  NewProductArguments({
    this.data,
    required this.initialIndex,
  });
}

class NewProduct extends StatefulWidget {
  final int initialIndex;
  final InventoryGoods? data;
  static const routeName = '/NewProduct';
  const NewProduct({
    super.key,
    this.data,
    required this.initialIndex,
  });

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct>
    with AfterLayoutMixin, SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) {
    Provider.of<IndexProvider>(context, listen: false)
        .newProductIndexChange(widget.initialIndex);
    Provider.of<InventoryProvider>(context, listen: false).clearData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tabController.index =
        Provider.of<IndexProvider>(context, listen: true).newProductIndex;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leadingWidth: 130,
        leading: const CustomBackButton(color: productColor),
        elevation: 2,
        shadowColor: grey,
        surfaceTintColor: white,
        backgroundColor: white,
        foregroundColor: white,
        bottom: TabBar(
          controller: tabController,
          overlayColor: const MaterialStatePropertyAll(transparent),
          labelColor: productColor,
          unselectedLabelColor: dark,
          indicatorColor: productColor,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          onTap: (value) {
            if (tabController.indexIsChanging) {
              tabController.index = tabController.previousIndex;
            } else {
              return;
            }
          },
          tabs: const [
            Tab(
              text: 'Үндсэн мэдээлэл',
            ),
            Tab(
              text: 'Динамик мэдээлэл',
            ),
            Tab(
              text: 'Захиалга тохиргоо',
            ),
          ],
        ),
      ),
      body: isLoading == true
          ? const SizedBox()
          : TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                const MainTab(),
                DynamicTab(
                  id: widget.data?.id,
                ),
                OrderSettingTab(
                  data: widget.data,
                ),
              ],
            ),
    );
  }
}
