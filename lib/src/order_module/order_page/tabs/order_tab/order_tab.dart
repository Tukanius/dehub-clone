import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/new_order/new_order.dart';
import 'package:dehub/src/order_module/order_page/tabs/order_tab/tabs/received_tab.dart';
import 'package:dehub/src/order_module/order_page/tabs/order_tab/tabs/sales_tab.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;

    return DefaultTabController(
      length: 2,
      child:
          // NestedScrollView(
          //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          //     return [
          //       SliverToBoxAdapter(
          //         child: Container(
          //           color: white,
          //           child:
          Column(
        children: [
          Material(
            color: white,
            child: TabBar(
              indicatorColor: orderColor,
              unselectedLabelColor: buttonColor,
              labelColor: orderColor,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              tabs: [
                Container(
                  alignment: Alignment.center,
                  height: 45,
                  child: user.currentBusiness?.type == "SUPPLIER"
                      ? Text(
                          'Борлуулалт',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        )
                      : Text(
                          'Худалдан авалт',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 45,
                  child: Text(
                    'Хүлээн авсан',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Stack(
                  children: [
                    SalesTab(),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingActionButton(
                        backgroundColor: orderColor,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            NewOrder.routeName,
                            arguments: NewOrderArguments(
                              id: null,
                            ),
                          );
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
                ReceivedTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
