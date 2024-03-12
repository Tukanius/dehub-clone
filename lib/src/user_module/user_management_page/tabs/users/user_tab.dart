import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/user_module/screens/create_user/create_user.dart';
import 'package:dehub/src/user_module/screens/invitation_send/invitation_send.dart';
import 'package:dehub/src/user_module/screens/update_user/update_user_page.dart';
import 'package:dehub/src/user_module/user_management_page/tabs/users/components/user_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> with AfterLayoutMixin {
  late RefreshController refreshController = RefreshController();
  bool isLoading = true;
  Result users = Result(rows: [], count: 0);
  ListenController listenController = ListenController();
  int page = 1;
  int limit = 10;

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    users = await UserApi()
        .usersList(ResultArguments(filter: filter, offset: offset));
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
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: userColor,
            ),
          )
        : Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: backgroundColor,
              surfaceTintColor: backgroundColor,
              leadingWidth: 130,
              leading: const CustomBackButton(color: userColor),
              actions: [
                AddButton(
                  color: userColor,
                  addColor: white,
                  onClick: () {
                    Navigator.of(context).pushNamed(
                      CreateUser.routeName,
                      arguments: CreateUserArguments(
                        listenController: listenController,
                        data: null,
                      ),
                    );
                  },
                ),
              ],
            ),
            body: Refresher(
              refreshController: refreshController,
              onLoading: users.rows!.length == users.count ? null : onLoading,
              onRefresh: onRefresh,
              color: userColor,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        'Системийн хэрэглэгч',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    users.rows!.isNotEmpty
                        ? Column(
                            children: [
                              Column(
                                children: users.rows!
                                    .map(
                                      (data) => UserCard(
                                        onPress: () {
                                          Navigator.of(context).pushNamed(
                                            UserInvitationSend.routeName,
                                            arguments:
                                                UserInvitationSendArguments(
                                              data: data,
                                            ),
                                          );
                                        },
                                        data: data,
                                        onClick: () {
                                          Navigator.of(context).pushNamed(
                                            UpdateUserPage.routeName,
                                            arguments: UpdateUserPageArguments(
                                              listenController:
                                                  listenController,
                                              data: data,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          )
                        : const NotFound(
                            module: "USER",
                            labelText: 'Хоосон байна',
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
