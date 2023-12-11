import 'package:dehub/components/back_button/back_button.dart';
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

class _NewProductState extends State<NewProduct> with AfterLayoutMixin {
  @override
  afterFirstLayout(BuildContext context) {
    Provider.of<InventoryProvider>(context, listen: false).clearData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leadingWidth: 130,
          leading: CustomBackButton(color: productColor),
          elevation: 0,
          backgroundColor: white,
          bottom: TabBar(
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            labelColor: productColor,
            unselectedLabelColor: dark,
            indicatorColor: productColor,
            tabs: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Үндсэн",
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Нэмэлт",
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Захиалга",
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MainTab(),
            AdditionalTab(),
            OrderTab(),
          ],
        ),
      ),
    );
  }
}
