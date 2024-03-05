import 'package:dehub/src/entry_point/menu/shopping/tabs/invoice.dart';
import 'package:dehub/src/entry_point/menu/shopping/tabs/order.dart';
import 'package:dehub/src/entry_point/menu/shopping/tabs/payment.dart';
import 'package:dehub/src/entry_point/menu/shopping/tabs/product.dart';
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
  bool gridview = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        surfaceTintColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        title: const Text(
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
            child: const Row(
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
                  style: TextStyle(fontSize: 12, color: white),
                ),
              ],
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 6,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: SvgPicture.asset('assets/svg/banner.svg'),
                ),
              ),
              SliverToBoxAdapter(
                child: Material(
                  color: white,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: TabBar(
                      tabAlignment: TabAlignment.start,
                      overlayColor:
                          MaterialStatePropertyAll(Colors.grey.shade100),
                      isScrollable: true,
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      indicatorColor: buttonColor,
                      labelColor: buttonColor,
                      unselectedLabelColor: dark,
                      tabs: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Text(
                            'Бараа',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Text(
                            'Нэхэмжлэх',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Text(
                            'Захиалга',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Text(
                            'Төлбөр',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Text(
                            'Зээл тооцоо',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const Text(
                            'Нөхцөл',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: white,
                      height: 50,
                      padding:
                          const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey3.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: SvgPicture.asset(
                                'assets/svg/yuluur.svg',
                                colorFilter: const ColorFilter.mode(
                                    grey2, BlendMode.srcIn),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: grey3.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: const Icon(
                                  Icons.search,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: grey3.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  gridview = !gridview;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: SvgPicture.asset(
                                  'assets/svg/filter.svg',
                                  colorFilter: const ColorFilter.mode(
                                      grey2, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Product(
                gridview: gridview,
              ),
              const Invoice(),
              const Order(),
              const ShoppingPayment(),
              const Text('Зээл тооцоо'),
              const Text('Нөхцөл'),
            ],
          ),
        ),
      ),
    );
  }
}
