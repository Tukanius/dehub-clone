import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/bugd.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/gereet.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/gereet_bish.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerChoose extends StatefulWidget {
  static const routeName = '/customerchoose';
  const CustomerChoose({super.key});

  @override
  State<CustomerChoose> createState() => _CustomerChooseState();
}

class _CustomerChooseState extends State<CustomerChoose> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: buttonColor2,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: buttonColor2,
                padding: const EdgeInsets.all(13),
                child: SvgPicture.asset(
                  'images/close.svg',
                  height: 30,
                ),
              ),
            ),
            title: Text(
              'Харилцагч сонгох',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            centerTitle: true,
            actions: [
              AddButton(
                onClick: () {},
              ),
            ],
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        color: white,
                        child: TabBar(
                          labelColor: buttonColor2,
                          unselectedLabelColor: grey3,
                          indicatorColor: buttonColor2,
                          tabs: [
                            Container(
                              alignment: Alignment.center,
                              height: 48,
                              child: Text('Бүгд'),
                            ),
                            Container(
                              child: Text('Гэрээт'),
                            ),
                            Container(
                              child: Text('Гэрээт биш'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: white,
                        height: 50,
                        padding: const EdgeInsets.only(
                            left: 16, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: grey3.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.search,
                                  size: 20,
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: grey3.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 8),
                                child: SvgPicture.asset(
                                  'images/yuluur.svg',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Bugd(),
                Gereet(),
                GereetBish(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
