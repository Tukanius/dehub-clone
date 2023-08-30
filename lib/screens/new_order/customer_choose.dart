import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/order_customer_card/order_customer_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class OrderCustomerChooseArguments {
  ListenController customerListenController;
  OrderCustomerChooseArguments({
    required this.customerListenController,
  });
}

class OrderCustomerChoose extends StatefulWidget {
  final ListenController customerListenController;
  static const routeName = '/OrderCustomerChoose';
  const OrderCustomerChoose({
    Key? key,
    required this.customerListenController,
  }) : super(key: key);

  @override
  State<OrderCustomerChoose> createState() => _OrderCustomerChooseState();
}

class _OrderCustomerChooseState extends State<OrderCustomerChoose>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result customer = Result(count: 0, rows: []);

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(categoryId: '');
    var res = await OrderApi()
        .networkList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      customer = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
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
          'Харилцагч сонгох',
          style: TextStyle(
            color: buttonColor,
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: orderColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SearchButton(
                    color: orderColor,
                    textColor: orderColor,
                  ),
                  Column(
                    children: customer.rows!
                        .map(
                          (item) => OrderCustomerCard(
                            onClick: () {
                              widget.customerListenController
                                  .customerOrderChange(item);
                              Navigator.of(context).pop();
                            },
                            data: item,
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
    );
  }
}
