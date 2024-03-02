import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/src/user_module/screens/role_assign/role_assign.dart';
import 'package:dehub/src/user_module/screens/update_user/components/role_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RoleSetting extends StatefulWidget {
  final User? data;
  const RoleSetting({
    super.key,
    this.data,
  });

  @override
  State<RoleSetting> createState() => _RoleSettingState();
}

class _RoleSettingState extends State<RoleSetting> with AfterLayoutMixin {
  final RefreshController refreshController = RefreshController();
  Result roles = Result(rows: [], count: 0);
  General general = General();
  bool isLoading = true;
  int limit = 10;
  int page = 1;

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(userId: widget.data!.id);
    roles = await UserApi()
        .roleList(ResultArguments(offset: offset, filter: filter));
    setState(() {
      isLoading = false;
    });
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      limit = 10;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
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
    list(page, limit);
  }

  usageType() {
    final res = general.systemUsageTypes!
        .firstWhere((element) => element.code == widget.data?.usageType);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: userColor,
        child: const Icon(
          Icons.add,
          color: white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(
            RoleAssign.routeName,
            arguments: RoleAssignArguments(id: widget.data!.id!),
          );
        },
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: userColor,
              ),
            )
          : Refresher(
              refreshController: refreshController,
              onLoading: onLoading,
              onRefresh: onRefresh,
              color: userColor,
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
                            'Системийн эрх: ',
                            style: TextStyle(
                              color: grey3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: userColor,
                            ),
                            child: Text(
                              '${usageType().name}',
                              style: const TextStyle(
                                color: white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    roles.rows!.isNotEmpty
                        ? Column(
                            children: roles.rows!
                                .map(
                                  (data) => RoleCard(
                                    data: data,
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        RoleAssign.routeName,
                                        arguments: RoleAssignArguments(
                                          id: widget.data!.id!,
                                          data: data,
                                        ),
                                      );
                                    },
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
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}