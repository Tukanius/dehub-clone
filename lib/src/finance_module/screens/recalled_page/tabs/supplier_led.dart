import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/payback_card/payback_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/screens/repayment_detail/repayment_detail.dart';
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
    Filter filter = Filter(productType: 'SUPPLIER_LED', isRecalled: true);
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
    await Future.delayed(const Duration(milliseconds: 1000));
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

    return Refresher(
      refreshController: refreshController,
      onLoading: finance.rows!.length == finance.count ? null : _onLoading,
      onRefresh: _onRefresh,
      color: source.currentColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            finance.rows!.isNotEmpty
                ? Column(
                    children: finance.rows!
                        .map(
                          (data) => RePaymentCard(
                            repayment: false,
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
                : const NotFound(
                    module: "FINANCE",
                    labelText: 'Хоосон байна',
                  ),
          ],
        ),
      ),
    );
  }
}
