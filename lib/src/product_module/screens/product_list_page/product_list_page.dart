import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/new_product.dart';
import 'package:dehub/src/product_module/screens/product_list_page/tabs/goods_tab/goods_tab.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = '/ProductListPage';
  const ProductListPage({
    super.key,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          surfaceTintColor: white,
          iconTheme: const IconThemeData(color: productColor),
          title: const Text(
            'Барааны жагсаалт',
            style: TextStyle(
              color: productColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            if (Permission().check(user, "ERP_GDS", boolean: 'isCreate'))
              AddButton(
                color: productColor,
                onClick: () {
                  Navigator.of(context).pushNamed(
                    NewProduct.routeName,
                    arguments: NewProductArguments(initialIndex: 0),
                  );
                },
              ),
          ],
          bottom: TabBar(
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            indicatorColor: productColor,
            labelColor: productColor,
            unselectedLabelColor: grey2,
            tabs: const [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Бараа бүтээгдэхүүн',
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Багц бараа',
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            GoodsTab(),
            Text(''),
          ],
        ),
      ),
    );
  }
}
