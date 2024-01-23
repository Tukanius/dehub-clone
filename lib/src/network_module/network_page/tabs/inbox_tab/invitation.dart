import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/partner_cards/inbox_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/src/network_module/network_page/tabs/inbox_tab/invitation_detail_page/invitation_detail_page.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Invitation extends StatefulWidget {
  const Invitation({super.key});

  @override
  InvitationState createState() => InvitationState();
}

class InvitationState extends State<Invitation> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result invitation = Result(rows: [], count: 0);
  bool isLoading = true;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ListenController listenController = ListenController();
  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
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
  }

  @override
  void initState() {
    listenController.addListener(() async {
      await list(page, limit);
    });
    super.initState();
  }

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: networkColor,
            ),
          )
        : Expanded(
            child: Refresher(
              refreshController: refreshController,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
              color: networkColor,
              child: SingleChildScrollView(
                child: invitation.rows!.isNotEmpty
                    ? Column(
                        children: invitation.rows!
                            .map(
                              (item) => InboxCard(
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                    InvitationDetailPage.routeName,
                                    arguments: InvitationDetailPageArguments(
                                      listenController: listenController,
                                      id: item.id,
                                    ),
                                  );
                                },
                                data: item,
                              ),
                            )
                            .toList(),
                      )
                    : const NotFound(
                        module: "NETWORK",
                        labelText: 'Хоосон байна',
                      ),
              ),
            ),
          );
  }
}
