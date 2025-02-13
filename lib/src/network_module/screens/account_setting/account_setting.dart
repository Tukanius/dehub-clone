import 'dart:async';
import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/src/network_module/components/account_setting_card/account_setting_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/network_module/screens/account_setting/account_setting_detail/account_setting_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountSetting extends StatefulWidget {
  static const routeName = '/AccountSetting';
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> with AfterLayoutMixin {
  bool startAnimation = false;
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result network = Result(count: 0, rows: []);
  RefreshController refreshController = RefreshController();
  Timer? timer;
  ListenController listenController = ListenController();

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
  }

  list(page, limit, String query) async {
    Filter filter = Filter(query: query);
    Offset offset = Offset(page: page, limit: limit);
    var res = await BusinessApi()
        .networkList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      network = res;
      isLoading = false;
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  onChange(String query) async {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 400), () {
      setState(() {
        isLoading = true;
      });
      list(page, limit, query);
    });
  }

  void onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
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
    await list(page, limit, '');
    refreshController.refreshCompleted();
    isLoading = false;
  }

  @override
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      await list(page, limit, '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: networkColor,
        surfaceTintColor: networkColor,
        iconTheme: const IconThemeData(color: white),
        centerTitle: true,
        title: const Text(
          "Данс тохиргоо",
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          SearchButton(
            textColor: networkColor,
            color: networkColor,
            onChange: (query) {
              onChange(query);
            },
          ),
          isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(color: networkColor),
                )
              : Expanded(
                  child: Refresher(
                    refreshController: refreshController,
                    onLoading: network.rows!.length == network.count
                        ? null
                        : onLoading,
                    onRefresh: onRefresh,
                    color: networkColor,
                    child: SingleChildScrollView(
                      child: network.rows!.isNotEmpty
                          ? Column(
                              children: network.rows!
                                  .map(
                                    (data) => Column(
                                      children: [
                                        AccountSettingCard(
                                          onClick: () {
                                            Navigator.of(context).pushNamed(
                                              AccountSettingDetail.routeName,
                                              arguments:
                                                  AccountSettingDetailArguments(
                                                id: data.id,
                                                listenController:
                                                    listenController,
                                              ),
                                            );
                                          },
                                          index: network.rows!.indexOf(data),
                                          startAnimation: startAnimation,
                                          data: data,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
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
                ),
        ],
      ),
    );
  }
}
