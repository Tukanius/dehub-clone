import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/split_order_card/split_order_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/order_module/screens/received_order_detail/received_order_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SplitOrder extends StatefulWidget {
  const SplitOrder({super.key});

  @override
  State<SplitOrder> createState() => _SplitOrderState();
}

class _SplitOrderState extends State<SplitOrder> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result splits = Result(rows: [], count: 0);
  ListenController listenController = ListenController();
  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(excel: false);
    splits = await OrderApi()
        .splitList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  @override
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      await list(page, limit);
    });
    super.initState();
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
              children: [
                Column(
                  children: splits.rows!
                      .map(
                        (data) => SplitOrderCard(
                          data: data,
                          onClick: () {
                            Navigator.of(context).pushNamed(
                              ReceivedOrderDetail.routeName,
                              arguments: ReceivedOrderDetailArguments(
                                listenController: listenController,
                                id: data.id,
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
  }
}
