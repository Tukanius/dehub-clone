import 'package:dehub/api/finance_api.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';

class SettlementTab extends StatefulWidget {
  const SettlementTab({super.key});

  @override
  State<SettlementTab> createState() => _SettlementTabState();
}

class _SettlementTabState extends State<SettlementTab> with AfterLayoutMixin {
  String date = DateTime.now().toString();
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result settlements = Result(rows: [], count: 0);

  list(page, limit, date) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(month: date);
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: grey2.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      DateFormat('yyyy-MM').format(DateTime.parse(date)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Тооцоо үлдэгдэл',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(color: source.currentColor),
                )
              : Column(
                  children: settlements.rows!
                      .map(
                        (e) => Container(),
                      )
                      .toList(),
                )
        ],
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
                  setState(() {
                    date = selectedDate.toString();
                    limit = 10;
                    isLoading = true;
                  });
                  await list(page, limit, date);
                  Navigator.of(context).pop();
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
                  initialDateTime: DateTime.now(),
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
