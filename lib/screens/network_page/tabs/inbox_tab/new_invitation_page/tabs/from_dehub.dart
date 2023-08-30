import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/partner_cards/buyer_business_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/network_page/tabs/inbox_tab/new_invitation_page/invitation_sent_page/invitation_sent_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
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

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Buyer бизнесүүд',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
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
                                    invitationType: "DeHUB Network"),
                              );
                            },
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
          );
  }
}
