import 'package:after_layout/after_layout.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/permission.dart';
import 'package:flutter/material.dart';
import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/result.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/src/network_module/components/partner_cards/invitation_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/src/network_module/screens/invitation_detail_page/invitation_detail_page.dart';

class InboxTab extends StatefulWidget {
  const InboxTab({super.key});

  @override
  InboxTabState createState() => InboxTabState();
}

class InboxTabState extends State<InboxTab>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result invitation = Result(rows: [], count: 0);
  bool isLoading = true;
  final RefreshController refreshController = RefreshController();
  ListenController listenController = ListenController();
  bool startAnimation = false;
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    if (Permission().check(user, "NET_INV_REC")) {
      await list(page, limit);
    }
  }

  list(page, limit) async {
    Filter filter = Filter(query: '');
    Offset offset = Offset(page: page, limit: limit);
    var res = await BusinessApi()
        .list(ResultArguments(filter: filter, offset: offset));
    setState(() {
      invitation = res;
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  void onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  @override
  void initState() {
    listenController.addListener(() async {
      await list(page, limit);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).businessUser;
    return Permission().check(user, "NET_INV_REC")
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: const Text(
                  'Ирсэн урилга',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: networkColor,
                      ),
                    )
                  : Expanded(
                      child: Refresher(
                        refreshController: refreshController,
                        onLoading: invitation.rows!.length == invitation.count
                            ? null
                            : onLoading,
                        onRefresh: onRefresh,
                        color: networkColor,
                        child: SingleChildScrollView(
                          child: invitation.rows!.isNotEmpty
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: invitation.rows!
                                        .map(
                                          (item) => InvitationCard(
                                            send: false,
                                            index:
                                                invitation.rows!.indexOf(item),
                                            startAnimation: startAnimation,
                                            data: item,
                                            onClick: () {
                                              Navigator.of(context).pushNamed(
                                                InvitationDetailPage.routeName,
                                                arguments:
                                                    InvitationDetailPageArguments(
                                                  listenController:
                                                      listenController,
                                                  id: item.id,
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              : const NotFound(
                                  module: "NETWORK",
                                  labelText: 'Хоосон байна',
                                ),
                        ),
                      ),
                    ),
            ],
          )
        : const NotFound(
            module: "NETWORK",
            labelText: 'Хандах эрх хүрэхгүй байна',
          );
  }
}
