import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/partner_cards/inbox_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dehub/src/network_module/network_page/tabs/inbox_tab/tabs/invitation_detail_page/invitation_detail_page.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FromBuyer extends StatefulWidget {
  const FromBuyer({Key? key}) : super(key: key);

  @override
  _FromBuyerState createState() => _FromBuyerState();
}

class _FromBuyerState extends State<FromBuyer> with AfterLayoutMixin {
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
    await Future.delayed(Duration(milliseconds: 1000));
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
        ? Center(
            child: CircularProgressIndicator(
              color: networkColor,
            ),
          )
        : SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            header: WaterDropHeader(
              waterDropColor: networkColor,
              refresh: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: networkColor,
                ),
              ),
            ),
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            footer: CustomFooter(
              builder: (context, mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("");
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Алдаа гарлаа. Дахин үзнэ үү!");
                } else {
                  body = const Text("Мэдээлэл алга байна");
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            child: SingleChildScrollView(
              child: invitation.rows?.length != 0
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
                  : NotFound(
                      module: "NETWORK",
                      labelText: 'Хоосон байна',
                    ),
            ),
          );
  }
}
