import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/src/network_module/components/client_classification_card/client_classification_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/network_module/screens/client_classifications/client_classification_detail/client_classification_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ClientClassifications extends StatefulWidget {
  static const routeName = '/ClientClassifications';
  const ClientClassifications({super.key});

  @override
  State<ClientClassifications> createState() => _ClientClassificationsState();
}

class _ClientClassificationsState extends State<ClientClassifications>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result business = Result(count: 0, rows: []);
  bool isLoading = true;
  RefreshController refreshController = RefreshController();
  bool startAnimation = false;
  User user = User();
  ListenController listenController = ListenController();

  list(page, limit, String value) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: value);
    var res = await BusinessApi()
        .networkList(ResultArguments(offset: offset, filter: filter));
    setState(() {
      business = res;
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
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
    user = Provider.of<UserProvider>(context, listen: true).businessUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: networkColor,
        surfaceTintColor: networkColor,
        iconTheme: const IconThemeData(color: white),
        title: const Text(
          'Ангилал, зэрэглэл',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: networkColor,
              ),
            )
          : Column(
              children: [
                const SearchButton(
                  color: networkColor,
                ),
                Expanded(
                  child: Refresher(
                    refreshController: refreshController,
                    onLoading: business.rows!.length == business.count
                        ? null
                        : onLoading,
                    onRefresh: onRefresh,
                    color: networkColor,
                    child: SingleChildScrollView(
                      child: business.rows!.isNotEmpty
                          ? Column(
                              children: business.rows!
                                  .map(
                                    (data) => ClientClassificationCard(
                                      onClick: user.currentBusiness?.type ==
                                              "SUPPLIER"
                                          ? () {
                                              Navigator.of(context).pushNamed(
                                                ClientClassificationDetail
                                                    .routeName,
                                                arguments:
                                                    ClientClassificationDetailArguments(
                                                  id: data.id,
                                                  listenController:
                                                      listenController,
                                                ),
                                              );
                                            }
                                          : () {},
                                      data: data,
                                      index: business.rows!.indexOf(data),
                                      startAnimation: startAnimation,
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
