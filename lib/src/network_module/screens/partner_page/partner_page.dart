import 'dart:async';
import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/src/network_module/components/partner_cards/partner_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/network_module/screens/partner_page/partner_detail_page/partner_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NetworkPartnerPage extends StatefulWidget {
  static const routeName = '/NetworkPartnerPage';
  const NetworkPartnerPage({super.key});

  @override
  State<NetworkPartnerPage> createState() => _NetworkPartnerPageState();
}

class _NetworkPartnerPageState extends State<NetworkPartnerPage>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Result businessNetwork = Result(count: 0, rows: []);
  bool isLoading = true;
  bool startAnimation = false;
  String query = '';
  Timer? timer;

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit, '');
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, query);
    refreshController.loadComplete();
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      limit = 10;
      isLoading = true;
    });
    await list(page, limit, query);
    refreshController.refreshCompleted();
  }

  list(page, limit, query) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: query);
    Result res = await BusinessApi().networkList(
      ResultArguments(offset: offset, filter: filter),
    );
    setState(() {
      businessNetwork = res;
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  onChange(String text) async {
    if (timer != null) timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        startAnimation = false;
      });
      await list(page, limit, text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          surfaceTintColor: backgroundColor,
          leadingWidth: 100,
          leading: const CustomBackButton(color: networkColor),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 5),
                      child: const Text(
                        'Харилцагч',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SearchButton(
                      color: networkColor,
                      onChange: (query) {
                        onChange(query);
                      },
                    ),
                  ],
                ),
              ),
            ];
          },
          body: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: networkColor,
                  ),
                )
              : Refresher(
                  refreshController: refreshController,
                  onLoading:
                      businessNetwork.rows!.length == businessNetwork.count
                          ? null
                          : onLoading,
                  onRefresh: onRefresh,
                  color: networkColor,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          businessNetwork.rows!.isNotEmpty
                              ? Column(
                                  children: businessNetwork.rows!
                                      .map(
                                        (e) => PartnerCard(
                                          index:
                                              businessNetwork.rows!.indexOf(e),
                                          startAnimation: startAnimation,
                                          data: e,
                                          onClick: () {
                                            Navigator.of(context).pushNamed(
                                              PartnerDetailPage.routeName,
                                              arguments:
                                                  PartnerDetailPageArguments(
                                                id: e.id,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                      .toList(),
                                )
                              : const NotFound(
                                  module: 'NETWORK',
                                  labelText: "Харилцагч олдсонгүй",
                                )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
