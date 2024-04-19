import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/src/order_module/components/back_order_card/back_order_card.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/order_module/screens/received_order_detail/received_order_detail.dart';
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
  ListenController listenController = ListenController();

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
    await list(page, limit);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text(
                    'Захиалгын жагсаалт',
                    style: TextStyle(
                      color: grey3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                orders.rows!.isNotEmpty
                    ? Column(
                        children: orders.rows!
                            .map(
                              (e) => BackorderCard(
                                data: e,
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                    ReceivedOrderDetail.routeName,
                                    arguments: ReceivedOrderDetailArguments(
                                      listenController: listenController,
                                      id: e.id,
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      )
                    : const NotFound(
                        module: "ORDER",
                        labelText: 'Хоосон байна',
                      ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
  }
}
