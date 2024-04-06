import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/src/order_module/components/delivery_management_card/delivery_management_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/order_module/screens/set_delivery_distribution/set_delivery_distribution.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DistributionTab extends StatefulWidget {
  const DistributionTab({super.key});

  @override
  State<DistributionTab> createState() => _DistributionTabState();
}

class _DistributionTabState extends State<DistributionTab>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  RefreshController refreshController = RefreshController();
  Result order = Result(count: 0, rows: []);
  bool isLoading = true;
  bool startAnimation = false;
  ListenController listenController = ListenController();

  void onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  list(page, limit) async {
    Filter filter = Filter(deliveryNoteStatus: "DRAFT");
    Offset offset = Offset(page: page, limit: limit);
    order = await OrderApi().deliveryManagementList(
        ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
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
        : Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const SearchButton(
                color: orderColor,
                borderColor: grey,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Refresher(
                  refreshController: refreshController,
                  onLoading:
                      order.rows!.length == order.count ? null : onLoading,
                  onRefresh: onRefresh,
                  color: orderColor,
                  child: SingleChildScrollView(
                    child: order.rows!.isNotEmpty
                        ? Column(
                            children: order.rows!
                                .map(
                                  (data) => Column(
                                    children: [
                                      DeliveryManagementCard(
                                        startAnimation: startAnimation,
                                        index: order.rows!.indexOf(data),
                                        data: data,
                                        isFinished: false,
                                        onClick: () {
                                          Navigator.of(context).pushNamed(
                                            SetDeliveryDistribution.routeName,
                                            arguments:
                                                SetDeliveryDistributionArguments(
                                              data: data,
                                              listenController:
                                                  listenController,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
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
