import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/tabs/additional_tab.dart';
import 'package:dehub/src/product_module/screens/new_product/tabs/main_tab.dart';
import 'package:dehub/src/product_module/screens/new_product/tabs/order_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class NewProduct extends StatefulWidget {
  static const routeName = '/NewProduct';
  const NewProduct({Key? key}) : super(key: key);

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct>
    with AfterLayoutMixin, SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) {
    Provider.of<IndexProvider>(context, listen: false).newProductIndexChange(0);
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
        leading: CustomBackButton(color: productColor),
        elevation: 2,
        shadowColor: grey,
        surfaceTintColor: white,
        backgroundColor: white,
        foregroundColor: white,
        bottom: TabBar(
          controller: tabController,
          overlayColor: MaterialStatePropertyAll(transparent),
          labelColor: productColor,
          unselectedLabelColor: dark,
          indicatorColor: productColor,
          onTap: (value) {
            if (tabController.indexIsChanging) {
              tabController.index = tabController.previousIndex;
            } else {
              return;
            }
          },
          tabs: [
            Tab(
              text: 'Үндсэн',
            ),
            Tab(
              text: 'Нэмэлт',
            ),
            Tab(
              text: 'Захиалга',
            ),
          ],
        ),
      ),
      body: isLoading == true
          ? SizedBox()
          : TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                MainTab(),
                AdditionalTab(),
                OrderTab(),
              ],
            ),
    );
  }
}
