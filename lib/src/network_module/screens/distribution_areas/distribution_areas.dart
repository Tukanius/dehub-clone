import 'dart:async';
import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/distribution_area_card/distribution_area_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/network_module/screens/distribution_areas/distribution_area_detail/distribution_area_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class DistributionAreas extends StatefulWidget {
  static const routeName = '/DistributionAreas';
  const DistributionAreas({super.key});

  @override
  State<DistributionAreas> createState() => _DistributionAreasState();
}

class _DistributionAreasState extends State<DistributionAreas>
    with AfterLayoutMixin {
  bool startAnimation = false;
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Result network = Result(count: 0, rows: []);
  Timer? timer;
  User user = User();

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

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
    refreshController.loadComplete();
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit, '');
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).businessUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: networkColor,
        surfaceTintColor: networkColor,
        iconTheme: const IconThemeData(color: white),
        centerTitle: true,
        title: const Text(
          "Чиглэл бүсчлэл",
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
                    onLoading: _onLoading,
                    onRefresh: _onRefresh,
                    color: networkColor,
                    child: SingleChildScrollView(
                      child: network.rows!.isNotEmpty
                          ? Column(
                              children: network.rows!
                                  .map(
                                    (data) => Column(
                                      children: [
                                        DistributionAreaCard(
                                          onClick: user.currentBusiness?.type ==
                                                  "SUPPLIER"
                                              ? () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    DistributionAreaDetail
                                                        .routeName,
                                                    arguments:
                                                        DistributionAreaDetailArguments(
                                                      id: data.id,
                                                    ),
                                                  );
                                                }
                                              : () {},
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
