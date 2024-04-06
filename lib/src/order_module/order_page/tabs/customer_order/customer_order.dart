import 'package:after_layout/after_layout.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/order_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/order_page/tabs/customer_order/tabs/back_order.dart';
import 'package:dehub/src/order_module/order_page/tabs/customer_order/tabs/received_tab.dart';
import 'package:dehub/src/order_module/screens/create_back_order/create_back_order.dart';
import 'package:dehub/src/order_module/screens/new_order/new_order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerOrder extends StatefulWidget {
  const CustomerOrder({super.key});

  @override
  State<CustomerOrder> createState() => _CustomerOrderState();
}

class _CustomerOrderState extends State<CustomerOrder>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  late TabController tabController;
  bool isLoading = true;
  User user = User();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<OrderProvider>(context, listen: false).clearData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<OrderProvider>(context, listen: true);
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
    return Scaffold(
      floatingActionButton: user.currentBusiness?.type == "SUPPLIER"
          ? source.backorderList.isNotEmpty
              ? InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      CreateBackOrder.routeName,
                      arguments: CreateBackOrderArguments(
                        orders: source.backorderList,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: orderColor,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Багцлах',
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              : null
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  NewOrder.routeName,
                  arguments: NewOrderArguments(data: null, id: null),
                );
              },
              backgroundColor: orderColor,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                color: white,
              ),
            ),
      backgroundColor: backgroundColor,
      body: user.currentBusiness?.type == "SUPPLIER"
          ? NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Material(
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
                              'Хүлээн авсан',
                              style: TextStyle(fontFamily: 'Montserrat'),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 45,
                            child: const Text(
                              'Багцалж илгээсэн',
                              style: TextStyle(fontFamily: 'Montserrat'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: isLoading == true
                  ? const SizedBox()
                  : TabBarView(
                      controller: tabController,
                      children: const [
                        ReceivedTab(),
                        BackOrder(),
                      ],
                    ),
            )
          : const ReceivedTab(),
    );
  }
}
