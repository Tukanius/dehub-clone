import 'package:dehub/screens/product_page/tabs/home_page_tab/product_detail_page/tabs/additional_information_tab.dart';
import 'package:dehub/screens/product_page/tabs/home_page_tab/product_detail_page/tabs/basic_information_tab.dart';
import 'package:dehub/screens/product_page/tabs/home_page_tab/product_detail_page/tabs/order_setting_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  static const routeName = 'ProductDetailPage';
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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
            'Барааны дэлгэрэнгүй',
            style: TextStyle(
              color: productColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: productColor,
            labelColor: productColor,
            unselectedLabelColor: grey2,
            tabs: [
              Container(
                height: 40,
                child: Center(
                  child: Text('Үндсэн мэдээлэл'),
                ),
              ),
              Container(
                height: 40,
                child: Center(
                  child: Text('Нэмэлт мэдээлэл'),
                ),
              ),
              Container(
                height: 40,
                child: Center(
                  child: Text('Захиалга тохиргоо'),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            BasicInformationTab(),
            AdditionalInformationTab(),
            OrderSettingTab(),
          ],
        ),
      ),
    );
  }
}
