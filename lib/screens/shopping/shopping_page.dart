import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/components/product_card/product_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/supplier_card/supplier_card.dart';
import 'package:dehub/screens/shopping/tabs/invoice.dart';
import 'package:dehub/screens/shopping/tabs/order.dart';
import 'package:dehub/screens/shopping/tabs/payment.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShoppingPage extends StatefulWidget {
  static const routeName = '/shoppingpage';
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        title: Text(
          'АПУ ХК',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            decoration: BoxDecoration(
              color: orange,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 21),
            child: Row(
              children: [
                Icon(
                  Icons.add_shopping_cart_outlined,
                  color: white,
                  size: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '+5',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: SvgPicture.asset('images/banner.svg'),
                ),
              ),
              SliverToBoxAdapter(
                child: SupplierCard(
                  shoppingCard: true,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  color: white,
                  child: TabBar(
                    isScrollable: true,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    indicatorColor: buttonColor,
                    labelColor: buttonColor,
                    unselectedLabelColor: Color(0xff263238),
                    tabs: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Бараа',
                        ),
                      ),
                      Text(
                        'Нэхэмжлэх',
                      ),
                      Text(
                        'Захиалга',
                      ),
                      Text(
                        'Төлбөр',
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SearchButton(
                  color: grey2,
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ProductCard(),
              Invoice(),
              Order(),
              Payment(),
            ],
          ),
        ),
      ),
    );
  }
}
