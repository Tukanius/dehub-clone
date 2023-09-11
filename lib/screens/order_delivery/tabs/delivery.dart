import 'package:dehub/components/delivery_card/delivery_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/screens/order_delivery/delivery_detail/delivery_detail.dart';
import 'package:dehub/screens/order_delivery/delivery/delivery.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/models/result.dart';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result delivery = Result(count: 0, rows: []);
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(businessId: '');
    delivery = await OrderApi().deliveryNoteList(
      ResultArguments(filter: filter, offset: offset),
    );
    setState(() {
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
                Column(
                  children: delivery.rows!
                      .map((item) => DeliveryCard(
                            onClick: () {
                              Navigator.of(context).pushNamed(
                                DeliveryDetail.routeName,
                                arguments: DeliveryDetailArguments(data: item),
                              );
                            },
                            refCodeClick: () {
                              Navigator.of(context).pushNamed(
                                DeliveryPage.routeName,
                                arguments: DeliveryPageArguments(
                                  data: item,
                                ),
                              );
                            },
                            startClick: () async {
                              try {
                                setState(() {
                                  isLoading = true;
                                });
                                await OrderApi().deliveryNoteStart(item.id);
                                list(page, limit);
                                setState(() {
                                  isLoading = false;
                                });
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            data: item,
                            isDeliveried: false,
                          ))
                      .toList(),
                )
              ],
            ),
          );
  }
}
