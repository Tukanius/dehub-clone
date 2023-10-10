import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/partner_cards/sent_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/network_page/tabs/sent_tab/tabs/invitation_detail_page/invitation_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DehubNetwork extends StatefulWidget {
  const DehubNetwork({Key? key}) : super(key: key);

  @override
  _DehubNetworkState createState() => _DehubNetworkState();
}

class _DehubNetworkState extends State<DehubNetwork> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result invitation = Result(rows: [], count: 0);
  bool isLoading = true;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(type: "NETWORK");
    var res = await BusinessApi().listSent(
      ResultArguments(offset: offset, filter: filter),
    );
    setState(() {
      invitation = res;
      isLoading = false;
    });
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
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
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
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    invitation.rows?.length != 0
                        ? Column(
                            children: invitation.rows!
                                .map(
                                  (item) => SentCard(
                                    data: item,
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        SentInvitationDetail.routeName,
                                        arguments:
                                            SentInvitationDetailArguments(
                                                id: item.id),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        : NotFound(
                            module: 'NETWORK',
                            labelText: "Урилга олдсонгүй",
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
