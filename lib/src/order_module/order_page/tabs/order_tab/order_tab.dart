import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/order_page/tabs/order_tab/tabs/sales_tab.dart';
import 'package:dehub/src/order_module/order_page/tabs/order_tab/tabs/split_order.dart';
import 'package:dehub/src/order_module/screens/new_order/new_order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderTab extends StatefulWidget {
  const OrderTab({super.key});

  @override
  State<OrderTab> createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab>
    with SingleTickerProviderStateMixin {
  User user = User();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: tabController.index == 0
          ? FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: orderColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  NewOrder.routeName,
                  arguments: NewOrderArguments(
                    id: null,
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                color: white,
              ),
            )
          : null,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Material(
                    color: white,
                    child: TabBar(
                      controller: tabController,
                      overlayColor:
                          MaterialStatePropertyAll(Colors.grey.shade100),
                      indicatorColor: orderColor,
                      unselectedLabelColor: buttonColor,
                      labelColor: orderColor,
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      tabs: [
                        Container(
                          alignment: Alignment.center,
                          height: 45,
                          child: const Text(
                            'Нийт захиалга',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 45,
                          child: const Text(
                            'Хэсэгчлэн хүргэх',
                            style: TextStyle(fontFamily: 'Montserrat'),
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
          controller: tabController,
          children: const [
            SalesTab(),
            SplitOrder(),
          ],
        ),
      ),
    );
  }
}
