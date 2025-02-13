import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/src/network_module/components/partner_cards/buyer_business_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/network_module/screens/new_invitation_page/invitation_sent_page/invitation_sent_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FromDehubTab extends StatefulWidget {
  const FromDehubTab({super.key});

  @override
  State<FromDehubTab> createState() => _FromDehubTabState();
}

class _FromDehubTabState extends State<FromDehubTab> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result business = Result(rows: [], count: 0);
  bool isLoading = true;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ListenController listenController = ListenController();

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  @override
  void initState() {
    listenController.addListener(() {
      list(page, limit);
    });
    super.initState();
  }

  void onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    var res = await BusinessApi()
        .businessList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      business = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: networkColor,
            ),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading:
                business.rows!.length == business.count ? null : onLoading,
            onRefresh: onRefresh,
            color: networkColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Buyer бизнесүүд',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  business.rows!.isNotEmpty
                      ? Column(
                          children: business.rows!
                              .map(
                                (item) => BuyerBusinessCard(
                                  data: item,
                                  onClick: () {
                                    Navigator.of(context).pushNamed(
                                      InvitationSentPage.routeName,
                                      arguments: InvitationSentPageArguments(
                                        listenController: listenController,
                                        data: item,
                                        invitationType: "DeHUB Network",
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        )
                      : const NotFound(
                          module: "NETWORK",
                          labelText: "Хоосон байна",
                        ),
                ],
              ),
            ),
          );
  }
}
