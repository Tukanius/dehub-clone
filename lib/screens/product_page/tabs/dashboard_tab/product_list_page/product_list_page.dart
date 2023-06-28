import 'package:dehub/screens/product_page/tabs/dashboard_tab/product_list_page/tabs/goods_tab/goods_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = '/ProductListPage';
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          iconTheme: IconThemeData(color: productColor),
          title: Text(
            'Барааны жагсаалт',
            style: TextStyle(
              color: productColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            indicatorColor: productColor,
            isScrollable: true,
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
                    'Ажил үйлчилгээ',
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
            Text('1'),
          ],
        ),
      ),
    );
  }
}
