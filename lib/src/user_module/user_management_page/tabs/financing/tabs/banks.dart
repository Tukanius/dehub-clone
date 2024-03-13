import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/src/user_module/screens/finance_request/finance_request.dart';
import 'package:dehub/src/user_module/components/bank_card/bank_card.dart';
import 'package:flutter/material.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';

class BanksTab extends StatefulWidget {
  const BanksTab({super.key});

  @override
  State<BanksTab> createState() => BanksTabState();
}

class BanksTabState extends State<BanksTab> with AfterLayoutMixin {
  Result banks = Result(rows: [], count: 0);
  bool isLoading = true;

  list() async {
    banks = await UserApi().bankList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: userColor,
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                banks.rows!.isNotEmpty
                    ? Column(
                        children: banks.rows!
                            .map(
                              (e) => BankCard(
                                data: e,
                                onClick: e.financeRole == null
                                    ? () {
                                        Navigator.of(context).pushNamed(
                                          FinanceRequest.routeName,
                                          arguments: FinanceRequestArguments(
                                            name: e.name,
                                            bank: e.code,
                                          ),
                                        );
                                      }
                                    : () {},
                              ),
                            )
                            .toList(),
                      )
                    : const NotFound(
                        module: "USER",
                        labelText: 'Хоосон байна',
                      ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
  }
}
