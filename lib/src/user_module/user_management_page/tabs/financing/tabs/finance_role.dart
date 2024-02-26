import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/user_module/user_management_page/tabs/financing/components/finance_role_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class FinanceRole extends StatefulWidget {
  const FinanceRole({super.key});

  @override
  State<FinanceRole> createState() => _FinanceRoleState();
}

class _FinanceRoleState extends State<FinanceRole> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result roles = Result(rows: [], count: 0);
  bool isLoading = true;

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    roles = await UserApi()
        .financeRoleList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
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
                roles.rows!.isNotEmpty
                    ? Column(
                        children: roles.rows!
                            .map(
                              (data) => FinanceRoleCard(
                                data: data,
                              ),
                            )
                            .toList(),
                      )
                    : const NotFound(
                        module: 'USER',
                        labelText: 'Хоосон байна',
                      ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          );
  }
}
