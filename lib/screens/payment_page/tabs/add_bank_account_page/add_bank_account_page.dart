import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/bank_account_card/bank_account_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/account_info_page/account_info_page.dart';
import 'package:dehub/screens/link_account_page/link_account_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddBankAccountPage extends StatefulWidget {
  static const routeName = '/addbankaccountpage';
  const AddBankAccountPage({Key? key}) : super(key: key);

  @override
  _AddBankAccountPageState createState() => _AddBankAccountPageState();
}

User user = User();

class _AddBankAccountPageState extends State<AddBankAccountPage>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result payment = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  list(page, limit) async {
    Filter filter = Filter(query: '');
    Offset offset = Offset(page: page, limit: limit);
    var res = await PaymentApi()
        .bankAccountList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      payment = res;
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
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
    user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(color: paymentColor),
            )
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              header: WaterDropHeader(
                waterDropColor: paymentColor,
              ),
              onRefresh: _onRefresh,
              // onLoading: _onLoading,
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
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(15),
                                child: Text(
                                  'Холбосон данснууд',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              AddButton(
                                color: paymentColor,
                                addColor: white,
                                onClick: () {
                                  Navigator.of(context)
                                      .pushNamed(LinkAccountPage.routeName);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          CarouselSlider(
                            items: payment.rows!
                                .map(
                                  (data) => BankAccountCard(
                                    data: data,
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        AccountInfoPage.routeName,
                                        arguments: AccountInfoPageArguments(
                                          id: data.id,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 2.5,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
