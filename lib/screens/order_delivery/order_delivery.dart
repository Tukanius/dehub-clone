import 'package:dehub/screens/order_delivery/tabs/delivery.dart';
import 'package:dehub/screens/order_delivery/tabs/delivery_made.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class OrderDelivery extends StatefulWidget {
  static const routeName = '/OrderDelivery';
  const OrderDelivery({Key? key}) : super(key: key);

  @override
  State<OrderDelivery> createState() => _OrderDeliveryState();
}

class _OrderDeliveryState extends State<OrderDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: orderColor,
          ),
        ),
        title: Text(
          'Захиалга хүргэлт',
          style: TextStyle(
            color: buttonColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: grey,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  color: white,
                  child: TabBar(
                    labelColor: orderColor,
                    indicatorColor: orderColor,
                    unselectedLabelColor: buttonColor,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text('Хүргэлт хийх'),
                      ),
                      Container(
                        child: Text('Хүргэлт хийсэн'),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Delivery(),
              DeliveryMade(),
            ],
          ),
        ),
      ),
    );
  }
}
