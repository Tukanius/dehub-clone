import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/user_module/screens/finance_role_assign/finance_role_assign.dart';
import 'package:dehub/src/user_module/components/finance_role_card/finance_role_card.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  ListenController listenController = ListenController();
  User user = User();

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
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      await list(page, limit);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).userModule;

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Permission().check(user, "USR_FR_STF")
          ? FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: userColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  FinanceRoleAssign.routeName,
                  arguments: FinanceRoleAssignArguments(
                      listenController: listenController),
                );
              },
              child: const Icon(
                Icons.add,
                color: white,
              ),
            )
          : null,
      body: isLoading == true
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
            ),
    );
  }
}
