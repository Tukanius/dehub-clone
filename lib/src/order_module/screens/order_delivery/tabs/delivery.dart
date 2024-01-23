import 'package:dehub/components/delivery_card/delivery_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/delivery_detail/delivery_detail.dart';
import 'package:dehub/src/order_module/screens/order_delivery/delivery/delivery.dart';
import 'package:dehub/src/order_module/screens/product_give/product_give.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/models/result.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

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
  Order endResponse = Order();
  User user = User();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool startAnimation = false;

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
  }

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit, '');
    setState(() {
      startAnimation = false;
    });
    refreshController.refreshCompleted();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
    isLoading = false;
  }

  list(page, limit, query) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(businessId: '');
    delivery = await OrderApi().deliveryNoteList(
      ResultArguments(filter: filter, offset: offset),
    );
    setState(() {
      isLoading = false;
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: orderColor,
            ),
          )
        : Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const SearchButton(
                color: orderColor,
                textColor: orderColor,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Refresher(
                  refreshController: refreshController,
                  onLoading: _onLoading,
                  onRefresh: _onRefresh,
                  color: orderColor,
                  child: SingleChildScrollView(
                    child: delivery.rows!.isNotEmpty
                        ? Column(
                            children: delivery.rows!
                                .map(
                                  (item) => DeliveryCard(
                                    startAnimation: startAnimation,
                                    index: delivery.rows!.indexOf(item),
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        DeliveryPage.routeName,
                                        arguments: DeliveryPageArguments(
                                          data: item,
                                        ),
                                      );
                                    },
                                    refCodeClick: () {
                                      if (user.currentBusiness?.type ==
                                          "SUPPLIER") {
                                        Navigator.of(context).pushNamed(
                                          DeliveryDetail.routeName,
                                          arguments: DeliveryDetailArguments(
                                              data: item),
                                        );
                                      }
                                    },
                                    startClick: () async {
                                      try {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (item.deliveryNoteStatus ==
                                            "DELIVERING") {
                                          Navigator.of(context).pushNamed(
                                            ProductGive.routeName,
                                            arguments: ProductGiveArguments(
                                              data: item,
                                            ),
                                          );
                                        } else {
                                          await OrderApi()
                                              .deliveryNoteStart(item.id);
                                          await list(page, limit, '');
                                        }
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
                                  ),
                                )
                                .toList(),
                          )
                        : const NotFound(
                            module: "ORDER",
                            labelText: "Хоосон байна",
                          ),
                  ),
                ),
              ),
            ],
          );
  }
}
