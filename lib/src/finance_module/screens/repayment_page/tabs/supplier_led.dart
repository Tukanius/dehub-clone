import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/payback_card/payback_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/repayment_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class SupplierLed extends StatefulWidget {
  const SupplierLed({super.key});

  @override
  State<SupplierLed> createState() => _SupplierLedState();
}

class _SupplierLedState extends State<SupplierLed> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result finance = Result(count: 0, rows: []);
  bool isLoading = true;
  RefreshController refreshController = RefreshController();

  list(page, limit) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(productType: 'SUPPLIER_LED', isRecalled: false);
    finance = await FinanceApi().repaymentList(
        source.url, ResultArguments(offset: offset, filter: filter));
    setState(() {
      isLoading = false;
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
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: refreshController,
      header: WaterDropHeader(
        waterDropColor: source.currentColor,
        refresh: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: source.currentColor,
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
          children: [
            SizedBox(
              height: 15,
            ),
            finance.rows?.length != 0
                ? Column(
                    children: finance.rows!
                        .map(
                          (data) => RePaymentCard(
                            data: data,
                            onClick: () {
                              Navigator.of(context).pushNamed(
                                RePaymentDetail.routeName,
                                arguments: RePaymentDetailArguments(
                                  id: data.id,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  )
                : NotFound(
                    module: "FINANCE",
                    labelText: 'Хоосон байна',
                  ),
          ],
        ),
      ),
    );
  }
}
