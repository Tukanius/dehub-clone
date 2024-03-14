import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/invoice_module/screens/invoice_transaction/invoice_transaction.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../components/network_settlement_card/invoice_card.dart';
import 'package:after_layout/after_layout.dart';

class OpenTab extends StatefulWidget {
  final Invoice data;
  const OpenTab({
    super.key,
    required this.data,
  });

  @override
  State<OpenTab> createState() => _OpenTabState();
}

class _OpenTabState extends State<OpenTab> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result invoice = Result(count: 0, rows: []);
  bool isLoading = true;
  bool startAnimation = false;
  final RefreshController refreshController = RefreshController();

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(businessId: widget.data.id, type: "CONFIRMED");
    invoice = await InvoiceApi().networkSettlementInvoice(
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
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: invoiceColor,
            ),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading: invoice.rows!.length == invoice.count ? null : onLoading,
            color: invoiceColor,
            child: SingleChildScrollView(
              child: invoice.rows!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                          transform: Matrix4.translationValues(
                              !startAnimation
                                  ? -MediaQuery.of(context).size.width
                                  : 0,
                              0,
                              0),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'Төлбөрийн үлдэгдэлтэй',
                            style: TextStyle(
                                color: grey3, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Column(
                          children: invoice.rows!
                              .map(
                                (data) => InvoiceCard(
                                  data: data,
                                  index: invoice.rows!.indexOf(data),
                                  startAnimation: startAnimation,
                                  onClick: () {
                                    Navigator.of(context).pushNamed(
                                      InvoiceTransaction.routeName,
                                      arguments: InvoiceTransactionArguments(
                                        data: data,
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    )
                  : const NotFound(
                      module: "INVOICE",
                      labelText: "Хоосон байна",
                    ),
            ),
          );
  }
}
