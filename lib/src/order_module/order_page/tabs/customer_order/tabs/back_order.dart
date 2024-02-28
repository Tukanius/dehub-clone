import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class BackOrder extends StatefulWidget {
  const BackOrder({super.key});

  @override
  State<BackOrder> createState() => _BackOrderState();
}

class _BackOrderState extends State<BackOrder> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result orders = Result(rows: [], count: 0);
  bool isLoading = true;

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(orderStatus: '');
    orders = await OrderApi()
        .backOrderList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: orderColor,
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: orders.rows!
                  .map(
                    (e) => Container(),
                  )
                  .toList(),
            ),
          );
  }
}
