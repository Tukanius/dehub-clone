import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/delivery_management_card/delivery_management_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/order_module/screens/set_delivery_distribution/set_delivery_distribution.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
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

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
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
    order = await OrderApi()
        .deliveryNoteList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: orderColor,
            ),
          )
        : Column(
            children: [
              SizedBox(
                height: 5,
              ),
              SearchButton(
                color: orderColor,
                borderColor: grey,
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: refreshController,
                  header: WaterDropHeader(
                    waterDropColor: orderColor,
                    refresh: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: orderColor,
                      ),
                    ),
                  ),
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  footer: CustomFooter(
                    builder: (context, mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const Text("");
                      } else if (mode == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = const Text("Алдаа гарлаа. Дахин үзнэ үү!");
                      } else {
                        body = const Text("Мэдээлэл алга байна");
                      }
                      return SizedBox(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  child: SingleChildScrollView(
                    child: order.rows?.length != 0
                        ? Column(
                            children: order.rows!
                                .map(
                                  (e) => Column(
                                    children: [
                                      DeliveryManagementCard(
                                        isFinished: false,
                                        onClick: () {
                                          Navigator.of(context).pushNamed(
                                            SetDeliveryDistribution.routeName,
                                            arguments:
                                                SetDeliveryDistributionArguments(
                                                    id: ''),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          )
                        : NotFound(
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
