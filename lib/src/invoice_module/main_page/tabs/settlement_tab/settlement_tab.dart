import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/invoice_module/main_page/tabs/settlement_tab/components/settlement_card.dart';
import 'package:dehub/src/invoice_module/screens/settlement_detail/settlement_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SettlementTab extends StatefulWidget {
  const SettlementTab({super.key});

  @override
  State<SettlementTab> createState() => _SettlementTabState();
}

class _SettlementTabState extends State<SettlementTab> with AfterLayoutMixin {
  String date = DateFormat('yyyy-MM').format(DateTime.now());
  int page = 1;
  int limit = 10;
  Result settlements = Result(rows: [], count: 0);
  bool isLoading = true;
  User user = User();
  RefreshController refreshController = RefreshController();

  list(page, limit, date) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(month: date);
    if (user.currentBusiness?.type == "SUPPLIER") {
      settlements = await InvoiceApi()
          .settlementSent(ResultArguments(filter: filter, offset: offset));
    } else {
      settlements = await InvoiceApi()
          .settlementReceived(ResultArguments(filter: filter, offset: offset));
    }
    setState(() {
      isLoading = false;
    });
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, date);
    refreshController.loadComplete();
  }

  onRefresh() async {
    setState(() {
      isLoading = true;
      limit = 10;
    });
    await list(page, limit, date);
    refreshController.refreshCompleted();
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, date);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).invoiceMe;
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: invoiceColor,
            ),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading: onLoading,
            onRefresh: onRefresh,
            color: invoiceColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      monthPick();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          const Text(
                            'Тооцоо нийлэх сар:   ',
                            style: TextStyle(
                              color: grey2,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: Text(date),
                          ),
                        ],
                      ),
                    ),
                  ),
                  settlements.rows!.isNotEmpty
                      ? Column(
                          children: settlements.rows!
                              .map(
                                (e) => SettlementCard(
                                  data: e,
                                  onClick: () {
                                    Navigator.of(context).pushNamed(
                                      SettlementDetail.routeName,
                                      arguments: SettlementDetailArguments(
                                        id: e.id,
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        )
                      : const NotFound(
                          module: 'INVOICE',
                          labelText: 'Хоосон байна',
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
  }

  monthPick() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        DateTime? selectedDate;
        return Container(
          color: white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  try {
                    setState(() {
                      date = DateFormat('yyyy-MM').format(selectedDate!);
                      limit = 10;
                      isLoading = true;
                    });
                    await list(page, limit, date);
                    Navigator.of(context).pop();
                  } catch (e) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Болсон',
                  style: TextStyle(
                    fontSize: 12,
                    color: black,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.parse("$date-01"),
                  mode: CupertinoDatePickerMode.monthYear,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      selectedDate = newDate;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
