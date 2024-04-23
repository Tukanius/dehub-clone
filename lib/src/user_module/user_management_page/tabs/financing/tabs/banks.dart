import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/user_module/screens/finance_request/finance_request.dart';
import 'package:dehub/src/user_module/components/bank_card/bank_card.dart';
import 'package:dehub/utils/permission.dart';
import 'package:flutter/material.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class BanksTab extends StatefulWidget {
  const BanksTab({super.key});

  @override
  State<BanksTab> createState() => BanksTabState();
}

class BanksTabState extends State<BanksTab> with AfterLayoutMixin {
  Result banks = Result(rows: [], count: 0);
  bool isLoading = true;
  ListenController listenController = ListenController();
  User user = User();

  list() async {
    banks = await UserApi().bankList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await list();
  }

  @override
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      await list();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).userModule;
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
                                onClick: () {
                                  if (e.financeRole == null &&
                                      Permission().check(user, "USR_FR",
                                          boolean: 'isCreate')) {
                                    Navigator.of(context).pushNamed(
                                      FinanceRequest.routeName,
                                      arguments: FinanceRequestArguments(
                                        name: e.name,
                                        bank: e.code,
                                        listenController: listenController,
                                      ),
                                    );
                                  }
                                },
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
