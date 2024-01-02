import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/src/product_module/screens/new_product/new_product.dart';
import 'package:dehub/src/product_module/screens/product_list_page/tabs/goods_tab/goods_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = '/ProductListPage';
  const ProductListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          surfaceTintColor: white,
          iconTheme: IconThemeData(color: productColor),
          title: Text(
            'Барааны жагсаалт',
            style: TextStyle(
              color: productColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            AddButton(
              color: productColor,
              onClick: () {
                Navigator.of(context).pushNamed(NewProduct.routeName);
              },
            ),
          ],
          bottom: TabBar(
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            indicatorColor: productColor,
            labelColor: productColor,
            unselectedLabelColor: grey2,
            tabs: [
              Container(
                height: 40,
                child: Center(
                  child: Text(
                    'Бараа бүтээгдэхүүн',
                  ),
                ),
              ),
              Container(
                height: 40,
                child: Center(
                  child: Text(
                    'Багц үйлчилгээ',
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            GoodsTab(),
            Text('1'),
          ],
        ),
      ),
    );
  }
}
