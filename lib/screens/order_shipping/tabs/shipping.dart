import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/shipping_card/shipping_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/order_shipment/order_shipment.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class Shipping extends StatefulWidget {
  const Shipping({super.key});

  @override
  State<Shipping> createState() => _DeliveryState();
}

class _DeliveryState extends State<Shipping> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result pullSheet = Result(count: 0, rows: []);
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(pullSheetStatus: '');
    var res = await OrderApi()
        .pullSheet(ResultArguments(filter: filter, offset: offset));
    setState(() {
      pullSheet = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: orderColor,
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                SearchButton(
                  color: orderColor,
                  textColor: orderColor,
                ),
                SizedBox(
                  height: 5,
                ),
                pullSheet.rows?.length != 0
                    ? Column(
                        children: pullSheet.rows!
                            .map(
                              (data) => ShippingCard(
                                data: data,
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                    OrderShipment.routeName,
                                    arguments:
                                        OrderShipmentArguments(data: data),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      )
                    : NotFound(
                        module: "ORDER",
                        labelText: "Хоосон байна",
                      )
              ],
            ),
          );
  }
}
