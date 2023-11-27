import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/client_classification_card/client_classification_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/network_module/screens/client_classifications/client_classification_detail/client_classification_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClientClassifications extends StatefulWidget {
  static const routeName = '/ClientClassifications';
  const ClientClassifications({Key? key}) : super(key: key);

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

  list(page, limit, String value) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '${value}');
    var res = await BusinessApi()
        .networkList(ResultArguments(offset: offset, filter: filter));
    setState(() {
      business = res;
      isLoading = false;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
  }

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
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
    await list(page, limit, '');
    refreshController.refreshCompleted();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: networkColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: white,
          ),
        ),
        title: Text(
          'Ангилал, зэрэглэл',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: networkColor,
              ),
            )
          : Column(
              children: [
                SearchButton(
                  color: networkColor,
                ),
                Expanded(
                  child: SmartRefresher(
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
                      child: business.rows?.length != 0
                          ? Column(
                              children: business.rows!
                                  .map(
                                    (data) => ClientClassificationCard(
                                      onClick: () {
                                        Navigator.of(context).pushNamed(
                                          ClientClassificationDetail.routeName,
                                          arguments:
                                              ClientClassificationDetailArguments(
                                            id: data.id,
                                          ),
                                        );
                                      },
                                      data: data,
                                      index: business.rows!.indexOf(data),
                                      startAnimation: startAnimation,
                                    ),
                                  )
                                  .toList(),
                            )
                          : NotFound(
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
