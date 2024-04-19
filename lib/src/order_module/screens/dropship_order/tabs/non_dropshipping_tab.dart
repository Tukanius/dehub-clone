import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/src/order_module/components/dropshipping_card/dropshipping_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/order_module/screens/received_order_detail/received_order_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class NonDropshippingTab extends StatefulWidget {
  const NonDropshippingTab({super.key});

  @override
  State<NonDropshippingTab> createState() => _NonDropshippingTabState();
}

class _NonDropshippingTabState extends State<NonDropshippingTab>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result orders = Result(rows: [], count: 0);
  bool isLoading = true;
  ListenController listenController = ListenController();
  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(isDropshipping: false, excel: false);
    orders = await OrderApi()
        .dropshipList(ResultArguments(filter: filter, offset: offset));
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
              children: [
                orders.rows!.isNotEmpty
                    ? Column(
                        children: orders.rows!
                            .map(
                              (data) => DropshippingCard(
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
