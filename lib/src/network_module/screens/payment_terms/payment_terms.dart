import 'dart:async';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/src/network_module/components/set_payment_term_card/set_payment_term_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/src/network_module/screens/payment_terms/set_payment_term_detail/set_payment_term_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaymentTerms extends StatefulWidget {
  static const routeName = '/PaymentTerms';
  const PaymentTerms({super.key});

  @override
  State<PaymentTerms> createState() => _PaymentTermsState();
}

class _PaymentTermsState extends State<PaymentTerms> with AfterLayoutMixin {
  bool startAnimation = false;
  int page = 1;
  Timer? timer;
  int limit = 10;
  User user = User();
  bool isLoading = true;
  Result network = Result(rows: [], count: 0);
  RefreshController refreshController = RefreshController();
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

  onChange(String value) {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        isLoading = true;
      });
      list(page, limit, value);
    });
  }

  void onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
    refreshController.loadComplete();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit, '');
    refreshController.refreshCompleted();
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
        centerTitle: true,
        title: const Text(
          'Төлбөрийн нөхцөл',
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
                  child: CircularProgressIndicator(
                    color: networkColor,
                  ),
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
                                        SetPaymentTermCard(
                                          onClick: user.currentBusiness?.type ==
                                                  "SUPPLIER"
                                              ? () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    SetPaymentTermDetail
                                                        .routeName,
                                                    arguments:
                                                        SetPaymentTermDetailArguments(
                                                      id: data.id,
                                                      listenController:
                                                          listenController,
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
                              module: 'NETWORK',
                              labelText: "Хоосон байна",
                            ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
