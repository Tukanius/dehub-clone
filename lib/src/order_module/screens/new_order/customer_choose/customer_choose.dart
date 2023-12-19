import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/order_customer_card/order_customer_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  bool startAnimation = false;
  RefreshController refreshController = RefreshController();

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
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
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
          : Column(
              children: [
                SearchButton(
                  color: orderColor,
                  textColor: orderColor,
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
                      child: Column(
                        children: customer.rows!
                            .map(
                              (item) => OrderCustomerCard(
                                index: customer.rows!.indexOf(item),
                                startAnimation: startAnimation,
                                onClick: () {
                                  widget.customerListenController
                                      .customerOrderChange(item);
                                  Navigator.of(context).pop();
                                },
                                data: item,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
