import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/invoice_module/screens/settlement_detail/components/settlement_invoice_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SettlementDetailArguments {
  String id;
  SettlementDetailArguments({
    required this.id,
  });
}

class SettlementDetail extends StatefulWidget {
  static const routeName = '/SettlementDetail';
  final String id;
  const SettlementDetail({
    super.key,
    required this.id,
  });

  @override
  State<SettlementDetail> createState() => _SettlementDetailState();
}

class _SettlementDetailState extends State<SettlementDetail>
    with AfterLayoutMixin {
  Invoice settlement = Invoice();
  int page = 1;
  int limit = 10;
  Result invoices = Result(rows: [], count: 0);
  bool isLoading = true;
  final RefreshController refreshController = RefreshController();
  User user = User();

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      if (user.currentBusiness?.type == "SUPPLIER") {
        await InvoiceApi().settlementSend(widget.id);
      } else {
        await InvoiceApi().settlementRespond(widget.id);
      }
      loading.loading(false);
      showCustomDialog(context, "Амжилттай", true, onPressed: () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      loading.loading(false);
    }
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(settlementId: widget.id);
    invoices = await InvoiceApi()
        .settlementInvoice(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    settlement = await InvoiceApi().settlementDetail(widget.id);
    await list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).invoiceMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: invoiceColor),
        title: const Text(
          'Тооцооны хуудас',
          style: TextStyle(
            color: invoiceColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: invoiceColor,
              ),
            )
          : Column(
              children: [
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 4,
                        child: Text('Партнер'),
                      ),
                      Expanded(
                        flex: 6,
                        child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              color: black,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${settlement.business?.partner?.refCode}, ',
                                style: const TextStyle(color: invoiceColor),
                              ),
                              TextSpan(
                                  text:
                                      ' ${settlement.business?.partner?.businessName}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 4,
                        child: Text('Бизнес'),
                      ),
                      Expanded(
                        flex: 6,
                        child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              color: black,
                            ),
                            children: [
                              TextSpan(
                                text: '${settlement.business?.refCode}, ',
                                style: const TextStyle(color: invoiceColor),
                              ),
                              TextSpan(
                                  text: ' ${settlement.business?.profileName}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 6,
                        child: Text('Төлбөрийн үлдэгдэлтэй'),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          '${settlement.numberOfInv}',
                          style: const TextStyle(
                            color: invoiceColor,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Илгээсэн',
                  secondText:
                      '${settlement.financeStaff?.lastName?[0]}. ${settlement.financeStaff?.firstName}',
                  secondTextColor: invoiceColor,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onSubmit,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: invoiceColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Text(
                        user.currentBusiness?.type == "SUPPLIER"
                            ? 'Тооцоо илгээх'
                            : 'Зөвшөөрөх',
                        style: const TextStyle(
                            color: white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Refresher(
                    color: invoiceColor,
                    onLoading: onLoading,
                    refreshController: refreshController,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: invoices.rows!
                                .map(
                                  (data) => SettlementInvoiceCard(
                                    data: data,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
