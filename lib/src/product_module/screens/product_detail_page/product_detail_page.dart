import 'package:dehub/src/product_module/screens/product_detail_page/tabs/additional_information_tab.dart';
import 'package:dehub/src/product_module/screens/product_detail_page/tabs/basic_information_tab.dart';
import 'package:dehub/src/product_module/screens/product_detail_page/tabs/order_setting_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/api/inventory_api.dart';

class ProductDetailPageArguments {
  String? id;
  ProductDetailPageArguments({
    this.id,
  });
}

class ProductDetailPage extends StatefulWidget {
  static const routeName = '/ProductDetailPage';
  final String id;
  const ProductDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with AfterLayoutMixin {
  InventoryGoods inventory = InventoryGoods();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    inventory = await InventoryApi().goodsGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          surfaceTintColor: white,
          iconTheme: const IconThemeData(color: productColor),
          title: const Text(
            'Барааны дэлгэрэнгүй',
            style: TextStyle(
              color: productColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: productColor,
            labelColor: productColor,
            unselectedLabelColor: grey2,
            tabs: const [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text('Үндсэн мэдээлэл'),
                ),
              ),
              SizedBox(
                height: 40,
                child: Center(
                  child: Text('Нэмэлт мэдээлэл'),
                ),
              ),
              SizedBox(
                height: 40,
                child: Center(
                  child: Text('Захиалга тохиргоо'),
                ),
              ),
            ],
          ),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: productColor,
                ),
              )
            : TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  BasicInformationTab(
                    data: inventory,
                  ),
                  AdditionalInformationTab(
                    data: inventory,
                  ),
                  OrderSettingTab(
                    data: inventory,
                  ),
                ],
              ),
      ),
    );
  }
}
