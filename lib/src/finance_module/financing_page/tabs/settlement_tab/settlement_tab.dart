import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/src/finance_module/components/settlement_card/settlement_card.dart';
import 'package:dehub/src/finance_module/screens/settlement_respond/settlement_respond.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SettlementTab extends StatefulWidget {
  const SettlementTab({super.key});

  @override
  State<SettlementTab> createState() => _SettlementTabState();
}

class _SettlementTabState extends State<SettlementTab> with AfterLayoutMixin {
  String? date;
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result settlements = Result(rows: [], count: 0);
  final RefreshController refreshController = RefreshController();

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, date);
    refreshController.refreshCompleted();
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      limit = 10;
    });
    await list(page, limit, date);
    refreshController.refreshCompleted();
  }

  list(page, limit, date) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(month: date ?? '');
    settlements = await FinanceApi().settlementList(
        source.url, ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit, date);
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(color: source.currentColor),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading: settlements.rows!.length == settlements.count
                ? null
                : onLoading,
            onRefresh: onRefresh,
            color: source.currentColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        const Text(
                          "Сар сонгох: ",
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            monthPick();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 15),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 34,
                            decoration: BoxDecoration(
                              color: transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: grey2.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(date ?? "Сар сонгох"),
                            ),
                          ),
                        ),
                        if (date != null)
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                date = null;
                                isLoading = true;
                              });
                              await list(page, limit, date);
                            },
                            child: Container(
                              height: 34,
                              width: 34,
                              margin: const EdgeInsets.only(left: 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: grey2.withOpacity(0.5),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/svg/remove.svg',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Тооцоо үлдэгдэл',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  settlements.rows!.isNotEmpty
                      ? Column(
                          children: settlements.rows!
                              .map(
                                (data) => SettlementCard(
                                  onClick: () {
                                    Navigator.of(context).pushNamed(
                                      SettlementRespond.routeName,
                                      arguments: SettlementRespondArguments(
                                        data: data,
                                      ),
                                    );
                                  },
                                  data: data,
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
                  initialDateTime: DateTime.parse(date != null
                      ? "$date-01"
                      : DateFormat('yyyy-MM-dd').format(DateTime.now())),
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
